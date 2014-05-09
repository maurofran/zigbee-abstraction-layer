/*
 * ztcreader-spec.js
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
    assert = chai.assert,
    through = require("through"),
    ZtcReader = require("../../lib/ztc/ztcreader"),
    ZtcFrame = require("../../lib/ztc/ztcframe"),
    SaveConfirm = require("../../lib/ztc/frames").SaveConfirm;

describe("ZtcReader", function () {
    var fixture,
        ztcStream;

    beforeEach(function () {
        ztcStream = through().pause();
        fixture = new ZtcReader(ztcStream);
    });

    describe("#message event", function () {
        it("should raise a message event when a valid buffer is available.", function (done) {
            var buffer = new Buffer([0x02, 0xA4, 0xE4, 0x01, 0x00, 0x41]);

            fixture.once("frame", function (message) {
                expect(message).to.not.be.undefined;
                expect(message).to.be.instanceof(SaveConfirm);
                done();
            });

            fixture.once("error", function () {
                assert.fail();
                done();
            });

            ztcStream.queue(buffer).resume();
        });

        it("should raise a message event when a misaligned buffer is available.", function (done) {
            var buffer = new Buffer([0x34, 0x27, 0x16, 0x02, 0x50, 0x01, 0x01, 0x27, 0x77]);

            fixture.once("frame", function (message) {
                expect(message).to.not.be.undefined;
                expect(message).to.be.instanceof(ZtcFrame);
                done();
            });

            fixture.once("error", function () {
                assert.fail();
                done();
            });

            ztcStream.queue(buffer).resume();
        });
    });

    describe("#error event", function () {
        it("should raise no event when a buffer with invalid checksum is available.", function (done) {
            var buffer = new Buffer([0x02, 0x50, 0x01, 0x01, 0x27, 0x32]);

            fixture.once("frame", function () {
                assert.fail();
                done();
            });

            fixture.once("error", function () {
                assert.fail();
            });

            ztcStream.queue(buffer).resume();

            process.nextTick(done);
        });
    });
});