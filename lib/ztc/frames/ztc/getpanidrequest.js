/*
 * getpanidrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new GetPanIDRequest.
 *
 * @constructor
 */
function GetPanIDRequest() {
    ZtcFrame.call(this, GetPanIDRequest.OPCODE_GROUP, GetPanIDRequest.OPCODE);
}

util.inherits(GetPanIDRequest, ZtcFrame);

/*
 * GetPanIDRequest payload has no content, so the _writePayload method it's not overridden.
 */

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
GetPanIDRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
GetPanIDRequest.OPCODE = 0x14;

ZtcFrame.registerFrame(GetPanIDRequest);

module.exports = GetPanIDRequest;