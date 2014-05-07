/*
 * ztcwriter-spec.js
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
    through = require("through"),
    ZtcWriter = require("../../lib/ztc/ztcwriter"),
    ReadSAS = require("../../lib/ztc/frames/readsas");

describe("ZtcWriter", function () {
    var fixture,
        ztcStream;

    beforeEach(function () {
        ztcStream = through().pause();
        fixture = new ZtcWriter(ztcStream);
    });

    describe("#writeMessage(frame, callback)", function () {
        it("should write a valid message when a frame is provided.", function (done) {
            var frame = new ReadSAS(ReadSAS.Source.ROM);
            var expected = new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52]);

            fixture.writeFrame(frame);

            ztcStream.on("data", function (data) {
                expect(data).to.be.deep.equal(expected);
                done();
            });

            ztcStream.resume();
        });
    });
});