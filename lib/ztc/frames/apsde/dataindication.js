/*
 * dataindication.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    _ = require("underscore"),
    util = require("util");

/**
 * Create a new DataIndication instance.
 *
 * @param {!ZtcParser} parser - The parser to read the message from.
 * @constructor
 */
function DataIndication(parser) {
    ZtcFrame.call(this, DataIndication.OPCODE_GROUP, DataIndication.OPCODE);
    var _self = this;
    parser.uint8("dstAddrMode").shortAddress("dstAddress").uint8("dstEndpoint")
        .uint8("srcAddrMode").shortAddress("srcAddress").uint8("srcEndpoint")
        .uint16le("profileId").uint16le("clusterId").uint8("asduLength").tap(function () {
            this.buffer("asdu", this.vars.asduLength);
        })
        .uint8("status").boolean("wasBroadcast").uint8("securityStatus")
        .uint8("linkQuality").moment("rxTime").uint8("messageType").uint16le("nextBlock")
        .uint8("dataSize").uint16le("dataPointer").uint8("bufferNumber")
        .tap(function () {
            _.extend(_self, this.vars);
        });
}

util.inherits(DataIndication, ZtcFrame);

/**
 * Address mode.
 */
DataIndication.AddressMode = {
    RESERVED: 0x00,
    VALUE_16BIT_GROUP_FOR_DST_ADDR: 0x01,
    VALUE_16BIT_ADDR_AND_DST_ENDPOINT: 0x02
};

/**
 * Security statuses.
 */
DataIndication.SecurityStatus = {
    UNSECURED: 0x00,
    SECURED_NWK_KEY: 0x01,
    SECURED_LINK_KEY: 0x02,
    SECURED_LINK_AND_NWK_KEY: 0x03
};

/**
 * Data confirm status constants.
 */
DataIndication.Status = {
    SUCCESS: 0x00,
    DEFRAG_DEFERRED: 0xA1,
    DEFRAG_UNSUPPORTED: 0xA2
};

/**
 * The opcode group constant.
 *
 * @type {number}
 */
DataIndication.OPCODE_GROUP = 0x9D;

/**
 * The opcode constant.
 *
 * @type {number}
 */
DataIndication.OPCODE = 0x01;

ZtcFrame.registerFrame(DataIndication);

module.exports = DataIndication;