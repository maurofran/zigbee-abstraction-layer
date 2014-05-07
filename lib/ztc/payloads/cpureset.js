/*
 * cpureset.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcPayload= require("../ztcpayload"),
    util = require("util");

/**
 * Creates a new CPUReset for the provided source.
 *
 * @constructor
 */
function CPUReset() {
    ZtcPayload.call(this);
}

util.inherits(CPUReset, ZtcPayload);

/**
 * Retrieve the command as buffer.
 *
 * @returns {Buffer}
 */
CPUReset.prototype.asBuffer = function () {
    return new Buffer(0);
};

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

module.exports = CPUReset;