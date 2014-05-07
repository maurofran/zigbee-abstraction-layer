/*
 * shortaddress.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

/**
 * Creates a new ShortAddress given the provided buffer content.
 *
 * @param {!Buffer} buffer - the buffer used to initialize the IEEE address
 * @constructor
 */
function ShortAddress(buffer) {
    this.buffer = buffer;
}

/**
 * The length, in bytes, of this data.
 *
 * @type {number}
 */
ShortAddress.LENGTH = 2;

/**
 * Returns the representation of this IEEE address as a buffer.
 *
 * @return {Buffer} the buffer
 */
ShortAddress.prototype.asBuffer = function () {
    return this.buffer;
};

module.exports = ShortAddress;