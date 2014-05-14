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
{IEEEAddress, ShortAddress, Key, PANId} = require "../../../lib/ztc/datatypes"
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

  describe "RequestKey", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.RequestKey.Request new IEEEAddress("00005E0000000001"),
                                               APSME.RequestKey.Request.KeyType.APPLICATION_KEY,
                                               new IEEEAddress("00005E0000000002")
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xD3, 0x11,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x02,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02])

    describe "Indication", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.RequestKey.Indication
          expect(@vars.frame.srcAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.keyType).to.be.equal APSME.RequestKey.Indication.KeyType.APPLICATION_KEY
          expect(@vars.frame.partnerAddress).to.be.deep.equal new IEEEAddress("00005E0000000002")
          done()
        parser.write new Buffer([0x02, 0x98, 0xD9, 0x11,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x02,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02,
                                 0x00])

  describe "Reset", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Reset.Request APSME.Reset.Request.ResetType.RESET_ALL
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0x0B, 0x01, 0x1F])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.Reset.Confirm
          expect(@vars.frame.status).to.be.equal APSME.Reset.Confirm.Status.SUCCESS
          done()
        parser.write new Buffer([0x02, 0x98, 0x0B, 0x01, 0x00, 0x00])

  describe "Set", () ->
    describe "Request", () ->
      it "id SAS_APS_TC_MASTER_KEY should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.SAS_APS_TC_MASTER_KEY, 1,
                                        new Key("1234567890ABCDEF1234567890ABCDEF")
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x14, 0xE7, 0x01, 0x01, 0x00,
                                                              0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF,
                                                              0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF])

      it "id SAS_APS_TC_LINK_KEY should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.SAS_APS_TC_LINK_KEY, 1,
          new Key("1234567890ABCDEF1234567890ABCDEF")
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x14, 0xE8, 0x01, 0x01, 0x00,
                                                              0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF,
                                                              0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF])

      it "id APS_DEVICE_KEY_PAIR_SET should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_DEVICE_KEY_PAIR_SET, 1, [{
          deviceAddressIndex: 1
          key: new Key("1234567890ABCDEF1234567890ABCDEF")
          keyType: APSME.Set.Request.KeyType.TRUST_CENTER_MASTER_KEY
          outgoingFrameCounter: 3
          incomingFrameCounter: 1
        }, {
          deviceAddressIndex: 2
          key: new Key("11223344556677889900AABBCCDDEEFF")
          keyType: APSME.Set.Request.KeyType.APPLICATION_MASTER_KEY
          outgoingFrameCounter: 2
          incomingFrameCounter: 5
        }]
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x38, 0xAA, 0x01, 0x02, 0x00,
                                                              0x01,
                                                              0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF,
                                                              0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF,
                                                              0x00,
                                                              0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
                                                              0x02,
                                                              0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
                                                              0x99, 0x00, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF,
                                                              0x02,
                                                              0x02, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00])

      it "id APS_TRUST_CENTER_ADDRESS should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_TRUST_CENTER_ADDRESS, 1,
          new IEEEAddress("00005E0000000001")
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x0C, 0xAB, 0x01, 0x01, 0x00,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01])

      it "id APS_SECURITY_TIMEOUT_PERIOD should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_SECURITY_TIMEOUT_PERIOD, 1, 1234
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x06, 0xAC, 0x01, 0x01, 0x00,
                                                              0xD2, 0x04])

      it "id APS_ADDRESS_MAP should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_ADDRESS_MAP, 1, [{
          ieeeAddress: new IEEEAddress("00005E0000000001")
          networkAddress: new ShortAddress("0001")
        }, {
          ieeeAddress: new IEEEAddress("00005E0000000002")
          networkAddress: new ShortAddress("0003")
        }]
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x18, 0xC0, 0x01, 0x02, 0x00,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x00, 0x01,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02,
                                                              0x00, 0x03])

      it "id APS_BINDING_TABLE should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_BINDING_TABLE, 1, [{
          srcEndpoint: 0x14
          destination: new ShortAddress("0001")
          dstEndpoint: 0x56
          clusters: [0x1234, 0x5678]
        }, {
          srcEndpoint: 0x56
          destination: new ShortAddress("0002")
          dstEndpoint: 0x34
          clusters: [0xABCD, 0xF0CA, 0x4321]
        }]
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x18, 0xC1, 0x01, 0x02, 0x00,
                                                              0x14, 0x00, 0x01, 0x56, 0x02,
                                                              0x34, 0x12, 0x78, 0x56,
                                                              0x56, 0x00, 0x02, 0x34, 0x03,
                                                              0xCD, 0xAB, 0xCA, 0xF0, 0x21, 0x43])

      it "id APS_DESIGNATED_COORDINATOR should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_DESIGNATED_COORDINATOR, 1, true
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x05, 0xC2, 0x01, 0x01, 0x00, 0x01])

      it "id APS_CHANNEL_MASK should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_CHANNEL_MASK, 1, 0x01020304
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x08, 0xC3, 0x01, 0x01, 0x00,
                                                              0x04, 0x03, 0x02, 0x01])

      it "id APS_USE_EXTENDED_PAN_ID should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_USE_EXTENDED_PAN_ID, 1,
                                        new IEEEAddress("00005E0000000001")
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x0C, 0xC4, 0x01, 0x01, 0x00,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01])

      it "id APS_GROUP_TABLE should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_GROUP_TABLE, 1, [{
          groupId: new ShortAddress("0001")
          endpoint: 0x56
        }, {
          groupId: new ShortAddress("0002")
          endpoint: 0x34
        }]
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x0A, 0xC5, 0x01, 0x02, 0x00,
                                                              0x00, 0x01, 0x56,
                                                              0x00, 0x02, 0x34])

      it "id APS_NONMEMBER_RADIUS should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_NONMEMBER_RADIUS, 1, 0x09
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x05, 0xC6, 0x01, 0x01, 0x00, 0x09])

      it "id APS_USE_INSECURE_JOIN should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_USE_INSECURE_JOIN, 1, true
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x05, 0xC8, 0x01, 0x01, 0x00, 0x01])

      it "id APS_INTERFRAME_DELAY should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_INTERFRAME_DELAY, 1, 0x27
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x05, 0xC9, 0x01, 0x01, 0x00, 0x27])

      it "id APS_MAX_WINDOW_SIZE should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_MAX_WINDOW_SIZE, 1, 0x59
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x05, 0xCD, 0x01, 0x01, 0x00, 0x59])

      it "id APS_MAX_FRAGMENT_LENGTH should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Set.Request APSME.Set.Request.Id.APS_MAX_FRAGMENT_LENGTH, 1, 0x12
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0xA3, 0x21, 0x05, 0xCE, 0x01, 0x01, 0x00, 0x12])

    describe "Confirm", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.Set.Confirm
          expect(@vars.frame.status).to.be.equal APSME.Set.Confirm.Status.SUCCESS
          done()
        parser.write new Buffer([0x02, 0xA4, 0x21, 0x01, 0x00, 0x00])

  describe "SwitchKey", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.SwitchKey.Request new IEEEAddress("00005E0000000001"), 0x23
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xD4, 0x09,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x23])

    describe "Indication", () ->
      it "should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.SwitchKey.Indication
          expect(@vars.frame.srcAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.keySeqNumber).to.be.deep.equal 0x27
          done()
        parser.write new Buffer([0x02, 0x98, 0xF1, 0x09,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x27,
                                 0x00])

  describe "TransportKey", () ->
    describe "Request", () ->
      it "TRUST_CENTER_MASTER_KEY should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.TransportKey.Request APSME.TransportKey.Request.KeyType.TRUST_CENTER_MASTER_KEY,
          destAddress: new IEEEAddress("00005E0000000001")
          parentAddress: new IEEEAddress("00005E0000000002")
          tcMasterKey: new Key("00112233445566778899AABBCCDDEEFF")
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xD1, 0x22, 0x00,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02,
                                                              0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                                                              0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF])

      it "NETWORK_KEY should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.TransportKey.Request APSME.TransportKey.Request.KeyType.NETWORK_KEY,
          destAddress: new IEEEAddress("00005E0000000001")
          keySeqNumber: 1,
          networkKey: new Key("00112233445566778899AABBCCDDEEFF")
          useParent: true
          parentAddress: new IEEEAddress("00005E0000000002")
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xD1, 0x24, 0x01,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x01,
                                                              0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                                                              0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF,
                                                              0x01,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02])

      it "APPLICATION_MASTER_1_LINK_KEY should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.TransportKey.Request APSME.TransportKey.Request.KeyType.APPLICATION_MASTER_1_LINK_KEY,
          destAddress: new IEEEAddress("00005E0000000001")
          partnerAddress: new IEEEAddress("00005E0000000002")
          initiator: true
          key: new Key("00112233445566778899AABBCCDDEEFF")
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xD1, 0x23, 0x02,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02,
                                                              0x01,
                                                              0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                                                              0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF])

      it "APPLICATION_MASTER_2_LINK_KEY should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.TransportKey.Request APSME.TransportKey.Request.KeyType.APPLICATION_MASTER_2_LINK_KEY,
          destAddress: new IEEEAddress("00005E0000000001")
          partnerAddress: new IEEEAddress("00005E0000000002")
          initiator: true
          key: new Key("00112233445566778899AABBCCDDEEFF")
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xD1, 0x23, 0x03,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02,
                                                              0x01,
                                                              0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                                                              0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF])

      it "HIGH_SECURITY_NETWORK_KEY should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.TransportKey.Request APSME.TransportKey.Request.KeyType.HIGH_SECURITY_NETWORK_KEY,
          destAddress: new IEEEAddress("00005E0000000001")
          keySeqNumber: 1,
          networkKey: new Key("00112233445566778899AABBCCDDEEFF")
          useParent: true
          parentAddress: new IEEEAddress("00005E0000000002")
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0xD1, 0x24, 0x05,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                                              0x01,
                                                              0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                                                              0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF,
                                                              0x01,
                                                              0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02])

    describe "Indication", () ->
      it "TRUST_CENTER_MASTER_KEY should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.TransportKey.Indication
          expect(@vars.frame.srcAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.keyType).to.be.equal APSME.TransportKey.Indication.KeyType.TRUST_CENTER_MASTER_KEY
          expect(@vars.frame.tcMasterKey).to.be.deep.equal new Key("00112233445566778899AABBCCDDEEFF")
          done()
        parser.write new Buffer([0x02, 0x98, 0xF2, 0x19,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x00,
                                 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                                 0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF,
                                 0x00])

      it "NETWORK_KEY should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.TransportKey.Indication
          expect(@vars.frame.srcAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.keyType).to.be.equal APSME.TransportKey.Indication.KeyType.NETWORK_KEY
          expect(@vars.frame.keySeqNumber).to.be.equal 2
          expect(@vars.frame.networkKey).to.be.deep.equal new Key("00112233445566778899AABBCCDDEEFF")
          done()
        parser.write new Buffer([0x02, 0x98, 0xF2, 0x1A,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x01,
                                 0x02,
                                 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                                 0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF,
                                 0x00])

      it "APPLICATION_MASTER_1_LINK_KEY should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.TransportKey.Indication
          expect(@vars.frame.srcAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.keyType).to.be.equal APSME.TransportKey.Indication.KeyType.APPLICATION_MASTER_1_LINK_KEY
          expect(@vars.frame.partnerAddress).to.be.deep.equal new IEEEAddress("00005E0000000002")
          expect(@vars.frame.initiator).to.be.true
          expect(@vars.frame.key).to.be.deep.equal new Key("00112233445566778899AABBCCDDEEFF")
          done()
        parser.write new Buffer([0x02, 0x98, 0xF2, 0x22,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x02,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02,
                                 0x01,
                                 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                                 0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF,
                                 0x00])

      it "APPLICATION_MASTER_2_LINK_KEY should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.TransportKey.Indication
          expect(@vars.frame.srcAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.keyType).to.be.equal APSME.TransportKey.Indication.KeyType.APPLICATION_MASTER_2_LINK_KEY
          expect(@vars.frame.partnerAddress).to.be.deep.equal new IEEEAddress("00005E0000000002")
          expect(@vars.frame.initiator).to.be.true
          expect(@vars.frame.key).to.be.deep.equal new Key("00112233445566778899AABBCCDDEEFF")
          done()
        parser.write new Buffer([0x02, 0x98, 0xF2, 0x22,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x03,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02,
                                 0x01,
                                 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                                 0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF,
                                 0x00])

      it "HIGH_SECURITY_NETWORK_KEY should read from a buffer", (done) ->
        parser = new ZtcParser
        parser.ztcFrame "frame"
        parser.tap () ->
          expect(@vars.frame).to.be.instanceof APSME.TransportKey.Indication
          expect(@vars.frame.srcAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.keyType).to.be.equal APSME.TransportKey.Indication.KeyType.HIGH_SECURITY_NETWORK_KEY
          expect(@vars.frame.keySeqNumber).to.be.equal 2
          expect(@vars.frame.networkKey).to.be.deep.equal new Key("00112233445566778899AABBCCDDEEFF")
          expect(@vars.frame.useParent).to.be.true
          expect(@vars.frame.parentAddress).to.be.deep.equal new IEEEAddress("00005E0000000002")
          done()
        parser.write new Buffer([0x02, 0x98, 0xF2, 0x23,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x05,
                                 0x02,
                                 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                                 0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF,
                                 0x01,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02,
                                 0x00])

  describe "Unbind", () ->
    describe "Request", () ->
      it "should write a buffer", () ->
        builder = new ZtcBuilder
        request = new APSME.Unbind.Request new IEEEAddress("00005E0000000001"), 0x01, 0x1234,
          0x27, new IEEEAddress("00005E0000000002"), 0x03
        request.write builder
        expect(builder.result()).to.be.deep.equal new Buffer([0x02, 0x99, 0x09, 0x15,
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
          expect(@vars.frame).to.be.instanceof APSME.Unbind.Confirm
          expect(@vars.frame.status).to.be.equal 0x00
          expect(@vars.frame.srcAddress).to.be.deep.equal new IEEEAddress("00005E0000000001")
          expect(@vars.frame.srcEndpoint).to.be.equal 0x02
          expect(@vars.frame.clusterId).to.be.equal 0x1234
          expect(@vars.frame.dstAddrMode).to.be.equal 0x27
          expect(@vars.frame.dstAddress).to.be.deep.equal new IEEEAddress("00005E0000000002")
          expect(@vars.frame.dstEndpoint).to.be.equal 0x03
          done()
        parser.write new Buffer([0x02, 0x98, 0x08, 0x16,
                                 0x00,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01,
                                 0x02,
                                 0x34, 0x12,
                                 0x27,
                                 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x02,
                                 0x03,
                                 0x00])
