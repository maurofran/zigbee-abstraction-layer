/*
 * readsas.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame= require("../ztcframe"),
    util = require("util");

/**
 * Creates a new ReadSAS for the provided source.
 *
 * @param {!number} source one of ReadSAS.Source values (ROM or RAM).
 * @constructor
 */
function ReadSAS(source) {
    ZtcFrame.call(this, ReadSAS.OPCODE_GROUP, ReadSAS.OPCODE);
    this.source = source;
}

util.inherits(ReadSAS, ZtcFrame);

/**
 * Writes the ReadSAS payload.
 *
 * @param {!ZtcBuilder} builder - the builder
 * @returns {ZtcBuilder} the builder
 * @protected
 */
ReadSAS.prototype._writePayload = function (builder) {
    return builder.uint8(1).uint8(this.source);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
ReadSAS.OPCODE_GROUP = 0x50;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
ReadSAS.OPCODE = 0x02;

/**
 * Constants used for ReadSAS sources
 * @type {{RAM: number, ROM: number}}
 */
ReadSAS.Source = {
    RAM: 0x00,
    ROM: 0x01
};

module.exports = ReadSAS;