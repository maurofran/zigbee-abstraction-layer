/*
 * ztcwriter.json
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var concentrate = require("concentrate"),
    ZtcFrame = require("./ztcframe");

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
 * @param {!ZtcFrame} message the message to write
 * @param {Function} callback the callback to be invoked on message write completion
 */
ZtcWriter.prototype.writeMessage = function (message, callback) {
    var content = message.contentAsBuffer();
    var buffer = concentrate()
        .uint8(ZtcFrame.SYN)
        .uint8(message.opCodeGroup)
        .uint8(message.opCode)
        .uint8(content.length)
        .buffer(content)
        .uint8(message.calculateChecksum())
        .result();
    this._writable.write(buffer, callback);
};

module.exports = ZtcWriter;