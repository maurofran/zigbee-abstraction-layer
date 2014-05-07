/*
 * ieeeaddress.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

/**
 * Creates a new IEEEAddress given the provided buffer content.
 *
 * @param {!Buffer} buffer - the buffer used to initialize the IEEE address
 * @constructor
 */
function IEEEAddress(buffer) {
    this.buffer = buffer;
}

/**
 * The length, in bytes, of this data.
 *
 * @type {number}
 */
IEEEAddress.LENGTH = 8;

module.exports = IEEEAddress;