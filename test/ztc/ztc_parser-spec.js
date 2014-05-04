/*
 * ztc_parser-spec.js
 *
 * (C) 2014-2014 Cedac Software S.r.l.
 */
/* global describe, beforeEach, it */
"use strict";

var chai = require("chai"),
    ZtcParser = require("../../lib/ztc/ztc_parser").ZtcParser;

chai.should();

describe("ZtcParser", function () {
    /** @type {ZtcParser} */
    var fixture;

    beforeEach(function () {
        fixture = new ZtcParser();
    });

    describe("#writeBuffer(opCodeGroup, opCode, buffer)", function () {
        it("should return a buffer.", function () {
            var res = fixture.writeBuffer(0x50, 0x03, new Buffer([0x00]));

            res.should.be.deep.equal(new Buffer([0x02, 0x50, 0x03, 0x01, 0x00, 0x52]));
        });
    });
});