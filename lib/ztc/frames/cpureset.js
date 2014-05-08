/*
 * cpureset.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../ztcframe"),
    util = require("util");

/**
 * Creates a new CPUReset for the provided source.
 *
 * @constructor
 */
function CPUReset() {
    ZtcFrame.call(this, CPUReset.OPCODE_GROUP, CPUReset.OPCODE);
}

util.inherits(CPUReset, ZtcFrame);

/*
 * CPUReset payload has no content, so the _writePayload method it's not overridden.
 */

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
CPUReset.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
CPUReset.OPCODE = 0x08;

ZtcFrame.registerFrame(CPUReset);

module.exports = CPUReset;