/*
 * getchannelrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../ztcframe"),
    util = require("util");

/**
 * Creates a new GetChannelRequest.
 *
 * @constructor
 */
function GetChannelRequest() {
    ZtcFrame.call(this, GetChannelRequest.OPCODE_GROUP, GetChannelRequest.OPCODE);
}

util.inherits(GetChannelRequest, ZtcFrame);

/*
 * CPUReset payload has no content, so the _writePayload method it's not overridden.
 */

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
GetChannelRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
GetChannelRequest.OPCODE = 0x12;

ZtcFrame.registerFrame(GetChannelRequest);

module.exports = GetChannelRequest;