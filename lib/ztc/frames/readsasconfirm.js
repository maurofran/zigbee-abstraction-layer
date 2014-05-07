/*
 * readsasconfirm.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcPayload = require("../ztcpayload"),
    _ = require("underscore"),
    dissolve = require("dissolve"),
    util = require("util");

/**
 * Create a new ReadSASConfirm instance.
 *
 * @param {!Buffer} content the content to create message for
 * @constructor
 */
function ReadSASConfirm(content) {
    ZtcPayload.call(this);
    this._parseContent(content);
}

util.inherits(ReadSASConfirm, ZtcPayload);

/**
 * Parse the provided buffer and set the properties of this object accordingly.
 *
 * @param {!Buffer} content the buffer to parse
 * @private
 */
ReadSASConfirm.prototype._parseContent = function (content) {
    var _self = this;

    dissolve()
        .uint16le("shortAddress")
        .uint64le("extendedPanId")
        .uint64le("apsUseExtendedPanId")
        .uint16le("panId")
        .uint32le("channelsMask")
        .uint8("protocolVersion")
        .uint8("stackProfile")
        .uint8("startupControl")
        .uint64le("trustCenterAddress")
        .buffer("trustCenterMasterKey", 16)
        .buffer("networkKey", 16)
        .uint8("useInsecureJoin")
        .buffer("preconfiguredTrustCenterLinkKey", 16)
        .uint8("activeNwkKeySeqNumber")
        .uint8("networkKeyType")
        .uint16le("networkManagerAddress")
        .uint8("scanAttempts")
        .uint16le("timeBetweenScans")
        .uint16le("rejoinInterval")
        .uint16le("maximumRejoinInterval")
        .uint16le("indirectPollRate")
        .uint8("parentLinkRetryThreshold")
        .uint8("isConcentrator")
        .uint8("concentratorRadius")
        .uint8("concentratorDiscoveryTime")
        .tap(function () {
            _.extend(_self, this.vars);
            this.vars = {};
        })
        .write(content);
};

/**
 * The opcode group constant.
 *
 * @type {number}
 */
ReadSASConfirm.OPCODE_GROUP = 0x50;

/**
 * The opcode constant.
 *
 * @type {number}
 */
ReadSASConfirm.OPCODE = 0x03;

module.exports = ReadSASConfirm;