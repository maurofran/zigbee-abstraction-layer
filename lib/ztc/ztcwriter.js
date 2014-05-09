/*
 * ztcwriter.json
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
/* jshint bitwise: false */
"use strict";

var ZtcBuilder = require("./ztcbuilder"),
    ZtcStream = require("./ztcstream");

/**
 * Creates a new ZtcWriter object.
 *
 * @param {!stream.Writable} writable writable stream to send ZtcMessage to
 * @constructor
 */
function ZtcWriter(writable) {
    this._writable = new ZtcStream();
    this._writable.pipe(writable);
}

/**
 * Write a message.
 *
 * @param {!ZtcFrame} frame - the frame to write
 * @param {Function} [callback] - the callback to be invoked on message write completion
 */
ZtcWriter.prototype.writeFrame = function (frame, callback) {
    var buffer = new ZtcBuilder().ztcFrame(frame).result();
    this._writable.write(buffer, callback);
};

module.exports = ZtcWriter;