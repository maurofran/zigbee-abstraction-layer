/*
 * panid.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

/**
 * Creates a new PANId given the provided buffer content.
 *
 * @param {!Buffer} buffer - the buffer used to initialize the PANId
 * @constructor
 */
function PANId(buffer) {
    this.buffer = buffer;
}

/**
 * The length of the buffer of data.
 *
 * @type {number}
 */
PANId.LENGTH = 8;

/**
 * Returns the representation of this PAN id as a buffer.
 *
 * @return {Buffer} the buffer
 */
PANId.prototype.asBuffer = function () {
    return this.buffer;
};

module.exports = PANId;