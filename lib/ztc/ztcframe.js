/*
 * ztcmessage.json
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
/* jshint bitwise: false */
"use strict";

var ZtcPayload = require("./ztcpayload");

/**
 * Creates a new ZtcMessage object with the provided parameters.
 *
 * @param {!number} opCodeGroup the opcode group
 * @param {!number} opCode the opcode value
 * @param {!(Buffer|ZtcContent)} content the content of the message
 * @constructor
 */
function ZtcFrame(opCodeGroup, opCode, content) {
    this.opCodeGroup = opCodeGroup;
    this.opCode = opCode;
    this._content = content;
}

/**
 * Constant used to provide the SYN of the ZtcMessage.
 *
 * @type {number}
 */
ZtcFrame.SYN = 0x02;

/**
 * Retrieve the content of this ZtcMessage as a node js Buffer.
 *
 * @returns {Buffer} the buffer
 * @throws {String} if the content is unexpected
 */
ZtcFrame.prototype.contentAsBuffer = function () {
    if (Buffer.isBuffer(this._content)) {
        return this._content;
    } else if (this._content instanceof ZtcPayload) {
        return this._content.asBuffer();
    } else {
        throw "Unexpected content.";
    }
};

/**
 * Calculate the checksum for the content of this message.
 *
 * @return {number} the checksum of the content of this message.
 */
ZtcFrame.prototype.calculateChecksum = function () {
    var buffer = this.contentAsBuffer();
    var checksum = this.opCodeGroup ^ this.opCode ^ buffer.length;
    for (var i = 0; i < buffer.length; i++) {
        checksum = checksum ^ buffer[i];
    }
    return checksum;
};

module.exports = ZtcFrame;