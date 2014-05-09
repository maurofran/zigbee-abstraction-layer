/*
 * pingconfirm.js
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
 * Create a new PingConfirm instance.
 *
 * @param {!ZtcParser} parser - The parser to read the message from.
 * @param {!number} size - The size of the payload.
 * @constructor
 */
function PingConfirm(parser, size) {
    ZtcFrame.call(this);
    var _self = this;
    parser.buffer("echoData", size).tap(function () {
        _.extend(_self, this.vars);
    });
}

util.inherits(PingConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
PingConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
PingConfirm.OPCODE = 0x38;

ZtcFrame.registerFrame(PingConfirm);

module.exports = PingConfirm;