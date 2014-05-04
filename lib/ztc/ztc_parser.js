/*
 * ztc_parser.js
 *
 * (C) 2014-2014 Cedac Software S.r.l.
 */
"use strict";

var dissolve = require('dissolve'),
    concentrate = require('concentrate');

/**
 * Creates a new instance of ZtcParser.
 *
 * @constructor
 */
function ZtcParser() {
    this.parser = dissolve().loop(function () {
        this.uint8('sync')
            .tap(function () {
                if (this.sync === ZtcParser.SYN) {
                    this.uint8('opcodeGroup')
                        .uint8('opcode')
                        .uint8('length')
                        .tap(function () {
                            this.buffer('data', this.vars.length);
                        });
                }
            })
            .tap(function () {
                if (this.vars.sync === ZtcParser.SYN) {
                    this.push(this.vars);
                }
                this.vars = {};
            });
    });
}

/**
 * SYN byte of ZTC packets.
 *
 * @type {number}
 */
ZtcParser.SYN = 0x02;

/**
 * Writes a buffer.
 *
 * @param {byte} opCodeGroup the opcode group
 * @param {byte} opCode the opcode
 * @param {Buffer} the buffer to write
 * @return {Buffer} the buffer
 */
ZtcParser.prototype.writeBuffer = function (opCodeGroup, opCode, buffer) {
    return concentrate()
        .uint8(ZtcParser.SYN)
        .uint8(opCodeGroup)
        .uint8(opCode)
        .uint8(buffer.length)
        .buffer(buffer)
        .uint8(this._fcs(opCodeGroup, opCode, buffer))
        .result()
};

/**
 * Calculate the checksum.
 *
 * @param {byte} opCodeGroup the opcode group
 * @param {byte} opCode the opcode
 * @param {Buffer} buffer the buffer to write
 * @return {byte} the buffer
 * @private
 */
ZtcParser.prototype._fcs = function (opCodeGroup, opCode, buffer) {
    var fcs = opCodeGroup ^ opCode ^ buffer.length;
    for (var i = 0; i < buffer.length; i++) {
        fcs = fcs ^ buffer[i];
    }
    return fcs;
};

module.exports.ZtcParser = ZtcParser;

