/*
 * removefromaddressmaprequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new RemoveFromAddressMapRequest.
 *
 * @param {!IEEEAddress} ieeeAddress - The IEEE address.
 * @constructor
 */
function RemoveFromAddressMapRequest(ieeeAddress) {
    ZtcFrame.call(this, RemoveFromAddressMapRequest.OPCODE_GROUP, RemoveFromAddressMapRequest.OPCODE);
    this.ieeeAddress = ieeeAddress;
}

util.inherits(RemoveFromAddressMapRequest, ZtcFrame);

/**
 * Writes the RemoveFromAddressMapRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
RemoveFromAddressMapRequest.prototype._writePayload = function (builder) {
    return builder
        .uint8(8)
        .ieeeAddress(this.ieeeAddress);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
RemoveFromAddressMapRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
RemoveFromAddressMapRequest.OPCODE = 0xC1;

ZtcFrame.registerFrame(RemoveFromAddressMapRequest);

module.exports = RemoveFromAddressMapRequest;