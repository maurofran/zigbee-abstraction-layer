/*
 * ztcbuilder-spec.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
/* jshint -W024 */
/* jshint expr:true */
/* global describe, beforeEach, it */
"use strict";

var chai = require("chai"),
    expect = chai.expect,
    moment = require("moment"),
    ZtcBuilder = require("../../lib/ztc/ztcbuilder"),
    datatypes = require("../../lib/ztc/datatypes"),
    ShortAddress = datatypes.ShortAddress,
    IEEEAddress = datatypes.IEEEAddress,
    PANId = datatypes.PANId,
    Key = datatypes.Key;

describe("ZtcBuilder", function () {
    var fixture;

    beforeEach(function () {
        fixture = new ZtcBuilder();
    });

    describe("#time(moment)", function () {
        it("Should write a moment object and return this.", function () {
            var time = moment([2000, 0, 1, 0, 0, 32, 0]);

            var buffer = fixture.time(time).result();

            expect(buffer).is.not.null;
            expect(buffer).to.have.length(4);
            expect(buffer).to.deep.equal(new Buffer([0x20, 0x00, 0x00, 0x00]));
        });
    });

    describe("#shortAddress(shortAddress)", function () {
        it("Should write a short address object and return this.", function () {
            var shortAddress = new ShortAddress(new Buffer([0x01, 0x02]));

            var buffer = fixture.shortAddress(shortAddress).result();

            expect(buffer).is.not.null;
            expect(buffer).to.have.length(2);
            expect(buffer).to.deep.equal(shortAddress.asBuffer());
        });
    });

    describe("#ieeeAddress(ieeeAddress)", function () {
        it("Should write an IEEE address object and return this.", function () {
            var ieeeAddress = new IEEEAddress(new Buffer("01234567"));

            var buffer = fixture.ieeeAddress(ieeeAddress).result();

            expect(buffer).is.not.null;
            expect(buffer).to.have.length(8);
            expect(buffer).to.deep.equal(ieeeAddress.asBuffer());
        });
    });

    describe("#panId(panId)", function () {
        it("Should write a PANId object and return this.", function () {
            var panId = new PANId(new Buffer("12345678"));

            var buffer = fixture.panId(panId).result();

            expect(buffer).is.not.null;
            expect(buffer).to.have.length(8);
            expect(buffer).to.deep.equal(panId.asBuffer());
        });
    });

    describe("#key(key)", function () {
        it("Should write a Key object and return this.", function () {
            var key = new Key(new Buffer("0123456789ABCDEF"));

            var buffer = fixture.key(key).result();

            expect(buffer).is.not.null;
            expect(buffer).to.have.length(16);
            expect(buffer).to.deep.equal(key.asBuffer());
        });
    });
});