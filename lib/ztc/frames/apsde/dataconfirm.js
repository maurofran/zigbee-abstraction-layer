/*
 * dataconfirm.js
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
 * Create a new DataConfirm instance.
 *
 * @param {!ZtcParser} parser - The parser to read the message from.
 * @constructor
 */
function DataConfirm(parser) {
    ZtcFrame.call(this, DataConfirm.OPCODE_GROUP, DataConfirm.OPCODE);
    var _self = this;
    parser.uint8("dstAddrMode").ieeeAddress("dstAddress").uint8("dstEndpoint").uint8("srcEndpoint")
          .uint8("status").moment("txTime").uint8("confirmId").tap(function () {
        _.extend(_self, this.vars);
    });
}

util.inherits(DataConfirm, ZtcFrame);

/**
 * Data confirm status constants.
 */
DataConfirm.Status = {
    SUCCESS: 0x00,
    PARTIAL_SUCCESS: 0x05,
    SECURITY_FAIL: 0x07,
    APS_INVALID_PARAMETER: 0x0A,
    ZB_NOT_ON_NETWORK: 0x04,
    APS_ILLEGAL_DEVICE: 0x01,
    ZB_NO_MEM: 0x02,
    APS_ASDU_TOO_LONG: 0xA0,
    APS_ILLEGAL_REQUEST: 0xA3,
    NO_BOUND_DEVICE: 0xA8,
    NO_SHORT_ADDRESS: 0xA9,
    APS_TABLE_FULL: 0xAE,
    INVALID_REQUEST: 0xC3,
    MAX_FRM_COUNTER: 0xCC,
    NO_KEY: 0xCD,
    BAD_CCM_OUTPUT: 0xCE,
    TRANSACTION_OVERFLOW: 0xF1,
    TRANSACTION_EXPIRED: 0xF0,
    CHANNEL_ACCESS_FAILURE: 0xE1,
    INVALID_GTS: 0xE6,
    UNAVAILABLE_KEY: 0xF3,
    FRAME_TOO_LONG: 0xE5,
    FAILED_SECURITY_CHECK: 0xE4,
    INVALID_PARAMETER: 0xE8,
    NO_ACK: 0xE9
};

/**
 * The opcode group constant.
 *
 * @type {number}
 */
DataConfirm.OPCODE_GROUP = 0x9D;

/**
 * The opcode constant.
 *
 * @type {number}
 */
DataConfirm.OPCODE = 0x00;

ZtcFrame.registerFrame(DataConfirm);

module.exports = DataConfirm;