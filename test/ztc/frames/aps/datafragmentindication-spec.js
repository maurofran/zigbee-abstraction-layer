/*
 * datafragmentindication-spec.js
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