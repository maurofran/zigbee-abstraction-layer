/*
 * datafragmentrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new DataFragmentRequest.
 *
 * @param {!number} blockNumber - The number of the block.
 * @param {!boolean} moreBlocks - If there are more blocks.
 * @param {!Buffer} data - The data
 * @constructor
 */
function DataFragmentRequest(blockNumber, moreBlocks, data) {
    ZtcFrame.call(this, DataFragmentRequest.OPCODE_GROUP, DataFragmentRequest.OPCODE);
    this.blockNumber = blockNumber;
    this.moreBlocks = moreBlocks;
    this.data = data;
}

util.inherits(DataFragmentRequest, ZtcFrame);

/**
 * Writes the ClearDeviceKeySetRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
DataFragmentRequest.prototype._writePayload = function (builder) {
    return builder.uint8(3 + this.data.length).uint8(this.blockNumber).uint8(this.moreBlocks ? 1 : 0)
        .uint8(this.data.length).buffer(this.data);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
DataFragmentRequest.OPCODE_GROUP = 0x9C;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
DataFragmentRequest.OPCODE = 0x01;

ZtcFrame.registerFrame(DataFragmentRequest);

module.exports = DataFragmentRequest;