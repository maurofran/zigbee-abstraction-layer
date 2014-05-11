###
  ztc-stream-spec.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

{expect} = require "chai"
ZtcStream = require "../../lib/ztc/ztc-stream"
{ReadableStream} = require "memory-streams"
{WritableStream} = require "memory-streams"

describe "ZtcStream", () ->
  fixture = null

  describe "Mode CALCULATE", () ->
    beforeEach () ->
      fixture = new ZtcStream { mode: ZtcStream.Mode.CALCULATE }

    it "should calculate and write the checksum on full packet chunk.", (done) ->
      reader = new ReadableStream new Buffer([0x02, 0x50, 0x02, 0x01, 0x01])
      fixture.on "readable", () ->
        data = fixture.read()
        expect(data).to.be.not.null
        expect(data).to.be.deep.equal new Buffer([0x52]) if data.length is 1
        expect(data).to.be.deep.equal new Buffer([0x02, 0x50, 0x02, 0x01, 0x01]) unless data.length is 1
        done() if data.length is 1
      reader.pipe fixture

    it "should calculate and write the checksum on fragmented packet.", (done) ->
      reader = new ReadableStream new Buffer([0x02, 0x50, 0x02])
      writer = new WritableStream
      reader.pipe(fixture).pipe(writer)
      reader.append new Buffer([0x01, 0x01])
      process.nextTick () ->
        expect(writer.toBuffer()).to.be.deep.equal new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52])
        done()

    it "should calculate and write the checksum on bigger packet.", (done) ->
      reader = new ReadableStream new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x45])
      writer = new WritableStream
      reader.pipe(fixture).pipe(writer)
      process.nextTick () ->
        expect(writer.toBuffer()).to.be.deep.equal new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52])
        done()

    it "should calculate and write the checksum on two consecutive packets.", (done) ->
      reader = new ReadableStream new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x02, 0x50])
      writer = new WritableStream
      reader.pipe(fixture).pipe(writer)
      process.nextTick () ->
        expect(writer.toBuffer()).to.be.deep.equal new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52, 0x02, 0x50])
        reader.append new Buffer([0x02, 0x01, 0x01])
        process.nextTick () ->
          expect(writer.toBuffer()).to.be.deep.equal new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52, 0x02, 0x50, 0x02,
                                                                 0x01, 0x01, 0x52])
          done()

  describe "Mode VERIFY", () ->
    beforeEach () ->
      fixture = new ZtcStream { mode: ZtcStream.Mode.VERIFY }

    it "should verify and write the packet on full packet chunk with valid checksum.", (done) ->
      reader = new ReadableStream new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52])
      writer = new WritableStream
      reader.pipe(fixture).pipe(writer)
      process.nextTick () ->
        expect(writer.toBuffer()).to.be.deep.equal new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52])
        done()

    it "should verify and drop the packet on full packet chunk with invalid checksum.", (done) ->
      reader = new ReadableStream new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x53])
      writer = new WritableStream
      reader.pipe(fixture).pipe(writer)
      process.nextTick () ->
        expect(writer.toBuffer()).to.be.deep.equal new Buffer(0)
        done()

    it "should verify and write the packet on fragmented packet with valid checksum.", (done) ->
      reader = new ReadableStream new Buffer([0x02, 0x50, 0x02])
      writer = new WritableStream
      reader.pipe(fixture).pipe(writer)
      reader.append new Buffer([0x01, 0x01, 0x52])
      process.nextTick () ->
        expect(writer.toBuffer()).to.be.deep.equal new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52])
        done()

    it "should verify and drop the packet on fragmented packet with invalid checksum.", (done) ->
      reader = new ReadableStream new Buffer([0x02, 0x50, 0x02])
      writer = new WritableStream
      reader.pipe(fixture).pipe(writer)
      reader.append new Buffer([0x01, 0x01, 0x523])
      process.nextTick () ->
        expect(writer.toBuffer()).to.be.deep.equal new Buffer(0)
        done()

    it "should verify and write the packet on bigger packet with valid checksum.", (done) ->
      reader = new ReadableStream new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x052, 0x45])
      writer = new WritableStream
      reader.pipe(fixture).pipe(writer)
      process.nextTick () ->
        expect(writer.toBuffer()).to.be.deep.equal new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52])
        done()

    it "should verify and drop the packet on bigger packet with invalid checksum.", (done) ->
      reader = new ReadableStream new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x053, 0x45])
      writer = new WritableStream
      reader.pipe(fixture).pipe(writer)
      process.nextTick () ->
        expect(writer.toBuffer()).to.be.deep.equal new Buffer(0)
        done()

    it "should verify and write the packets on two consecutive packets with valid checksum.", (done) ->
      reader = new ReadableStream new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x52, 0x02, 0x50])
      writer = new WritableStream
      reader.pipe(fixture).pipe(writer)
      process.nextTick () ->
        expect(writer.toBuffer()).to.be.deep.equal new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52])
        reader.append new Buffer([0x02, 0x01, 0x01, 0x52])
        process.nextTick () ->
          expect(writer.toBuffer()).to.be.deep.equal new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52, 0x02, 0x50, 0x02,
                                                                 0x01, 0x01, 0x52])
          done()

    it "should verify and drop the first packets on two consecutive packets.", (done) ->
      reader = new ReadableStream new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x53, 0x02, 0x50])
      writer = new WritableStream
      reader.pipe(fixture).pipe(writer)
      process.nextTick () ->
        expect(writer.toBuffer()).to.be.deep.equal new Buffer(0)
        reader.append new Buffer([0x02, 0x01, 0x01, 0x52])
        process.nextTick () ->
          expect(writer.toBuffer()).to.be.deep.equal new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52])
          done()

    it "should verify and drop all packets on two consecutive packets on invalid checksum.", (done) ->
      reader = new ReadableStream new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x53, 0x02, 0x50])
      writer = new WritableStream
      reader.pipe(fixture).pipe(writer)
      process.nextTick () ->
        expect(writer.toBuffer()).to.be.deep.equal new Buffer(0)
        reader.append new Buffer([0x02, 0x01, 0x01, 0x54])
        process.nextTick () ->
          expect(writer.toBuffer()).to.be.deep.equal new Buffer(0)
          done()