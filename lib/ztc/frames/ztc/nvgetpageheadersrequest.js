/*
 * nvgetpageheadersrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new NVGetPageHeadersRequest.
 *
 * @constructor
 */
function NVGetPageHeadersRequest() {
    ZtcFrame.call(this, NVGetPageHeadersRequest.OPCODE_GROUP, NVGetPageHeadersRequest.OPCODE);
}

util.inherits(NVGetPageHeadersRequest, ZtcFrame);

/*
 * NVGetPageHeadersRequest payload has no content, so the _writePayload method it's not overridden.
 */

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
NVGetPageHeadersRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
NVGetPageHeadersRequest.OPCODE = 0xE6;

ZtcFrame.registerFrame(NVGetPageHeadersRequest);

module.exports = NVGetPageHeadersRequest;