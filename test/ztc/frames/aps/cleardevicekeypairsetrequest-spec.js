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
    ZtcBuilder = require("../../../../lib/ztc/ztcbuilder"),
    IEEEAddress = require("../../../../lib/ztc/datatypes").IEEEAddress,
    APS = require("../../../../lib/ztc/frames").APS;

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