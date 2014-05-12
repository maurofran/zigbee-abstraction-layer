###
  aps-spec.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###
{expect} = require "chai"
ZtcParser = require "../../../lib/ztc/ztc-parser"
ZtcBuilder = require "../../../lib/ztc/ztc-builder"
{IEEEAddress, Key} = require "../../../lib/ztc/datatypes"
APS = require("../../../lib/ztc/frames").APS;

describe "APS", () ->

  describe "ClearDeviceKeyPairSet", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        ieeeAddress = new IEEEAddress "00005E0000000001"
        request = new APS.ClearDeviceKeyPairSet.Request ieeeAddress
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x3F, 0x08,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APS.ClearDeviceKeyPairSet.Confirm
          expect(@vars.frame.apsSetStatus).to.be.equal 0x00
          done()
        parser.write new Buffer([0x02, 0xA4, 0x3F, 0x01, 0x00, 0x00])

  describe "ConfirmId", () ->
    describe "Report", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APS.ConfirmId.Report
          expect(@vars.frame.assignedConfirmId).to.be.equal 0x4e
          done()
        parser.write new Buffer([0x02, 0x9D, 0x03, 0x01, 0x4e, 0x00])

  describe "DataFragment", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APS.DataFragment.Request 1, true, new Buffer([0x34, 0x23, 0x42])
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x9C, 0x01,
                                                              0x06, 0x01, 0x01, 0x03, 0x34, 0x23, 0x42])

    describe "Indication", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APS.DataFragment.Indication
          expect(@vars.frame.blockNumber).to.be.equal 0x02
          expect(@vars.frame.moreBlocks).to.be.equal true
          expect(@vars.frame.data).to.be.deep.equal new Buffer([0x43, 0x56, 0x79])
          done()
        parser.write new Buffer([0x02, 0x9D, 0x02, 0x06, 0x02, 0x01, 0x03, 0x43, 0x56, 0x79, 0x00])

  describe "DeregisterEndpoint", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APS.DeregisterEndpoint.Request 0x02
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x0A, 0x01, 0x02])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APS.DeregisterEndpoint.Confirm
          expect(this.vars.frame.status).to.be.equal 0x00
          done()
        parser.write new Buffer([0x02, 0xA4, 0x0A, 0x01, 0x00, 0x00])

  describe "GetDeviceKeyPairSet", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APS.GetDeviceKeyPairSet.Request new IEEEAddress("00005E0000000001")
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x3B, 0x08,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APS.GetDeviceKeyPairSet.Confirm
          expect(@vars.frame.ieeeAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.apsKeyType).to.be.equal 0x00
          expect(@vars.frame.incomingFrameCounter).to.be.equal 0x00000134
          expect(@vars.frame.outgoingFrameCounter).to.be.equal 0x00023560
          expect(@vars.frame.apsDeviceKey).to.be.deep.equal new Key("00000000000000001111111122222222")
          done()
        parser.write new Buffer([0x02, 0xA4, 0x3B, 0x21,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x00,
                                 0x34, 0x01, 0x00, 0x00,
                                 0x60, 0x35, 0x02, 0x00,
                                 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                 0x11, 0x11, 0x11, 0x11, 0x22, 0x22, 0x22, 0x22,
                                 0x00])

  describe "GetEndpointDescription", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APS.GetEndpointDescription.Request 0x23
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x0D, 0x01, 0x23])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APS.GetEndpointDescription.Confirm
          expect(@vars.frame.status).to.be.deep.equal 0x00
          expect(@vars.frame.endpoint).to.be.equal 0x23
          expect(@vars.frame.applicationProfileId).to.be.equal 0x33
          expect(@vars.frame.applicationDeviceId).to.be.equal 0x12
          expect(@vars.frame.applicationDeviceAndVersionFlags).to.be.equal 0x02
          expect(@vars.frame.inClusters).to.be.deep.equal [0x0032, 0x0135]
          expect(@vars.frame.outClusters).to.be.deep.equal [0x1423, 0x4450, 0x9081]
          done()
        parser.write new Buffer([0x02, 0xA4, 0x0D, 0x13,
                                 0x00,
                                 0x23,
                                 0x33, 0x00,
                                 0x12, 0x00
                                 0x02,
                                 0x02, 0x32, 0x00, 0x35, 0x01
                                 0x03, 0x23, 0x14, 0x50, 0x44, 0x81, 0x90
                                 0x00])

  describe "GetEndpointIdList", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APS.GetEndpointIdList.Request
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x0E, 0x00])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APS.GetEndpointIdList.Confirm
          expect(@vars.frame.status).to.be.deep.equal 0x00
          expect(@vars.frame.endpointList).to.be.deep.equal [0x33, 0x12]
          done()
        parser.write new Buffer([0x02, 0xA4, 0x0E, 0x04,
                                 0x00,
                                 0x02,
                                 0x33, 0x12,
                                 0x00])

  describe "GetEPMaxWindowSize", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APS.GetEPMaxWindowSize.Request 0x02
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x09, 0x01, 0x02])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APS.GetEPMaxWindowSize.Confirm
          expect(@vars.frame.status).to.be.deep.equal 0x00
          expect(@vars.frame.windowSize).to.be.equal 0x12
          done()
        parser.write new Buffer([0x02, 0xA4, 0x09, 0x02,
                                 0x00,
                                 0x12,
                                 0x00])

  describe "GetMaxApplicationPayload", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APS.GetMaxApplicationPaylod.Request 0x01, new IEEEAddress("00005E0000000001"), 0x02,
                                                          0x1234, 0x5678, 0x03, 0x08, 0x9ABC, 0xF5, 0x03
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x27, 0x14,
                                                              0x01,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x02, 0x34, 0x12, 0x78, 0x56,
                                                              0x03, 0x08, 0xBC, 0x9A, 0xF5, 0x03])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APS.GetMaxApplicationPaylod.Confirm
          expect(@vars.frame.maxPayload).to.be.equal 0x59
          done()
        parser.write new Buffer([0x02, 0xA4, 0x27, 0x01, 0x59, 0x00])

  describe "GetNumberOfEndpoints", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APS.GetNumberOfEndpoints.Request
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x0C, 0x00])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APS.GetNumberOfEndpoints.Confirm
          expect(@vars.frame.status).to.be.equal 0x00
          expect(@vars.frame.activeEndpoints).to.be.equal 0x02
          done()
        parser.write new Buffer([0x02, 0xA4, 0x0C, 0x02, 0x00, 0x02, 0x00])
