###
  ztc-writer-spec.js
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###
{expect} = require "chai"
{WritableStream} = require "memory-streams"
ZtcWriter = require "../../lib/ztc/ztc-writer"
ReadSAS = require "../../lib/ztc/frames/ztc/read-sas-request"

describe "ZtcWriter", () ->
  fixture = null
  ztcStream = null

  beforeEach () ->
    ztcStream = new WritableStream
    fixture = new ZtcWriter ztcStream


  describe "#writeMessage(frame, callback)", () ->
    it "should write a valid message when a frame is provided.", (done) ->
      frame = new ReadSAS ReadSAS.Source.ROM
      expected = new Buffer [0x02, 0x50, 0x02, 0x01, 0x01, 0x52]
      fixture.writeFrame frame
      process.nextTick () ->
        expect(ztcStream.toBuffer()).to.be.deep.equal expected
        done()
