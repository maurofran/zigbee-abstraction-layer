/*
 * cleardevicekeyparisetrequest-spec.js
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
    ZtcParser = require("../../../../lib/ztc/ztcparser");

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