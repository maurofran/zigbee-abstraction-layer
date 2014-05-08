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
    ZtcStream = require("../../lib/ztc/ztcstream"),
    ReadableStream = require("memory-streams").ReadableStream,
    WritableStream = require("memory-streams").WritableStream;

describe("ZtcStream", function () {
    var fixture;

    beforeEach(function () {
        fixture = new ZtcStream();
    });

    describe("#_transform(chunk, encoding, callback)", function () {
        it("should calculate and write the checksum on full packet chunk.", function (done) {
            var reader = new ReadableStream(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01]));
            fixture.on("readable", function () {
                var data = fixture.read();
                expect(data).to.be.not.null;
                if (data.length === 1) {
                    expect(data).to.be.deep.equal(new Buffer([0x52]));
                    done();
                } else {
                    expect(data).to.be.deep.equal(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01]));
                }
            });
            reader.pipe(fixture);
        });

        it("should calculate and write the checksum on fragmented packet.", function (done) {
            var reader = new ReadableStream(new Buffer([0x02, 0x50, 0x02]));
            var writer = new WritableStream();
            reader.pipe(fixture).pipe(writer);
            reader.append(new Buffer([0x01, 0x01]));
            process.nextTick(function () {
                expect(writer.toBuffer()).to.be.deep.equal(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52]));
                done();
            });
        });

        it("should calculate and write the checksum on bigger packet.", function (done) {
            var reader = new ReadableStream(new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x45]));
            var writer = new WritableStream();
            reader.pipe(fixture).pipe(writer);
            process.nextTick(function () {
                expect(writer.toBuffer()).to.be.deep.equal(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52]));
                done();
            });
        });
    });
});