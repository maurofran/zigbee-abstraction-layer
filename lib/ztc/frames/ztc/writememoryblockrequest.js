/*
 * writememoryblockrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new WriteMemoryBlockRequest.
 *
 * @param {!number} startAddress - The address to start write to.
 * @param {!Buffer} data - The data to be sent.
 * @constructor
 */
function WriteMemoryBlockRequest(startAddress, data) {
    ZtcFrame.call(this, WriteMemoryBlockRequest.OPCODE_GROUP, WriteMemoryBlockRequest.OPCODE);
    this.startAddress = startAddress;
    this.data = data;
}

util.inherits(WriteMemoryBlockRequest, ZtcFrame);

/**
 * Writes the WriteMemoryBlockRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
WriteMemoryBlockRequest.prototype._writePayload = function (builder) {
    return builder
        .uint8(3 + this.data.length)
        .uint16le(this.startAddress)
        .uint8(this.data.length)
        .buffer(this.data);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
WriteMemoryBlockRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
WriteMemoryBlockRequest.OPCODE = 0x30;

ZtcFrame.registerFrame(WriteMemoryBlockRequest);

module.exports = WriteMemoryBlockRequest;