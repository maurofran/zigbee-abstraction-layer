/*
 * addtoaddressmaprequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new AddToAddressMapRequest.
 *
 * @param {!IEEEAddress} ieeeAddress - The IEEE address.
 * @param {!ShortAddress} shortAddress - The short address.
 * @constructor
 */
function AddToAddressMapRequest(ieeeAddress, shortAddress) {
    ZtcFrame.call(this, AddToAddressMapRequest.OPCODE_GROUP, AddToAddressMapRequest.OPCODE);
    this.ieeeAddress = ieeeAddress;
    this.shortAddress = shortAddress;
}

util.inherits(AddToAddressMapRequest, ZtcFrame);

/**
 * Writes the AddToAddressMapRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
AddToAddressMapRequest.prototype._writePayload = function (builder) {
    return builder
        .uint8(10)
        .ieeeAddress(this.ieeeAddress)
        .shortAddress(this.shortAddress);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
AddToAddressMapRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
AddToAddressMapRequest.OPCODE = 0xC0;

ZtcFrame.registerFrame(AddToAddressMapRequest);

module.exports = AddToAddressMapRequest;