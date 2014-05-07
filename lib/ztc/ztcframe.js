/*
 * ztcmessage.json
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

/**
 * Creates a new ZtcMessage object with the provided parameters.
 *
 * @param {!number} opCodeGroup the opcode group
 * @param {!number} opCode the opcode value
 * @constructor
 * @abstract
 */
function ZtcFrame(opCodeGroup, opCode) {
    this.opCodeGroup = opCodeGroup;
    this.opCode = opCode;
}

/**
 * Constant used to provide the SYN of the ZtcMessage.
 *
 * @type {number}
 */
ZtcFrame.SYN = 0x02;

/**
 * Writes the content of this ZtcFrame object using the provided ZtcBuilder.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the provided builder
 */
ZtcFrame.prototype.write = function (builder) {
    builder.uint8(ZtcFrame.SYN).uint8(this.opCodeGroup).uint8(this.opCode);
    this._writePayload(builder);
    return builder.uint8(0x00);
};

/**
 * Writes the payload of this ZtcFrame object using the provided ZtcBuilder instance.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the provided builder
 * @protected
 */
ZtcFrame.prototype._writePayload = function (builder) {
    return builder.uint8(0);
};

module.exports = ZtcFrame;