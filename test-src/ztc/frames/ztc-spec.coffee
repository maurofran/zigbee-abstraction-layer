###
  ZTC-spec.js
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

{expect} = require "chai"
ZtcParser = require "../../../lib/ztc/ztc-parser"
ZtcBuilder = require "../../../lib/ztc/ztc-builder"
{IEEEAddress, ShortAddress, PANId} = require "../../../lib/ztc/datatypes"
{ZTC} = require "../../../lib/ztc/frames"

describe "ZTC", () ->

  describe "AddToAddressMap", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        ieeeAddress = new IEEEAddress "00005E0000000001"
        shortAddress = new ShortAddress "0001"
        request = new ZTC.AddToAddressMap.Request ieeeAddress, shortAddress
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0xC0, 0x0A,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x00, 0x01])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.AddToAddressMap.Confirm
          expect(this.vars.frame.status).to.be.equal 0xFD
          done()
        parser.write new Buffer([0x02, 0xA4, 0xC0, 0x01, 0xFD, 0x00])

  describe "CPUReset", () ->
    it "should write a buffer", () ->
      builder = new ZtcBuilder
      request = new ZTC.CPUReset
      request.write(builder);
      expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x08, 0x00])

  describe "DebugEvent", () ->
    it "should read from a buffer", (done) ->
      parser = new ZtcParser
      parser.ztcFrame "frame"
      parser.tap () ->
        expect(this.vars.frame).to.be.instanceof ZTC.DebugEvent
        expect(this.vars.frame.messageAddress).to.be.equal 0x3708
        expect(this.vars.frame.status).to.be.equal 0x00
        expect(this.vars.frame.opCodeGroup).to.be.equal 0xA3
        expect(this.vars.frame.opCode).to.be.equal 0xC0
        expect(this.vars.frame.data).to.be.deep.equal(
          new Buffer("0000000000000000000000000000000000000000000000000000000000000000", "hex"))
        done()
      parser.write new Buffer([0x02, 0xA4, 0xFF, 0x25,
                               0x08, 0x37, 0x00, 0xA3, 0xC0,
                               0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                               0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                               0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                               0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                               0x45])

  describe "ErrorEvent", () ->
    it "should read from a buffer", (done) ->
      parser = new ZtcParser
      parser.ztcFrame "frame"
      parser.tap () ->
        expect(this.vars.frame.status).to.be.equal 0xF4
        done()
      parser.write new Buffer([0x02, 0xA4, 0xFE, 0x01, 0xF4, 0x00])

  describe "Event", () ->
    it "should read from a buffer", (done) ->
      parser = new ZtcParser
      parser.ztcFrame "frame"
      parser.tap () ->
        expect(this.vars.frame).to.be.instanceof ZTC.Event
        expect(this.vars.frame.status).to.be.equal 0xFF
        expect(this.vars.frame.sapId).to.be.equal 0x01
        done()
      parser.write new Buffer([0x02, 0xA4, 0x04, 0x02, 0xFF, 0x01, 0x00])

  describe "GetChannel", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.GetChannel.Request
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x12, 0x00])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.GetChannel.Confirm
          expect(this.vars.frame.status).to.be.equal 0x00
          expect(this.vars.frame.channel).to.be.equal 0x0E
          done()
        parser.write new Buffer([0x02, 0xA4, 0x12, 0x02, 0x00, 0x0E, 0x00])

  describe "GetMode", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.GetMode.Request
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x02, 0x00])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.GetMode.Confirm
          expect(this.vars.frame.status).to.be.equal 0x00
          expect(this.vars.frame.uartTxBlocking).to.be.equal 0x01
          expect(this.vars.frame.modes.mcps).to.be.equal 0x01
          expect(this.vars.frame.modes.mlme).to.be.equal 0x02
          expect(this.vars.frame.modes.asp).to.be.equal 0x00
          expect(this.vars.frame.modes.nlde).to.be.equal 0x01
          expect(this.vars.frame.modes.nlme).to.be.equal 0x00
          expect(this.vars.frame.modes.apsde).to.be.equal 0x02
          expect(this.vars.frame.modes.apsme).to.be.equal 0x00
          expect(this.vars.frame.modes.afde).to.be.equal 0x01
          expect(this.vars.frame.modes.zdp).to.be.equal 0xFF
          done()
        parser.write new Buffer([0x02, 0xA4, 0x02, 0x0B, 0x00, 0x01,
                                 0x01, 0x02, 0x00, 0x01, 0x00, 0x02, 0x00, 0x01, 0xFF,
                                 0x00])

  describe "GetNumOfMsgs", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.GetNumOfMsgs.Request
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x24, 0x00])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.GetNumOfMsgs.Confirm
          expect(this.vars.frame.smallBuffers).to.be.equal 0x03
          expect(this.vars.frame.bigBuffers).to.be.equal 0x05
          done()
        parser.write new Buffer([0x02, 0xA4, 0x24, 0x02, 0x03, 0x05, 0x00])

  describe "GetPanId", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.GetPanId.Request
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x14, 0x00])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.GetPanId.Confirm
          expect(this.vars.frame.status).to.be.equal 0x00
          expect(this.vars.frame.panId).to.be.deep.equal new PANId("05A4")
          done()
        parser.write new Buffer([0x02, 0xA4, 0x14, 0x03, 0x00, 0x05, 0xA4, 0x00])

  describe "ModeSelect", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.ModeSelect.Request true, 0x01, 0x02, 0x00, 0x02, 0x01, 0x00, 0x02, 0x01, 0x02
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x00, 0x0A, 0x01,
                                                              0x01, 0x02, 0x00, 0x02, 0x01, 0x00, 0x02, 0x01, 0x02])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.ModeSelect.Confirm
          expect(this.vars.frame.status).to.be.equal 0x00
          done()
        parser.write new Buffer([0x02, 0xA4, 0x00, 0x01, 0x00, 0x00])

  describe "NVGetDataSetDesc", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.NVGetDataSetDesc.Request
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0xE5, 0x00])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.NVGetDataSetDesc.Confirm
          expect(this.vars.frame.status).to.be.equal 0
          expect(this.vars.frame.count).to.be.equal 2
          expect(this.vars.frame.datasets.length).to.be.equal 2
          expect(this.vars.frame.datasets[0].size).to.be.equal 5
          expect(this.vars.frame.datasets[0].id).to.be.equal 0x0002
          expect(this.vars.frame.datasets[1].size).to.be.equal 9
          expect(this.vars.frame.datasets[1].id).to.be.equal 0x0507
          done()
        parser.write new Buffer([0x02, 0xA4, 0xE5, 0x08, 0x00, 0x02, 0x05, 0x02, 0x00, 0x09, 0x07, 0x05, 0x00])

  describe "NVGetPageHeaders", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.NVGetPageHeaders.Request
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0xE6, 0x00])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.NVGetPageHeaders.Confirm
          expect(this.vars.frame.status).to.be.equal 0
          expect(this.vars.frame.numberOfPages).to.be.equal 2
          expect(this.vars.frame.headers.length).to.be.equal 2
          expect(this.vars.frame.headers[0].magicNumber).to.be.equal 2
          expect(this.vars.frame.headers[0].sequenceNumber).to.be.equal 1
          expect(this.vars.frame.headers[0].dataSetId).to.be.equal 3
          expect(this.vars.frame.headers[1].magicNumber).to.be.equal 0x0103
          expect(this.vars.frame.headers[1].sequenceNumber).to.be.equal 0x0507
          expect(this.vars.frame.headers[1].dataSetId).to.be.equal 0x090B
          done()
        parser.write new Buffer([0x02, 0xA4, 0xE6, 0x0E, 0x00, 0x02,
                                 0x02, 0x00, 0x01, 0x00, 0x03, 0x00,
                                 0x03, 0x01, 0x07, 0x05, 0x0B, 0x09,
                                 0x00])

  describe "Ping", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.Ping.Request new Buffer([0x03, 0x04, 0x05, 0x06])
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x38, 0x04, 0x03, 0x04, 0x05, 0x06])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.Ping.Confirm
          expect(this.vars.frame.data).to.be.deep.equal new Buffer([0x03, 0x04, 0x05, 0x06])
          done()
        parser.write new Buffer([0x02, 0xA4, 0x38, 0x04, 0x03, 0x04, 0x05, 0x06, 0x00])

  describe "RadioRegisterRead", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.RadioRegisterRead.Request 0x27
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x3A, 0x01, 0x27])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.RadioRegisterRead.Confirm
          expect(this.vars.frame.value).to.be.equal 0x37
          done()
        parser.write new Buffer([0x02, 0xA4, 0x3A, 0x01, 0x37, 0x00, 0x00])

  describe "RadioRegisterWrite", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.RadioRegisterWrite.Request 0x27, 0x3245
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x39, 0x03, 0x27, 0x45, 0x32])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.RadioRegisterWrite.Confirm
          expect(this.vars.frame.status).to.be.equal 0x00
          done()
        parser.write new Buffer([0x02, 0xA4, 0x39, 0x01, 0x00, 0x00])

  describe "ReadExtAddr", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.ReadExtAddr.Request
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0xD2, 0x00])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.ReadExtAddr.Confirm
          expect(this.vars.frame.status).to.be.equal 0x00
          expect(this.vars.frame.deviceAddr).to.be.deep.equal new IEEEAddress("00005E0000000001")
          done()
        parser.write new Buffer([0x02, 0xA4, 0xD2, 0x09, 0x00, 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00])

  describe "ReadMemoryBlock", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.ReadMemoryBlock.Request 0x3245, 0x02
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x31, 0x03, 0x45, 0x32, 0x02])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.ReadMemoryBlock.Confirm
          expect(this.vars.frame.data).to.be.deep.equal new Buffer("1234", "hex")
          done()
        parser.write new Buffer([0x02, 0xA4, 0x31, 0x02, 0x12, 0x34, 0x00])

  describe "RemoveFromAddressMap", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.RemoveFromAddressMap.Request new IEEEAddress("00005E0000000001")
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0xC1, 0x08,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.RemoveFromAddressMap.Confirm
          expect(this.vars.frame.status).to.be.equal 0x00
          done()
        parser.write new Buffer([0x02, 0xA4, 0xC1, 0x01, 0x00, 0x00])

  describe "SaveConfirm", () ->
    it "should read from a buffer", (done) ->
      parser = new ZtcParser
      parser.ztcFrame "frame"
      parser.tap () ->
        expect(this.vars.frame).to.be.instanceof ZTC.SaveConfirm
        expect(this.vars.frame.status).to.be.equal 0x00
        done()
      parser.write new Buffer([0x02, 0xA4, 0xE4, 0x01, 0x00, 0x00])

  describe "SetChannel", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.SetChannel.Request 14
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x13, 0x01, 0x0E])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.SetChannel.Confirm
          expect(this.vars.frame.status).to.be.equal 0x00
          done()
        parser.write new Buffer([0x02, 0xA4, 0x13, 0x01, 0x00, 0x00])

  describe "SetPanId", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.SetPanId.Request new PANId("1234")
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x15, 0x02, 0x12, 0x34])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.SetPanId.Confirm
          expect(this.vars.frame.status).to.be.equal 0x00
          done()
        parser.write new Buffer([0x02, 0xA4, 0x15, 0x01, 0x00, 0x00])

  describe "WriteExtAddr", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.WriteExtAddr.Request new IEEEAddress("00005E0000000001")
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0xDB, 0x08,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.WriteExtAddr.Confirm
          expect(this.vars.frame.status).to.be.equal 0x00
          done()
        parser.write new Buffer([0x02, 0xA4, 0xDB, 0x01, 0x00, 0x00])

  describe "WriteMemoryBlock", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new ZTC.WriteMemoryBlock.Request 0x1234, new Buffer("56789A", "hex")
        request.write(builder);
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x30, 0x06,
                                                              0x34, 0x12, 0x03, 0x56, 0x78, 0x9A])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(this.vars.frame).to.be.instanceof ZTC.WriteMemoryBlock.Confirm
          expect(this.vars.frame.numberOfBytes).to.be.equal 0x03
          done()
        parser.write new Buffer([0x02, 0xA4, 0x30, 0x01, 0x03, 0x00])
