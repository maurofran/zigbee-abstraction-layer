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
APSME = require("../../../lib/ztc/frames").APSME;

describe "APSME", () ->

  describe "AddGroup", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.AddGroup.Request new ShortAddress("5E01"), 0x27
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xE8, 0x03,
                                                              0x5E, 0x01, 0x27])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.AddGroup.Confirm
          expect(@vars.frame.status).to.be.equal 0x00
          expect(@vars.frame.groupId).to.be.deep.equal new ShortAddress("5E01")
          expect(@vars.frame.endpoint).to.be.equal 0x27
          done()
        parser.write new Buffer([0x02, 0x98, 0xE8, 0x04, 0x00, 0x5E, 0x01, 0x27, 0x00])

  describe "Authenticate", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Authenticate.Request new IEEEAddress("00005E0000000001"), 0x00,
                                                 new Buffer("0123456789ABCDEF0123456789ABCDEF", "hex")
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xF5, 0x19,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x00,
                                                              0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF,
                                                              0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.Authenticate.Confirm
          expect(@vars.frame.partnerAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.status).to.be.equal 0x00
          done()
        parser.write new Buffer([0x02, 0x98, 0xF7, 0x09,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x00, 0x00])

    describe "Indication", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.Authenticate.Indication
          expect(@vars.frame.initiatorAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.randomChallenge).to.be.deep.equal new Buffer("0123456789ABCDEF0123456789ABCDEF", "hex")
          done()
        parser.write new Buffer([0x02, 0x98, 0xF6, 0x18,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF,
                                 0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF,
                                 0x00])

  describe "Bind", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Bind.Request new IEEEAddress("00005E0000000001"), 0x01, 0x1234,
                                         0x27, new IEEEAddress("00005E0000000002"), 0x03
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0x00, 0x15,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x01,
                                                              0x34, 0x12,
                                                              0x27,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02,
                                                              0x03])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.Bind.Confirm
          expect(@vars.frame.status).to.be.equal 0x00
          expect(@vars.frame.srcAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.srcEndpoint).to.be.equal 0x02
          expect(@vars.frame.clusterId).to.be.equal 0x1234
          expect(@vars.frame.dstAddrMode).to.be.equal 0x27
          expect(@vars.frame.dstAddress).to.be.deep.equal new IEEEAddress("00005E0000000002")
          expect(@vars.frame.dstEndpoint).to.be.equal 0x03
          done()
        parser.write new Buffer([0x02, 0x98, 0x07, 0x16,
                                 0x00,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x02,
                                 0x34, 0x12,
                                 0x27,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02,
                                 0x03,
                                 0x00])

  describe "EstablishKey", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.EstablishKey.Request new IEEEAddress("00005E0000000001"), false, null,
                                                 APSME.EstablishKey.Request.Method.SKKE
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xCF, 0x12,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x00,
                                                              0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                                              0x00])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.EstablishKey.Confirm
          expect(@vars.frame.address).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.status).to.be.equal 0x00
          done()
        parser.write new Buffer([0x02, 0x98, 0xD5, 0x09,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x00,
                                 0x00])

    describe "Indication", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.EstablishKey.Indication
          expect(@vars.frame.initiatorAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.method).to.be.equal APSME.EstablishKey.Indication.Method.SKKE
          done()
        parser.write new Buffer([0x02, 0x98, 0xD6, 0x09,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x00,
                                 0x00])

    describe "Response", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.EstablishKey.Response new IEEEAddress("00005E0000000001"), true
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xD0, 0x09,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x01])

  describe "Get", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Get.Request APSME.Get.Request.Id.APS_ADDRESS_MAP, 1, 2, 0
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x20, 0x04,
                                                              0xC0, 0x01, 0x02, 0x00])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.Get.Confirm
          expect(@vars.frame.status).to.be.equal APSME.Get.Confirm.Status.SUCCESS
          expect(@vars.frame.id).to.be.equal APSME.Get.Confirm.Id.APS_ADDRESS_MAP
          expect(@vars.frame.index).to.be.equal 1
          expect(@vars.frame.entries).to.be.equal 1
          expect(@vars.frame.entrySize).to.be.equal 3
          expect(@vars.frame.data).to.be.deep.equal new Buffer("010203", "hex")
          done()
        parser.write new Buffer([0x02, 0xA4, 0x20, 0x0A,
                                 0x00,
                                 0xC0,
                                 0x01,
                                 0x01,
                                 0x03,
                                 0x03, 0x00,
                                 0x01, 0x02, 0x03,
                                 0x00])

  describe "RemoveAllGroups", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.RemoveAllGroups.Request 0x29
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xEA, 0x01, 0x29])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.RemoveAllGroups.Confirm
          expect(@vars.frame.status).to.be.equal APSME.RemoveAllGroups.Confirm.Status.SUCCESS
          expect(@vars.frame.endpoint).to.be.equal 0x29
          done()
        parser.write new Buffer([0x02, 0x98, 0xEA, 0x02, 0x00, 0x29, 0x00])

  describe "RemoveDevice", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.RemoveDevice.Request new IEEEAddress("00005E0000000001"),
                                                 new IEEEAddress("00005E0000000002")
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xF4, 0x10,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02])

    describe "Indication", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.RemoveDevice.Indication
          expect(@vars.frame.srcAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.childAddress).to.be.deep.equal new IEEEAddress("00005E0000000002")
          done()
        parser.write new Buffer([0x02, 0x98, 0xD8, 0x10,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02,
                                 0x00])

  describe "RemoveGroup", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.RemoveGroup.Request new ShortAddress("5E01"), 0x27
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xE9, 0x03,
                                                              0x5E, 0x01, 0x27])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.RemoveGroup.Confirm
          expect(@vars.frame.status).to.be.equal APSME.RemoveGroup.Confirm.Status.SUCCESS
          expect(@vars.frame.groupId).to.be.deep.equal new ShortAddress("5E01")
          expect(@vars.frame.endpoint).to.be.equal 0x27
          done()
        parser.write new Buffer([0x02, 0x98, 0xE9, 0x04, 0x00, 0x5E, 0x01, 0x27, 0x00])