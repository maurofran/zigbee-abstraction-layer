
/*
  aps-spec.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
 */

(function() {
  var APS, IEEEAddress, ZtcBuilder, ZtcParser, expect;

  expect = require("chai").expect;

  ZtcParser = require("../../../lib/ztc/ztc-parser");

  ZtcBuilder = require("../../../lib/ztc/ztc-builder");

  IEEEAddress = require("../../../lib/ztc/datatypes").IEEEAddress;

  APS = require("../../../lib/ztc/frames").APS;

  describe("APS", function() {
    describe("ClearDeviceKeyPairSet", function() {
      describe("Request", function() {
        return it("should write a buffer", function() {
          var builder, ieeeAddress, request;
          builder = new ZtcBuilder;
          ieeeAddress = new IEEEAddress("00005E0000000001");
          request = new APS.ClearDeviceKeyPairSet.Request(ieeeAddress);
          request.write(builder);
          return expect(builder.result()).to.be.deep.equal(new Buffer([0x02, 0xA3, 0x3F, 0x08, 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01]));
        });
      });
      return describe("Confirm", function() {
        return it("should read from a buffer", function(done) {
          var parser;
          parser = new ZtcParser;
          parser.ztcFrame("frame");
          parser.tap(function() {
            expect(this.vars.frame).to.be["instanceof"](APS.ClearDeviceKeyPairSet.Confirm);
            expect(this.vars.frame.apsSetStatus).to.be.equal(0x00);
            return done();
          });
          return parser.write(new Buffer([0x02, 0xA4, 0x3F, 0x01, 0x00, 0x00]));
        });
      });
    });
    describe("ConfirmId", function() {
      return describe("Report", function() {
        return it("should read from a buffer", function(done) {
          var parser;
          parser = new ZtcParser;
          parser.ztcFrame("frame");
          parser.tap(function() {
            expect(this.vars.frame).to.be["instanceof"](APS.ConfirmId.Report);
            expect(this.vars.frame.assignedConfirmId).to.be.equal(0x4e);
            return done();
          });
          return parser.write(new Buffer([0x02, 0x9D, 0x03, 0x01, 0x4e, 0x00]));
        });
      });
    });
    describe("DataFragment", function() {
      describe("Request", function() {
        return it("should write a buffer", function() {
          var builder, request;
          builder = new ZtcBuilder;
          request = new APS.DataFragment.Request(1, true, new Buffer([0x34, 0x23, 0x42]));
          request.write(builder);
          return expect(builder.result()).to.be.deep.equal(new Buffer([0x02, 0x9C, 0x01, 0x06, 0x01, 0x01, 0x03, 0x34, 0x23, 0x42]));
        });
      });
      return describe("Indication", function() {
        return it("should read from a buffer", function(done) {
          var parser;
          parser = new ZtcParser;
          parser.ztcFrame("frame");
          parser.tap(function() {
            expect(this.vars.frame).to.be["instanceof"](APS.DataFragment.Indication);
            expect(this.vars.frame.blockNumber).to.be.equal(0x02);
            expect(this.vars.frame.moreBlocks).to.be.equal(true);
            expect(this.vars.frame.data).to.be.deep.equal(new Buffer([0x43, 0x56, 0x79]));
            return done();
          });
          return parser.write(new Buffer([0x02, 0x9D, 0x02, 0x06, 0x02, 0x01, 0x03, 0x43, 0x56, 0x79, 0x00]));
        });
      });
    });
    return describe("DeregisterEndpoint", function() {
      describe("Request", function() {
        return it("should write a buffer", function() {
          var builder, request;
          builder = new ZtcBuilder;
          request = new APS.DeregisterEndpoint.Request(0x02);
          request.write(builder);
          return expect(builder.result()).to.be.deep.equal(new Buffer([0x02, 0xA3, 0x0A, 0x01, 0x02]));
        });
      });
      return describe("Confirm", function() {
        return it("should read from a buffer", function(done) {
          var parser;
          parser = new ZtcParser;
          parser.ztcFrame("frame");
          parser.tap(function() {
            expect(this.vars.frame).to.be["instanceof"](APS.DeregisterEndpoint.Confirm);
            expect(this.vars.frame.status).to.be.equal(0x00);
            return done();
          });
          return parser.write(new Buffer([0x02, 0xA4, 0x0A, 0x01, 0x00, 0x00]));
        });
      });
    });
  });

}).call(this);
