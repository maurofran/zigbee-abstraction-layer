/*
 * radioregisterwriterequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../ztcframe"),
    util = require("util");

/**
 * Creates a new RadioRegisterWriteRequest.
 *
 * @param {!number} address - The address to write (0x00 - 0x3F).
 * @param {!number} value - The value to write.
 * @constructor
 */
function RadioRegisterWriteRequest(address) {
    ZtcFrame.call(this, RadioRegisterWriteRequest.OPCODE_GROUP, RadioRegisterWriteRequest.OPCODE);
    this._address = address;
}

util.inherits(RadioRegisterWriteRequest, ZtcFrame);

/**
 * Writes the RadioRegisterWriteRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
RadioRegisterWriteRequest.prototype._writePayload = function (builder) {
    return builder
        .uint8(1)
        .uint8(this._address);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
RadioRegisterWriteRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
RadioRegisterWriteRequest.OPCODE = 0x39;

ZtcFrame.registerFrame(RadioRegisterWriteRequest);

module.exports = RadioRegisterWriteRequest;