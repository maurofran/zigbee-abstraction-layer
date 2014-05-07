/*
 * ztcbuilder.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var Concentrate = require("concentrate"),
    util = require("util");

/**
 * Creates a new ZtcBuilder, extension of Concentrate used for providing support to custom data types.
 *
 * @constructor
 */
function ZtcBuilder() {
    Concentrate.call(this);
}

util.inherits(ZtcBuilder, Concentrate);

/**
 * Writes an IEEE address object.
 *
 * @param {!IEEEAddress} ieeeAddress - the IEEE address object to use
 * @returns {ZtcBuilder} this instance
 */
ZtcBuilder.prototype.ieeeAddress = function (ieeeAddress) {
    return this.buffer(ieeeAddress.asBuffer());
};

/**
 * Writes a PAN Id object.
 *
 * @param {!PANId} panId - the PAN Id object to write
 * @returns {ZtcBuilder} this instance
 */
ZtcBuilder.prototype.panId = function (panId) {
    return this.buffer(panId.asBuffer());
};

/**
 * Writes a Key object.
 *
 * @param {!Key} key - the Key object to write
 * @returns {ZtcBuilder} this instance
 */
ZtcBuilder.prototype.key = function (key) {
    return this.buffer(key.asBuffer());
};

module.exports = ZtcBuilder;