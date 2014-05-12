###
  apsde-spec.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

{expect} = require "chai"
moment = require "moment"
ZtcParser = require "../../../lib/ztc/ztc-parser"
ZtcBuilder = require "../../../lib/ztc/ztc-builder"
{IEEEAddress, ShortAddress} = require "../../../lib/ztc/datatypes"
APSDE = require("../../../lib/ztc/frames").APSDE;

describe "APSDE", () ->
  describe "Data", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        ieeeAddress = new IEEEAddress "00005E0000000001"
        data = new Buffer([0x05, 0x06, 0x07]);
        request = new APSDE.Data.Request 0x01, ieeeAddress, 0x02, 0xA034, 0x1042, 0x01, data, 0x00, 0x03
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x9C, 0x00, 0x15,
                                                              0x01,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x02,
                                                              0x34, 0xA0,
                                                              0x42, 0x10,
                                                              0x01,
                                                              0x03, 0x05, 0x06, 0x07,
                                                              0x00,
                                                              0x03])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame.dstAddrMode).to.be.equal 0x01
          expect(@vars.frame.dstAddress).to.be.deep.equal new ShortAddress(new Buffer([0x01, 0x00]))
          expect(@vars.frame.dstEndpoint).to.be.equal 0x00
          expect(@vars.frame.srcAddrMode).to.be.equal 0x02
          expect(@vars.frame.srcAddress).to.be.deep.equal new ShortAddress(new Buffer([0x02, 0x00]))
          expect(@vars.frame.srcEndpoint).to.be.equal 0x37
          expect(@vars.frame.profileId).to.be.equal 0x0005
          expect(@vars.frame.clusterId).to.be.equal 0x0137
          expect(@vars.frame.asduLength).to.be.equal 0x03
          expect(@vars.frame.asdu).to.be.deep.equal new Buffer([0x01, 0x02, 0x03])
          expect(@vars.frame.status).to.be.equal 0x00
          expect(@vars.frame.wasBroadcast).to.be.equal true
          expect(@vars.frame.linkQuality).to.be.equal 0x15
          expect(@vars.frame.rxTime).to.be.deep.equal moment().year(2000).startOf("year").add("s", 1)
          expect(@vars.frame.messageType).to.be.equal 0x34
          expect(@vars.frame.nextBlock).to.be.equal 0x0000
          expect(@vars.frame.dataSize).to.be.equal 0x05
          expect(@vars.frame.dataPointer).to.be.equal 0x0002
          expect(@vars.frame.bufferNumber).to.be.equal 0x01
          done()
        parser.write new Buffer([
          0x02, 0x9D, 0x01, 0x1F,
          0x01, # Destination Address Mode
          0x01, 0x00, # Destination Address
          0x00, # Destination Endpoont
          0x02, # Source Address Mode
          0x02, 0x00, # Source Address
          0x37, # Source Endpoint
          0x05, 0x00, # Profile Id
          0x37, 0x01, # Cluster Id
          0x03, # ASDU length
          0x01, 0x02, 0x03, # ASDU
          0x00, # Status
          0x01, # Was Broadcast
          0x03, # Security Status
          0x15, # Link Quality
          0x01, 0x00, 0x00, 0x00, # RxTime
          0x34, # Message Type
          0x00, 0x00, # Next Block
          0x05, # Data Size
          0x02, 0x00, # Data
          0x01, # Buffer Number
          0x00])
