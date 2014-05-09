/*
 * setpanidrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new SetPanIDRequest.
 *
 * @param {!PANId} panId - The PAN Id to set.
 * @constructor
 */
function SetPanIDRequest(panId) {
    ZtcFrame.call(this, SetPanIDRequest.OPCODE_GROUP, SetPanIDRequest.OPCODE);
    this.panId = panId;
}

util.inherits(SetPanIDRequest, ZtcFrame);

/**
 * Writes the PingRequest request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
SetPanIDRequest.prototype._writePayload = function (builder) {
    return builder
        .uint8(2)
        .panId(this.panId);
};


/**
 * Constant for opcode group.
 *
 * @type {number}
 */
SetPanIDRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
SetPanIDRequest.OPCODE = 0x15;

ZtcFrame.registerFrame(SetPanIDRequest);

module.exports = SetPanIDRequest;