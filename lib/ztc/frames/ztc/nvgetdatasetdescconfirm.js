/*
 * nvgetdatasetdescconfirm.js
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
 * Create a new NVGetDataSetDescConfirm instance.
 *
 * @param {!ZtcParser} parser - the parser to read frame from
 * @constructor
 */
function NVGetDataSetDescConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("status").uint8("count").tap(function () {
        var count = 0;
        this.loop("datasets", function (end) {
            if (count < this.vars.count) {
                this.uint8("size").uint16le("id");
                count++;
            } else {
                end();
            }
        }).tap(function () {
            _.extend(_self, this.vars);
        });
    });
}

util.inherits(NVGetDataSetDescConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
NVGetDataSetDescConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
NVGetDataSetDescConfirm.OPCODE = 0xE5;

ZtcFrame.registerFrame(NVGetDataSetDescConfirm);

module.exports = NVGetDataSetDescConfirm;