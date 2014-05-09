/*
 * getnumofmsgsrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new GetNumOfMsgsRequest.
 *
 * @constructor
 */
function GetNumOfMsgsRequest() {
    ZtcFrame.call(this, GetNumOfMsgsRequest.OPCODE_GROUP, GetNumOfMsgsRequest.OPCODE);
}

util.inherits(GetNumOfMsgsRequest, ZtcFrame);

/*
 * GetNumOfMsgsRequest payload has no content, so the _writePayload method it's not overridden.
 */

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
GetNumOfMsgsRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
GetNumOfMsgsRequest.OPCODE = 0x24;

ZtcFrame.registerFrame(GetNumOfMsgsRequest);

module.exports = GetNumOfMsgsRequest;