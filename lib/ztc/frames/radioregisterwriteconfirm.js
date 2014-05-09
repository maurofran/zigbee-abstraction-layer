/*
 * radioregisterwriteconfirm.js
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
 * Create a new RadioRegisterWriteConfirm instance.
 *
 * @param {!ZtcParser} parser - The parser to read the message from.
 * @constructor
 */
function RadioRegisterWriteConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("status").tap(function () {
        _.extend(_self, this.vars);
    });
}

util.inherits(RadioRegisterWriteConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
RadioRegisterWriteConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
RadioRegisterWriteConfirm.OPCODE = 0x3A;

ZtcFrame.registerFrame(RadioRegisterWriteConfirm);

module.exports = RadioRegisterWriteConfirm;