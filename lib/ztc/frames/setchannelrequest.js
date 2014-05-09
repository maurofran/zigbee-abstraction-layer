/*
 * setchannelrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../ztcframe"),
    util = require("util");

/**
 * Creates a new SetChannelRequest.
 *
 * @param {!number} channel - The channel to set.
 * @constructor
 */
function SetChannelRequest(channel) {
    ZtcFrame.call(this, SetChannelRequest.OPCODE_GROUP, SetChannelRequest.OPCODE);
    this.channel = channel;
}

util.inherits(SetChannelRequest, ZtcFrame);

/**
 * Writes the SetChannelRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
SetChannelRequest.prototype._writePayload = function (builder) {
    return builder
        .uint8(1)
        .uint8(this.channel);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
SetChannelRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
SetChannelRequest.OPCODE = 0x13;

ZtcFrame.registerFrame(SetChannelRequest);

module.exports = SetChannelRequest;