###
  aps-spec.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###
{expect} = require "chai"
ZtcParser = require "../../../lib/ztc/ztc-parser"
ZtcBuilder = require "../../../lib/ztc/ztc-builder"
{IEEEAddress} = require "../../../lib/ztc/datatypes"
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
