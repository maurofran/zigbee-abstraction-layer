/*
 * ztccontent.json
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

/**
 * Creates a new ZtcPayload object instance.
 *
 * @constructor
 */
function ZtcPayload() {
}

/**
 * Convert this content into a buffer.
 *
 * @returns {Buffer} the buffer with the ZtcContent content
 */
ZtcPayload.prototype.asBuffer = function () {
    return new Buffer(0);
};

module.exports = ZtcPayload;