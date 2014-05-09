/*
 * writesasconfirm.js
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
 * Create a new WriteSASConfirm instance.
 *
 * @param {!ZtcParser} parser - the parser to read frame from
 * @constructor
 */
function WriteSASConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("status").tap(function() {
        _.extend(_self, this.vars);
    });
}

util.inherits(WriteSASConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
WriteSASConfirm.OPCODE_GROUP = 0x50;

/**
 * The opcode constant.
 *
 * @type {number}
 */
WriteSASConfirm.OPCODE = 0x04;

ZtcFrame.registerFrame(WriteSASConfirm);

module.exports = WriteSASConfirm;