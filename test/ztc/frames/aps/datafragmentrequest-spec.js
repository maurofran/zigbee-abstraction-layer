/*
 * datafragmentrequest-spec.js
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
    APS = require("../../../../lib/ztc/frames").APS;

describe("APS.DataFragment.Request", function () {
    it("should write a buffer", function () {
        var builder = new ZtcBuilder();
        var request = new APS.DataFragment.Request(1, true, new Buffer([0x34, 0x23, 0x42]));
        request.write(builder);
        expect(builder.result()).to.be.deep.equal(
            new Buffer([0x02, 0x9C, 0x01, 0x06, 0x01, 0x01, 0x03, 0x34, 0x23, 0x42]));
    });
});