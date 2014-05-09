/*
 * getpanidconfirm.js
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
 * Create a new GetPanIdConfirm instance.
 *
 * @param {!ZtcParser} parser - the parser to read frame from
 * @constructor
 */
function GetPanIdConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("status").panId("panId").tap(function() {
        _.extend(_self, this.vars);
    });
}

util.inherits(GetPanIdConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
GetPanIdConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
GetPanIdConfirm.OPCODE = 0x14;

ZtcFrame.registerFrame(GetPanIdConfirm);

module.exports = GetPanIdConfirm;