/*
 * readmemoryblockrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new ReadMemoryBlockRequest.
 *
 * @param {!Buffer} pingData - The data to be sent.
 * @constructor
 */
function ReadMemoryBlockRequest(startAddress, numberOfBytes) {
    ZtcFrame.call(this, ReadMemoryBlockRequest.OPCODE_GROUP, ReadMemoryBlockRequest.OPCODE);
    this._startAddress = startAddress;
    this._numberOfBytes = numberOfBytes;
}

util.inherits(ReadMemoryBlockRequest, ZtcFrame);

/**
 * Writes the ReadMemoryBlockRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
ReadMemoryBlockRequest.prototype._writePayload = function (builder) {
    return builder
        .uint8(2)
        .uint16le(this._startAddress)
        .uint8(this._numberOfBytes);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
ReadMemoryBlockRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
ReadMemoryBlockRequest.OPCODE = 0x31;

ZtcFrame.registerFrame(ReadMemoryBlockRequest);

module.exports = ReadMemoryBlockRequest;