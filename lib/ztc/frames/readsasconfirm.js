/*
 * readsasconfirm.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../ztcframe"),
    _ = require("underscore"),
    util = require("util");

/**
 * Create a new ReadSASConfirm instance.
 *
 * @param {!ZtcParser} parser - the parser to read the message from
 * @constructor
 */
function ReadSASConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.shortAddress("shortAddress")
        .panId("extendedPanId")
        .panId("apsUseExtendedPanId")
        .uint16le("panId")
        .uint32le("channelsMask")
        .uint8("protocolVersion")
        .uint8("stackProfile")
        .uint8("startupControl")
        .ieeeAddress("trustCenterAddress")
        .key("trustCenterMasterKey")
        .key("networkKey")
        .uint8("useInsecureJoin")
        .key("preconfiguredTrustCenterLinkKey")
        .uint8("activeNwkKeySeqNumber")
        .uint8("networkKeyType")
        .shortAddress("networkManagerAddress")
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
        });
}

util.inherits(ReadSASConfirm, ZtcFrame);

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

ZtcFrame.registerFrame(ReadSASConfirm);

module.exports = ReadSASConfirm;