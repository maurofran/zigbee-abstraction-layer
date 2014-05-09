/*
 * saveconfirm.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    _ = require("underscore"),
    util = require("util");

/**
 * Create a new SaveConfirm instance.
 *
 * @param {!ZtcParser} parser - the parser to read frame from
 * @constructor
 */
function SaveConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("status").tap(function() {
        _.extend(_self, this.vars);
    });
}

util.inherits(SaveConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
SaveConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
SaveConfirm.OPCODE = 0xE4;

ZtcFrame.registerFrame(SaveConfirm);

module.exports = SaveConfirm;