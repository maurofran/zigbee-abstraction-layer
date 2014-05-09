/*
 * debugevent.js
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
 * Create a new DebugEvent instance.
 *
 * @param {!ZtcParser} parser - the parser to read frame from
 * @constructor
 */
function DebugEvent(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.shortAddress("messageAddress").uint8("status").uint8("opCodeGroup").uint8("opCode").buffer("data", 32)
        .tap(function() {
            _.extend(_self, this.vars);
        });
}

util.inherits(DebugEvent, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
DebugEvent.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
DebugEvent.OPCODE = 0xFF;

ZtcFrame.registerFrame(DebugEvent);

module.exports = DebugEvent;