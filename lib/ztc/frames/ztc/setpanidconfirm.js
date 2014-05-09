/*
 * setpanidconfirm.js
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
 * Create a new SetPanIDConfirm instance.
 *
 * @param {!ZtcParser} parser - The parser to read the message from.
 * @constructor
 */
function SetPanIDConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("status").tap(function () {
        _.extend(_self, this.vars);
    });
}

util.inherits(SetPanIDConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
SetPanIDConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
SetPanIDConfirm.OPCODE = 0x15;

ZtcFrame.registerFrame(SetPanIDConfirm);

module.exports = SetPanIDConfirm;