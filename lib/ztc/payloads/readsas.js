/*
 * readsas.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcPayload= require("../ztcpayload"),
    concentrate = require("concentrate"),
    util = require("util");

/**
 * Creates a new ReadSAS for the provided source.
 *
 * @param {!number} source one of ReadSAS.Source values (ROM or RAM).
 * @constructor
 */
function ReadSAS(source) {
    ZtcPayload.call(this);
    this.source = source;
}

util.inherits(ReadSAS, ZtcPayload);

/**
 * Retrieve the command as buffer.
 *
 * @returns {Buffer}
 */
ReadSAS.prototype.asBuffer = function () {
    return concentrate().uint8(this.source).result();
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