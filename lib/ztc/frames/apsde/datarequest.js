/*
 * datarequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new DataRequest.
 *
 * @param {!Number} dstAddrMode - The addressing mode for destination.
 * @param {!IEEEAddress} dstAddress - The individual device address of entity
 * @param {!Number} dstEndpoint - The Individual endpoint of the entity.
 * @param {!Number} profileId - The identifier of profile for which this frame is intended.
 * @param {!Number} clusterId - The identifier of the object to use in the binding operation, if indirect addressing.
 * @param {!Number} srcEndpoint - Individual endpoint of the entity.
 * @param {!Buffer} asdu - Packet or first fragment, must be long 100(0x64) or less, depending on stack profile and
 *                         options.
 * @param {!Number} txOptions - Transmission options for the ASDU.
 * @param {!Number} radiusCounter - Distance in hops that a broadcast frame will be allowed to travel through the
 *                                  network.
 * @constructor
 */
function DataRequest(dstAddrMode, dstAddress, dstEndpoint, profileId, clusterId, srcEndpoint, asdu, txOptions,
                     radiusCounter) {
    ZtcFrame.call(this, DataRequest.OPCODE_GROUP, DataRequest.OPCODE);
    this.dstAddrMode = dstAddrMode;
    this.dstAddress = dstAddress;
    this.dstEndpoint = dstEndpoint;
    this.profileId = profileId;
    this.clusterId = clusterId;
    this.srcEndpoint = srcEndpoint;
    this.asdu = asdu;
    this.txOptions = txOptions;
    this.radiusCounter = radiusCounter;
}

util.inherits(DataRequest, ZtcFrame);

/**
 * Writes the DataRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protectedthis.
 */
DataRequest.prototype._writePayload = function (builder) {
    return builder
        .uint8(18 + this.asdu.length)
        .uint8(this.dstAddrMode)
        .ieeeAddress(this.dstAddress)
        .uint8(this.dstEndpoint)
        .uint16le(this.profileId)
        .uint16le(this.clusterId)
        .uint8(this.srcEndpoint)
        .uint8(this.asdu.length)
        .buffer(this.asdu)
        .uint8(this.txOptions)
        .uint8(this.radiusCounter);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
DataRequest.OPCODE_GROUP = 0x9C;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
DataRequest.OPCODE = 0x00;

ZtcFrame.registerFrame(DataRequest);

module.exports = DataRequest;