/*
 * radioregisterreadconfirm.js
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
 * Create a new RadioRegisterReadConfirm instance.
 *
 * @param {!ZtcParser} parser - The parser to read the message from.
 * @constructor
 */
function RadioRegisterReadConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint16le("value").tap(function () {
        _.extend(_self, this.vars);
    });
}

util.inherits(RadioRegisterReadConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
RadioRegisterReadConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
RadioRegisterReadConfirm.OPCODE = 0x3A;

ZtcFrame.registerFrame(RadioRegisterReadConfirm);

module.exports = RadioRegisterReadConfirm;