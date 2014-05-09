/*
 * radioregisterreadrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../ztcframe"),
    util = require("util");

/**
 * Creates a new RadioRegisterReadRequest.
 *
 * @param {!number} address - The address to read (0x00 - 0x3F).
 * @constructor
 */
function RadioRegisterReadRequest(address) {
    ZtcFrame.call(this, RadioRegisterReadRequest.OPCODE_GROUP, RadioRegisterReadRequest.OPCODE);
    this._address = address;
}

util.inherits(RadioRegisterReadRequest, ZtcFrame);

/**
 * Writes the ReadMemoryBlockRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
RadioRegisterReadRequest.prototype._writePayload = function (builder) {
    return builder
        .uint8(1)
        .uint8(this._address);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
RadioRegisterReadRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
RadioRegisterReadRequest.OPCODE = 0x3A;

ZtcFrame.registerFrame(RadioRegisterReadRequest);

module.exports = RadioRegisterReadRequest;