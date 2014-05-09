/*
 * errorevent.js
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
 * Create a new ErrorEvent instance.
 *
 * @param {!ZtcParser} parser - the parser to read frame from
 * @constructor
 */
function ErrorEvent(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("status").tap(function() {
        _.extend(_self, this.vars);
    });
}

util.inherits(ErrorEvent, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
ErrorEvent.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
ErrorEvent.OPCODE = 0xFE;

ZtcFrame.registerFrame(ErrorEvent);

module.exports = ErrorEvent;