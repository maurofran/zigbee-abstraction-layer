/*
 * ztcwriter.json
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
/* jshint bitwise: false */
"use strict";

var ZtcBuilder = require("./ztcbuilder");

/**
 * Calculate the checksum of the provided buffer.
 *
 * @param {!Buffer} buffer - the buffer to calculate the checksum for
 */
function calculateChecksum(buffer) {
    var i,
        checksum = 0,
        length = buffer.length - 1;

    for (i = 1; i < length; i++) {
        checksum = checksum ^ buffer[i];
    }
    buffer[length] = checksum;
}

/**
 * Creates a new ZtcWriter object.
 *
 * @param {!stream.Writable} writable writable stream to send ZtcMessage to
 * @constructor
 */
function ZtcWriter(writable) {
    this._writable = writable;
}

/**
 * Write a message.
 *
 * @param {!ZtcFrame} frame - the frame to write
 * @param {Function} [callback] - the callback to be invoked on message write completion
 */
ZtcWriter.prototype.writeFrame = function (frame, callback) {
    var buffer = new ZtcBuilder().ztcFrame(frame).result();
    calculateChecksum(buffer);
    this._writable.write(buffer, callback);
};

module.exports = ZtcWriter;