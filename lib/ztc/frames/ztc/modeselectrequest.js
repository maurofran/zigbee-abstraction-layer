/*
 * modeselectrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new ModeSelectRequest.
 *
 * @param {!Boolean} uartTxBlocking - Enable UART driver blocking on Tx.
 * @param {!number} mcpsMode - One of the value DISABLE, HOOK and MONITOR.
 * @param {!number} mlmeMode - One of the value DISABLE, HOOK and MONITOR.
 * @param {!number} aspMode - One of the value DISABLE, HOOK and MONITOR.
 * @param {!number} nldeMode - One of the value DISABLE, HOOK and MONITOR.
 * @param {!number} nlmeMode - One of the value DISABLE, HOOK and MONITOR.
 * @param {!number} apsdeMode - One of the value DISABLE, HOOK and MONITOR.
 * @param {!number} afdeMode - One of the value DISABLE, HOOK and MONITOR.
 * @param {!number} apsmeMode - One of the value DISABLE, HOOK and MONITOR.
 * @param {!number} zdpMode - One of the value DISABLE, HOOK and MONITOR.
 * @constructor
 */
function ModeSelectRequest(uartTxBlocking, mcpsMode, mlmeMode, aspMode, nldeMode, nlmeMode, apsdeMode, afdeMode,
                           apsmeMode, zdpMode) {
    ZtcFrame.call(this, ModeSelectRequest.OPCODE_GROUP, ModeSelectRequest.OPCODE);
    this._uartTxBlocking = uartTxBlocking;
    this._mcpsMode = mcpsMode;
    this._mlmeMode = mlmeMode;
    this._aspMode = aspMode;
    this._nldeMode = nldeMode;
    this._nlmeMode = nlmeMode;
    this._apsdeMode = apsdeMode;
    this._afdeMode = afdeMode;
    this._apsmeMode = apsmeMode;
    this._zdpMode = zdpMode;
}

util.inherits(ModeSelectRequest, ZtcFrame);

/**
 * Writes the WriteSAS request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
ModeSelectRequest.prototype._writePayload = function (builder) {
    return builder
        .uint8(10)
        .uint8(this._uartTxBlocking ? 1 : 0)
        .uint8(this._mcpsMode)
        .uint8(this._mlmeMode)
        .uint8(this._aspMode)
        .uint8(this._nldeMode)
        .uint8(this._nlmeMode)
        .uint8(this._apsdeMode)
        .uint8(this._afdeMode)
        .uint8(this._apsmeMode)
        .uint8(this._zdpMode);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
ModeSelectRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
ModeSelectRequest.OPCODE = 0x00;

ZtcFrame.registerFrame(ModeSelectRequest);

module.exports = ModeSelectRequest;