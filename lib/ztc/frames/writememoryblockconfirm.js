/*
 * writememoryblockconfirm.js
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
 * Create a new WriteMemoryBlockConfirm instance.
 *
 * @param {!ZtcParser} parser - The parser to read the message from.
 * @constructor
 */
function WriteMemoryBlockConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.unit8("numberOfBytes").tap(function () {
        _.extend(_self, this.vars);
    });
}

util.inherits(WriteMemoryBlockConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
WriteMemoryBlockConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
WriteMemoryBlockConfirm.OPCODE = 0x31;

ZtcFrame.registerFrame(WriteMemoryBlockConfirm);

module.exports = WriteMemoryBlockConfirm;