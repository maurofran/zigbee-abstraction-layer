/*
 * removefromaddressmapconfirm.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../ztcframe"),
    _ = require("underscore"),
    util = require("util");

/**
 * Create a new RemoveFromAddressMapConfirm instance.
 *
 * @param {!ZtcParser} parser - The parser to read the message from.
 * @constructor
 */
function RemoveFromAddressMapConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("status").tap(function () {
        _.extend(_self, this.vars);
    });
}

util.inherits(RemoveFromAddressMapConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
RemoveFromAddressMapConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
RemoveFromAddressMapConfirm.OPCODE = 0xC1;

ZtcFrame.registerFrame(RemoveFromAddressMapConfirm);

module.exports = RemoveFromAddressMapConfirm;