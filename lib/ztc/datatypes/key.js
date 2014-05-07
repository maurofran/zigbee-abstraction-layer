/*
 * key.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

/**
 * Creates a new Key given the provided buffer content.
 *
 * @param {!Buffer} buffer the buffer used to initialize the Key
 * @constructor
 */
function Key(buffer) {
    this.buffer = buffer;
}

/**
 * Length of this data type in bytes.
 *
 * @type {number}
 */
Key.LENGTH = 16;

module.exports = Key;