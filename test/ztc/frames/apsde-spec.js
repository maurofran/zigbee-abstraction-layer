
/*
  apsde-spec.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
 */

(function() {
  var APSDE, IEEEAddress, ShortAddress, ZtcBuilder, ZtcParser, expect, moment, _ref;

  expect = require("chai").expect;

  moment = require("moment");

  ZtcParser = require("../../../lib/ztc/ztc-parser");

  ZtcBuilder = require("../../../lib/ztc/ztc-builder");

  _ref = require("../../../lib/ztc/datatypes"), IEEEAddress = _ref.IEEEAddress, ShortAddress = _ref.ShortAddress;

  APSDE = require("../../../lib/ztc/frames").APSDE;

  describe("APSDE", function() {
    return describe("Data", function() {
      describe("Request", function() {
        return it("should write a buffer", function() {
          var builder, data, ieeeAddress, request;
          builder = new ZtcBuilder;
          ieeeAddress = new IEEEAddress("00005E0000000001");
          data = new Buffer([0x05, 0x06, 0x07]);
          request = new APSDE.Data.Request(0x01, ieeeAddress, 0x02, 0xA034, 0x1042, 0x01, data, 0x00, 0x03);
          request.write(builder);
          return expect(builder.result()).to.be.deep.equal(new Buffer([0x02, 0x9C, 0x00, 0x15, 0x01, 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x34, 0xA0, 0x42, 0x10, 0x01, 0x03, 0x05, 0x06, 0x07, 0x00, 0x03]));
        });
      });
      return describe("Confirm", function() {
        return it("should read from a buffer", function(done) {
          var parser;
          parser = new ZtcParser;
          parser.ztcFrame("frame");
          parser.tap(function() {
            expect(this.vars.frame.dstAddrMode).to.be.equal(0x01);
            expect(this.vars.frame.dstAddress).to.be.deep.equal(new ShortAddress(new Buffer([0x01, 0x00])));
            expect(this.vars.frame.dstEndpoint).to.be.equal(0x00);
            expect(this.vars.frame.srcAddrMode).to.be.equal(0x02);
            expect(this.vars.frame.srcAddress).to.be.deep.equal(new ShortAddress(new Buffer([0x02, 0x00])));
            expect(this.vars.frame.srcEndpoint).to.be.equal(0x37);
            expect(this.vars.frame.profileId).to.be.equal(0x0005);
            expect(this.vars.frame.clusterId).to.be.equal(0x0137);
            expect(this.vars.frame.asduLength).to.be.equal(0x03);
            expect(this.vars.frame.asdu).to.be.deep.equal(new Buffer([0x01, 0x02, 0x03]));
            expect(this.vars.frame.status).to.be.equal(0x00);
            expect(this.vars.frame.wasBroadcast).to.be.equal(true);
            expect(this.vars.frame.linkQuality).to.be.equal(0x15);
            expect(this.vars.frame.rxTime).to.be.deep.equal(moment().year(2000).startOf("year").add("s", 1));
            expect(this.vars.frame.messageType).to.be.equal(0x34);
            expect(this.vars.frame.nextBlock).to.be.equal(0x0000);
            expect(this.vars.frame.dataSize).to.be.equal(0x05);
            expect(this.vars.frame.dataPointer).to.be.equal(0x0002);
            expect(this.vars.frame.bufferNumber).to.be.equal(0x01);
            return done();
          });
          return parser.write(new Buffer([0x02, 0x9D, 0x01, 0x1F, 0x01, 0x01, 0x00, 0x00, 0x02, 0x02, 0x00, 0x37, 0x05, 0x00, 0x37, 0x01, 0x03, 0x01, 0x02, 0x03, 0x00, 0x01, 0x03, 0x15, 0x01, 0x00, 0x00, 0x00, 0x34, 0x00, 0x00, 0x05, 0x02, 0x00, 0x01, 0x00]));
        });
      });
    });
  });

}).call(this);
