/*
 * writeextaddrrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../ztcframe"),
    util = require("util");

/**
 * Creates a new WriteExtAddrRequest.
 *
 * @param {!IEEEAddress} address - The address to write.
 * @constructor
 */
function WriteExtAddrRequest(address) {
    ZtcFrame.call(this, WriteExtAddrRequest.OPCODE_GROUP, WriteExtAddrRequest.OPCODE);
    this.address = address;
}

util.inherits(WriteExtAddrRequest, ZtcFrame);

/**
 * Writes the WriteExtAddrRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
WriteExtAddrRequest.prototype._writePayload = function (builder) {
    return builder
        .uint8(this._pingData.length)
        .buffer(this.pingData);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
WriteExtAddrRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
WriteExtAddrRequest.OPCODE = 0xDB;

ZtcFrame.registerFrame(WriteExtAddrRequest);

module.exports = WriteExtAddrRequest;