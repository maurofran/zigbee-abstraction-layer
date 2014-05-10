/*
 * ztcparser-spec.js
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
    ZtcParser = require("../../lib/ztc/ztcparser"),
    datatypes = require("../../lib/ztc/datatypes");

describe("ZtcParser", function () {
    var fixture;

    beforeEach(function () {
        fixture = new ZtcParser();
    });

    describe("#moment(name)", function () {
        it("Should create a moment instance variable and return this.", function (done) {
            fixture.moment("time").tap(function () {
                this.push(this.vars);
            });
            fixture.on("readable", function () {
                var data = fixture.read();
                expect(data).to.contain.keys(["time"]);
                expect(moment.isMoment(data.time)).to.be.true;
                done();
            });
            fixture.end(new Buffer([0x05, 0x43, 0x27, 0x98]));
        })
    });

    describe("#shortAddress(name)", function () {
        it("Should create a short address variable and return this.", function (done) {
            fixture.shortAddress("shortAddress").tap(function () {
                this.push(this.vars);
            });
            fixture.on("readable", function () {
                var data = fixture.read();
                expect(data).to.contain.keys(["shortAddress"]);
                expect(data.shortAddress).to.be.instanceof(datatypes.ShortAddress);
                done();
            });

            fixture.end(new Buffer([0x01, 0x02]));
        });
    });

    describe("#ieeeAddress(name)", function () {
        it("Should create an IEEE address variable and return this.", function (done) {
            fixture.ieeeAddress("networkAddress").tap(function () {
                this.push(this.vars);
            });
            fixture.on("readable", function () {
                var data = fixture.read();
                expect(data).to.contain.keys(["networkAddress"]);
                expect(data.networkAddress).to.be.instanceof(datatypes.IEEEAddress);
                done();
            });

            fixture.end(new Buffer([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08]));
        });
    });

    describe("#panId(name)", function () {
        it("Should create a PANId variable and return this.", function (done) {
            fixture.panId("extendedPANId").tap(function () {
                this.push(this.vars);
            });
            fixture.on("readable", function () {
                var data = fixture.read();
                expect(data).to.contain.keys(["extendedPANId"]);
                expect(data.extendedPANId).to.be.instanceof(datatypes.PANId);
                done();
            });

            fixture.end(new Buffer([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08]));
        });
    });

    describe("#key(name)", function () {
        it("Should create a Key variable and return this.", function (done) {
            fixture.key("networkKey").tap(function () {
                this.push(this.vars);
            });
            fixture.on("readable", function () {
                var data = fixture.read();
                expect(data).to.contain.keys(["networkKey"]);
                expect(data.networkKey).to.be.instanceof(datatypes.Key);
                done();
            });

            fixture.end(new Buffer("1234567890ABCDEF"));
        });
    });
});