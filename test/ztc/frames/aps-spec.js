/*
 * aps-spec.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
/* jshint -W024 */
/* jshint expr:true */
/* global describe, it */
"use strict";

var chai = require("chai"),
    expect = chai.expect,
    ZtcParser = require("../../../lib/ztc/ztc-parser"),
    ZtcBuilder = require("../../../lib/ztc/ztc-builder"),
    IEEEAddress = require("../../../lib/ztc/datatypes").IEEEAddress;
    //APS = require("../../../lib/ztc/frames").APS;

describe.skip("APS", function () {
    describe("APS.ClearDeviceKeyPairSet.Request", function () {
        it("should write a buffer", function () {
            var builder = new ZtcBuilder();
            var ieeeAddress = new IEEEAddress(new Buffer([0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01]));
            var request = new APS.ClearDeviceKeyPairSet.Request(ieeeAddress);
            request.write(builder);
            expect(builder.result()).to.be.deep.equal(
                new Buffer([0x02, 0xA3, 0x3F, 0x08, 0x00, 0x00, 0x5E, 0x00, 0x00, 0x00, 0x00, 0x01]));
        });
    });

    describe("APS.ClearDeviceKeyPairSet.Confirm", function () {
        it("should read from a buffer", function (done) {
            var parser = new ZtcParser();
            parser.ztcFrame("frame").tap(function () {
                expect(this.vars.frame.apsSetStatus).to.be.equal(0x00);
                done();
            });
            parser.write(new Buffer([0x02, 0xA4, 0x3F, 0x01, 0x00, 0x00]));
        });
    });

    describe("APS.ConfirmId.Report", function () {
        it("should read from a buffer", function (done) {
            var parser = new ZtcParser();
            parser.ztcFrame("frame").tap(function () {
                expect(this.vars.frame.assignedConfirmId).to.be.equal(0x4e);
                done();
            });
            parser.write(new Buffer([0x02, 0x9D, 0x03, 0x01, 0x4e, 0x00]));
        });
    });

    describe("APS.DataFragment.Request", function () {
        it("should write a buffer", function () {
            var builder = new ZtcBuilder();
            var request = new APS.DataFragment.Request(1, true, new Buffer([0x34, 0x23, 0x42]));
            request.write(builder);
            expect(builder.result()).to.be.deep.equal(
                new Buffer([0x02, 0x9C, 0x01, 0x06, 0x01, 0x01, 0x03, 0x34, 0x23, 0x42]));
        });
    });

    describe("APS.DataFragment.Indication", function () {
        it("should read from a buffer", function (done) {
            var parser = new ZtcParser();
            parser.ztcFrame("frame").tap(function () {
                expect(this.vars.frame.blockNumber).to.be.equal(0x02);
                expect(this.vars.frame.moreBlocks).to.be.equal(true);
                expect(this.vars.frame.data).to.be.deep.equal(new Buffer([0x43, 0x56, 0x79]));
                done();
            });
            parser.write(new Buffer([0x02, 0x9D, 0x02, 0x06, 0x02, 0x01, 0x03, 0x43, 0x56, 0x79, 0x00]));
        });
    });

    describe("APS.DeregisterEndpoint.Request", function () {
        it("should write a buffer", function () {
            var builder = new ZtcBuilder();
            var request = new APS.DeregisterEndpoint.Request(0x02);
            request.write(builder);
            expect(builder.result()).to.be.deep.equal(
                new Buffer([0x02, 0xA3, 0x0A, 0x01, 0x02]));
        });
    });

    describe("APS.DeregisterEndpoint.Confirm", function () {
        it("should read from a buffer", function (done) {
            var parser = new ZtcParser();
            parser.ztcFrame("frame").tap(function () {
                expect(this.vars.frame.status).to.be.equal(0x00);
                done();
            });
            parser.write(new Buffer([0x02, 0xA4, 0x0A, 0x01, 0x00, 0x00]));
        });
    });
});
