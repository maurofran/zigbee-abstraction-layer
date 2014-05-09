/*
 * getchannelconfirm.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../ztcframe"),
    _ = require("underscore"),
    util = require("util");

/**
 * Create a new GetChannelConfirm instance.
 *
 * @param {!ZtcParser} parser - the parser to read frame from
 * @constructor
 */
function GetChannelConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("status").uint8("channel").tap(function() {
        _.extend(_self, this.vars);
    });
}

util.inherits(GetChannelConfirm, ZtcFrame);

/**
 * Statuses.
 *
 * @type {{SUCCESS: number}}
 */
GetChannelConfirm.Status = {
    SUCCESS: 0x00
};

/**
 * The opcode group constant.
 *
 * @type {number}
 */
GetChannelConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
GetChannelConfirm.OPCODE = 0x12;

ZtcFrame.registerFrame(GetChannelConfirm);

module.exports = GetChannelConfirm;