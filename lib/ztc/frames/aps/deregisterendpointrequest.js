/*
 * deregisterendpointrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new DeregisterEndpointRequest.
 *
 * @param {!Number} endpointNumber - The endpoint number to de register.
 * @constructor
 */
function DeregisterEndpointRequest(endpointNumber) {
    ZtcFrame.call(this, DeregisterEndpointRequest.OPCODE_GROUP, DeregisterEndpointRequest.OPCODE);
    this.endpointNumber = endpointNumber;
}

util.inherits(DeregisterEndpointRequest, ZtcFrame);

/**
 * Writes the DeregisterEndpointRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
DeregisterEndpointRequest.prototype._writePayload = function (builder) {
    return builder.uint8(1).uint8(this.endpointNumber);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
DeregisterEndpointRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
DeregisterEndpointRequest.OPCODE = 0x0A;

ZtcFrame.registerFrame(DeregisterEndpointRequest);

module.exports = DeregisterEndpointRequest;