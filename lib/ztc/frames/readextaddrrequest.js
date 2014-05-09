/*
 * readextaddrrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../ztcframe"),
    util = require("util");

/**
 * Creates a new ReadExtAddressRequest.
 *
 * @constructor
 */
function ReadExtAddrRequest() {
    ZtcFrame.call(this, ReadExtAddrRequest.OPCODE_GROUP, ReadExtAddrRequest.OPCODE);
}

util.inherits(ReadExtAddrRequest, ZtcFrame);

/*
 * ReadExtAddrRequest payload has no content, so the _writePayload method it's not overridden.
 */

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
ReadExtAddrRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
ReadExtAddrRequest.OPCODE = 0xD2;

ZtcFrame.registerFrame(ReadExtAddrRequest);

module.exports = ReadExtAddrRequest;