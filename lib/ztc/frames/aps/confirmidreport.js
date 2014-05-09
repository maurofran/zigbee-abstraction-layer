/*
 * confirmidreport.js
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
 * Create a new ConfirmIdReport instance.
 *
 * @param {!ZtcParser} parser - The parser to read the message from.
 * @constructor
 */
function ConfirmIdReport(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("assignedConfirmId").tap(function () {
        _.extend(_self, this.vars);
    });
}

util.inherits(ConfirmIdReport, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
ConfirmIdReport.OPCODE_GROUP = 0x9D;

/**
 * The opcode constant.
 *
 * @type {number}
 */
ConfirmIdReport.OPCODE = 0x03;

ZtcFrame.registerFrame(ConfirmIdReport);

module.exports = ConfirmIdReport;