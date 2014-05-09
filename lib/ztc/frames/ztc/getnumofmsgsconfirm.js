/*
 * getnumofmsgsconfirm.js
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
 * Create a new GetNumOfMsgsConfirm instance.
 *
 * @param {!ZtcParser} parser - the parser to read frame from
 * @constructor
 */
function GetNumOfMsgsConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("smallBuffers").uint8("bigBuffers").tap(function() {
        _.extend(_self, this.vars);
    });
}

util.inherits(GetNumOfMsgsConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
GetNumOfMsgsConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
GetNumOfMsgsConfirm.OPCODE = 0x24;

ZtcFrame.registerFrame(GetNumOfMsgsConfirm);

module.exports = GetNumOfMsgsConfirm;