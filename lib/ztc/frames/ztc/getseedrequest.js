/*
 * getseedrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new GetSeedRequest.
 *
 * @constructor
 */
function GetSeedRequest() {
    ZtcFrame.call(this, GetSeedRequest.OPCODE_GROUP, GetSeedRequest.OPCODE);
}

util.inherits(GetSeedRequest, ZtcFrame);

/*
 * GetSeedRequest payload has no content, so the _writePayload method it's not overridden.
 */

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
GetSeedRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
GetSeedRequest.OPCODE = 0xD0;

ZtcFrame.registerFrame(GetSeedRequest);

module.exports = GetSeedRequest;