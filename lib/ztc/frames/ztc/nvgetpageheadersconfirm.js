/*
 * nvgetpageheadersconfirm.js
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
 * Create a new NVGetPageHeadersConfirm instance.
 *
 * @param {!ZtcParser} parser - the parser to read frame from
 * @constructor
 */
function NVGetPageHeadersConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("status").uint8("numberOfPages").tap(function () {
        var count = 0;
        this.loop("headers", function (end) {
            if (count < this.vars.numberOfPages) {
                this.uint16le("magicNumber").uint16le("sequenceNumber").uint16le("dataSetId");
                count++;
            } else {
                end();
            }
        }).tap(function () {
            _.extend(_self, this.vars);
        });
    });
}

util.inherits(NVGetPageHeadersConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
NVGetPageHeadersConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
NVGetPageHeadersConfirm.OPCODE = 0xE6;

ZtcFrame.registerFrame(NVGetPageHeadersConfirm);

module.exports = NVGetPageHeadersConfirm;