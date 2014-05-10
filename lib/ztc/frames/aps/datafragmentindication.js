/*
 * datafragmentindication.js
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
 * Create a new DataFragmentIndication instance.
 *
 * @param {!ZtcParser} parser - The parser to read the message from.
 * @constructor
 */
function DataFragmentIndication(parser) {
    ZtcFrame.call(this, DataFragmentIndication.OPCODE_GROUP, DataFragmentIndication.OPCODE);
    var _self = this;
    parser.uint8("blockNumber").uint8("moreBlocks").uint8("dataLength").tap(function () {
        this.vars.moreBlocks = !!this.vars.moreBlocks;
        this.buffer("data", this.vars.dataLength).tap(function () {
            delete this.vars.dataLength;
            _.extend(_self, this.vars);
        });
    });
}

util.inherits(DataFragmentIndication, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
DataFragmentIndication.OPCODE_GROUP = 0x9D;

/**
 * The opcode constant.
 *
 * @type {number}
 */
DataFragmentIndication.OPCODE = 0x02;

ZtcFrame.registerFrame(DataFragmentIndication);

module.exports = DataFragmentIndication;