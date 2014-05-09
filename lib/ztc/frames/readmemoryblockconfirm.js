/*
 * readmemoryblockconfirm.js
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
 * Create a new ReadMemoryBlockConfirm instance.
 *
 * @param {!ZtcParser} parser - The parser to read the message from.
 * @param {!number} size - The size of the payload.
 * @constructor
 */
function ReadMemoryBlockConfirm(parser, size) {
    ZtcFrame.call(this);
    var _self = this;
    parser.buffer("readData", size).tap(function () {
        _.extend(_self, this.vars);
    });
}

util.inherits(ReadMemoryBlockConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
ReadMemoryBlockConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
ReadMemoryBlockConfirm.OPCODE = 0x31;

ZtcFrame.registerFrame(ReadMemoryBlockConfirm);

module.exports = ReadMemoryBlockConfirm;