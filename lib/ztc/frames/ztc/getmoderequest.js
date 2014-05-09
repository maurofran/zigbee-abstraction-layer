/*
 * getmoderequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new GetModeRequest.
 *
 * @constructor
 */
function GetModeRequest() {
    ZtcFrame.call(this, GetModeRequest.OPCODE_GROUP, GetModeRequest.OPCODE);
}

util.inherits(GetModeRequest, ZtcFrame);

/*
 * CPUReset payload has no content, so the _writePayload method it's not overridden.
 */

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
GetModeRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
GetModeRequest.OPCODE = 0x02;

ZtcFrame.registerFrame(GetModeRequest);

module.exports = GetModeRequest;