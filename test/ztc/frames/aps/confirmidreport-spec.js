/*
 * confirmidreport-spec.js
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