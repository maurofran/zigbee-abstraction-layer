/*
 * nvgetdatasetdescrequest.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../ztcframe"),
    util = require("util");

/**
 * Creates a new NVGetDataSetDescRequest.
 *
 * @constructor
 */
function NVGetDataSetDescRequest() {
    ZtcFrame.call(this, NVGetDataSetDescRequest.OPCODE_GROUP, NVGetDataSetDescRequest.OPCODE);
}

util.inherits(NVGetDataSetDescRequest, ZtcFrame);

/*
 * NVGetDataSetDescRequest payload has no content, so the _writePayload method it's not overridden.
 */

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
NVGetDataSetDescRequest.OPCODE_GROUP = 0xA3;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
NVGetDataSetDescRequest.OPCODE = 0xE5;

ZtcFrame.registerFrame(NVGetDataSetDescRequest);

module.exports = NVGetDataSetDescRequest;