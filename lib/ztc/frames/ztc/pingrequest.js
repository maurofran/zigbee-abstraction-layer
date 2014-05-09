/*
 * pingrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new PingRequest.
 *
 * @param {!Buffer} pingData - The data to be sent.
 * @constructor
 */
function PingRequest(pingData) {
    ZtcFrame.call(this, PingRequest.OPCODE_GROUP, PingRequest.OPCODE);
    this._pingData = pingData;
}

util.inherits(PingRequest, ZtcFrame);

/**
 * Writes the PingRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
PingRequest.prototype._writePayload = function (builder) {
    return builder
        .uint8(this._pingData.length)
        .buffer(this.pingData);
};


/**
 * Constant for opcode group.
 *
 * @type {number}
 */
PingRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
PingRequest.OPCODE = 0x38;

ZtcFrame.registerFrame(PingRequest);

module.exports = PingRequest;