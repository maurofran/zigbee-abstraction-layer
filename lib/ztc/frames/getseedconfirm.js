/*
 * getseedconfirm.js
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
 * Create a new GetSeedConfirm instance.
 *
 * @param {!ZtcParser} parser - the parser to read frame from
 * @constructor
 */
function GetSeedConfirm(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint16le("seed").tap(function() {
        _.extend(_self, this.vars);
    });
}

util.inherits(GetSeedConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
GetSeedConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
GetSeedConfirm.OPCODE = 0xD0;

ZtcFrame.registerFrame(GetSeedConfirm);

module.exports = GetSeedConfirm;