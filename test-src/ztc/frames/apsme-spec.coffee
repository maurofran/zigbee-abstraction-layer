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
