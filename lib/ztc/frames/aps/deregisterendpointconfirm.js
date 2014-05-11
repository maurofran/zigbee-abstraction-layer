/*
 * deregisterendpointconfirm.js
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
 * Create a new DeregisterEndpointConfirm instance.
 *
 * @param {!ZtcParser} parser - The parser to read the message from.
 * @constructor
 */
function DeregisterEndpointConfirm(parser) {
    ZtcFrame.call(this, DeregisterEndpointConfirm.OPCODE_GROUP, DeregisterEndpointConfirm.OPCODE);
    var _self = this;
    parser.uint8("status").tap(function () {
        _.extend(_self, this.vars);
    });
}

util.inherits(DeregisterEndpointConfirm, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
DeregisterEndpointConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
DeregisterEndpointConfirm.OPCODE = 0x0A;

ZtcFrame.registerFrame(DeregisterEndpointConfirm);

module.exports = DeregisterEndpointConfirm;