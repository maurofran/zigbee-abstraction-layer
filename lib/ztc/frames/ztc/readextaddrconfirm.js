/*
 * readextaddrconfirm.js
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
 * Create a new ReadExtAddrConfirm instance.
 *
 * @param {!ZtcParser} parser - the parser to read frame from
 * @constructor
 */
function ReadExtAddrConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("status").ieeeAddress("deviceAddr").tap(function() {
        _.extend(_self, this.vars);
    });
}

util.inherits(ReadExtAddrConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
ReadExtAddrConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
ReadExtAddrConfirm.OPCODE = 0xD2;

ZtcFrame.registerFrame(ReadExtAddrConfirm);

module.exports = ReadExtAddrConfirm;