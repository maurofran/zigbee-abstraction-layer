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

    describe("Mode CALCULATE", function () {

        beforeEach(function () {
            fixture = new ZtcStream({ mode: ZtcStream.Mode.CALCULATE });
        });

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

        it("should calculate and write the checksum on two consecutive packets.", function (done) {
            var reader = new ReadableStream(new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x02, 0x50]));
            var writer = new WritableStream();
            reader.pipe(fixture).pipe(writer);
            process.nextTick(function () {
                expect(writer.toBuffer()).to.be.deep.equal(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52,
                                                                       0x02, 0x50]));
                reader.append(new Buffer([0x02, 0x01, 0x01]));
                process.nextTick(function () {
                    expect(writer.toBuffer()).to.be.deep.equal(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52,
                                                                           0x02, 0x50, 0x02, 0x01, 0x01, 0x52]));
                    done();
                });
            });
        });
    });

    describe("Mode VERIFY", function () {

        beforeEach(function () {
            fixture = new ZtcStream({ mode: ZtcStream.Mode.VERIFY });
        });

        it("should verify and write the packet on full packet chunk with valid checksum.", function (done) {
            var reader = new ReadableStream(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52]));
            var writer = new WritableStream();
            reader.pipe(fixture).pipe(writer);
            process.nextTick(function () {
                expect(writer.toBuffer()).to.be.deep.equal(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52]));
                done();
            });
        });

        it("should verify and drop the packet on full packet chunk with invalid checksum.", function (done) {
            var reader = new ReadableStream(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x53]));
            var writer = new WritableStream();
            reader.pipe(fixture).pipe(writer);
            process.nextTick(function () {
                expect(writer.toBuffer()).to.be.deep.equal(new Buffer(0));
                done();
            });
        });

        it("should verify and write the packet on fragmented packet with valid checksum.", function (done) {
            var reader = new ReadableStream(new Buffer([0x02, 0x50, 0x02]));
            var writer = new WritableStream();
            reader.pipe(fixture).pipe(writer);
            reader.append(new Buffer([0x01, 0x01, 0x52]));
            process.nextTick(function () {
                expect(writer.toBuffer()).to.be.deep.equal(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52]));
                done();
            });
        });

        it("should verify and drop the packet on fragmented packet with invalid checksum.", function (done) {
            var reader = new ReadableStream(new Buffer([0x02, 0x50, 0x02]));
            var writer = new WritableStream();
            reader.pipe(fixture).pipe(writer);
            reader.append(new Buffer([0x01, 0x01, 0x523]));
            process.nextTick(function () {
                expect(writer.toBuffer()).to.be.deep.equal(new Buffer(0));
                done();
            });
        });

        it("should verify and write the packet on bigger packet with valid checksum.", function (done) {
            var reader = new ReadableStream(new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x052, 0x45]));
            var writer = new WritableStream();
            reader.pipe(fixture).pipe(writer);
            process.nextTick(function () {
                expect(writer.toBuffer()).to.be.deep.equal(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52]));
                done();
            });
        });

        it("should verify and drop the packet on bigger packet with invalid checksum.", function (done) {
            var reader = new ReadableStream(new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x053, 0x45]));
            var writer = new WritableStream();
            reader.pipe(fixture).pipe(writer);
            process.nextTick(function () {
                expect(writer.toBuffer()).to.be.deep.equal(new Buffer(0));
                done();
            });
        });

        it("should verify and write the packets on two consecutive packets with valid checksum.", function (done) {
            var reader = new ReadableStream(new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x52, 0x02, 0x50]));
            var writer = new WritableStream();
            reader.pipe(fixture).pipe(writer);
            process.nextTick(function () {
                expect(writer.toBuffer()).to.be.deep.equal(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52]));
                reader.append(new Buffer([0x02, 0x01, 0x01, 0x52]));
                process.nextTick(function () {
                    expect(writer.toBuffer()).to.be.deep.equal(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52,
                        0x02, 0x50, 0x02, 0x01, 0x01, 0x52]));
                    done();
                });
            });
        });

        it("should verify and drop the first packets on two consecutive packets.", function (done) {
            var reader = new ReadableStream(new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x53, 0x02, 0x50]));
            var writer = new WritableStream();
            reader.pipe(fixture).pipe(writer);
            process.nextTick(function () {
                expect(writer.toBuffer()).to.be.deep.equal(new Buffer(0));
                reader.append(new Buffer([0x02, 0x01, 0x01, 0x52]));
                process.nextTick(function () {
                    expect(writer.toBuffer()).to.be.deep.equal(new Buffer([0x02, 0x50, 0x02, 0x01, 0x01, 0x52]));
                    done();
                });
            });
        });

        it("should verify and drop all packets on two consecutive packets on invalid checksum.", function (done) {
            var reader = new ReadableStream(new Buffer([0x27, 0x45, 0x02, 0x50, 0x02, 0x01, 0x01, 0x53, 0x02, 0x50]));
            var writer = new WritableStream();
            reader.pipe(fixture).pipe(writer);
            process.nextTick(function () {
                expect(writer.toBuffer()).to.be.deep.equal(new Buffer(0));
                reader.append(new Buffer([0x02, 0x01, 0x01, 0x54]));
                process.nextTick(function () {
                    expect(writer.toBuffer()).to.be.deep.equal(new Buffer(0));
                    done();
                });
            });
        });
    });
});