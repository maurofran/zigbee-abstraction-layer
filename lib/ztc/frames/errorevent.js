/*
 * errorevent.js
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

/**
 * Map holding all the error codes.
 *
 * @type {{SUCCESS: number, OUT_OF_MESSAGES: number, ENDPOINT_TABLE_IS_FULL: number, ENDPOINT_NOT_FOUND: number,
 *        UNKNOWN_OPCODE_GROUP: number, OPCODE_GROUP_IS_DISABLED: number, DEBUG_PRINT_FAILED: number, READ_ONLY: number,
 *        UNKNOWN_BI_IDENTIFIER: number, REQUEST_IS_DISABLED: number, UNKNOWN_OPCODE: number, TOO_BIG: number,
 *        ERROR: number}}
 */
ErrorEvent.Errors = {
    /** Should not be seen in this event. */
    SUCCESS: 0x00,
    /** ZTC tried to allocate a message, but the alloction failed. */
    OUT_OF_MESSAGES: 0xF4,
    /** Self explanatory. */
    ENDPOINT_TABLE_IS_FULL: 0xF5,
    /** Self explanatory. */
    ENDPOINT_NOT_FOUND: 0xF6,
    /** ZTC does not recognize the opcode group, and there is no application hook. */
    UNKNOWN_OPCODE_GROUP: 0xF7,
    /** ZTC support for an opcode group is turned off by a compile option. */
    OPCODE_GROUP_IS_DISABLED: 0xF8,
    /** An attempt to print a debug message ran out of buffer space. */
    DEBUG_PRINT_FAILED: 0xF9,
    /** Attempt to set read-only data. */
    READ_ONLY: 0xFA,
    /** Self explanatory. */
    UNKNOWN_BI_IDENTIFIER: 0xFB,
    /** ZTC support for an opcode is turned off by a compile option. */
    REQUEST_IS_DISABLED: 0xFC,
    /** Self explanatory. */
    UNKNOWN_OPCODE: 0xFD,
    /** A data item to be set or retrieved is too big for the buffer available to hold it. */
    TOO_BIG: 0xFE,
    /** Non-specific, catchall error code. */
    ERROR: 0xFF
};

ZtcFrame.registerFrame(ErrorEvent);

module.exports = ErrorEvent;