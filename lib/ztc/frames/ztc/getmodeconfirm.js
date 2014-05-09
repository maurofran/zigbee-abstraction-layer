/*
 * getmodeconfirm.js
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
 * Create a new GetModeConfirm instance.
 *
 * @param {!ZtcParser} parser - the parser to read frame from
 * @constructor
 */
function GetModeConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("status").uint8("uartTxBlocking").tap("modes", function() {
        this.uint8("mcps")
            .uint8("mlme")
            .uint8("asp")
            .uint8("nlde")
            .uint8("nlme")
            .uint8("apsde")
            .uint8("apsme")
            .uint8("afde")
            .uint8("zdp")
            .tap(function () {
                _.extend(_self, this.vars);
           });
    });
}

util.inherits(GetModeConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
GetModeConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
GetModeConfirm.OPCODE = 0x02;

ZtcFrame.registerFrame(GetModeConfirm);

module.exports = GetModeConfirm;