###
  ztc-reader-spec.js
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

{expect, assert} = require "chai"
through = require "through"
ZtcReader = require "../../lib/ztc/ztc-reader"
ZtcFrame = require "../../lib/ztc/ztc-frame"
SaveConfirm = require "../../lib/ztc/frames/ztc/saveconfirm"

describe "ZtcReader", () ->
  fixture = null
  ztcStream = null

  beforeEach () ->
    ztcStream = through().pause()
    fixture = new ZtcReader ztcStream

  describe "#message event", () ->
    it "should raise a message event when a valid buffer is available.", (done) ->
      buffer = new Buffer [0x02, 0xA4, 0xE4, 0x01, 0x00, 0x41]
      fixture.once "frame", (message) ->
        expect(message).to.not.be.undefined
        expect(message).to.be.instanceof SaveConfirm
        done()
      fixture.once "error", () ->
        assert.fail()
        done()
      ztcStream.queue(buffer).resume()

    it "should raise a message event when a misaligned buffer is available.", (done) ->
      buffer = new Buffer [0x34, 0x27, 0x16, 0x02, 0x50, 0x01, 0x01, 0x27, 0x77]
      fixture.once "frame", (message) ->
        expect(message).to.not.be.undefined
        expect(message).to.be.instanceof ZtcFrame
        done()
      fixture.once "error", () ->
        assert.fail()
        done()
      ztcStream.queue(buffer).resume()

  describe "#error event", () ->
    it "should raise no event when a buffer with invalid checksum is available.", (done) ->
      buffer = new Buffer [0x02, 0x50, 0x01, 0x01, 0x27, 0x32]
      fixture.once "frame", () ->
        assert.fail()
        done()
      fixture.once "error", () ->
        assert.fail()
        done()
      ztcStream.queue(buffer).resume()
      process.nextTick(done)