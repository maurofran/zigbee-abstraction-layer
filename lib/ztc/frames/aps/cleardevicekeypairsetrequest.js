/*
 * cleardevicekeysetrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new ClearDeviceKeyPairSetRequest.
 *
 * @param {!IEEEAddress} ieeeAddress - The IEEE address of the device to clear the key set.
 * @constructor
 */
function ClearDeviceKeyPairSetRequest(ieeeAddress) {
    ZtcFrame.call(this, ClearDeviceKeyPairSetRequest.OPCODE_GROUP, ClearDeviceKeyPairSetRequest.OPCODE);
    this.ieeeAddress = ieeeAddress;
}

util.inherits(ClearDeviceKeyPairSetRequest, ZtcFrame);

/**
 * Writes the ClearDeviceKeyPairSetRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
ClearDeviceKeyPairSetRequest.prototype._writePayload = function (builder) {
    return builder.uint8(8).ieeeAddress(this.ieeeAddress);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
ClearDeviceKeyPairSetRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
ClearDeviceKeyPairSetRequest.OPCODE = 0x3F;

ZtcFrame.registerFrame(ClearDeviceKeyPairSetRequest);

module.exports = ClearDeviceKeyPairSetRequest;