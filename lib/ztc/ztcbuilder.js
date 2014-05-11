/*
 * ztcbuilder.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var Concentrate = require("concentrate"),
    util = require("util"),
    moment = require("moment");

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
 * Writes a ZTC frame object.
 *
 * @param {!ZtcFrame} frame - the frame to write
 * @returns {ZtcBuilder} this instance
 */
ZtcBuilder.prototype.ztcFrame = function (frame) {
    return frame.write(this);
};

/**
 * Writes a moment object.
 *
 * @param {!moment} time - The moment to write.
 * @returns {ZtcBuilder} this instance
 */
ZtcBuilder.prototype.moment = function (time) {
    var ref = moment().year(2000).startOf("year").second();
    return this.uint32le(time.second() - ref);
};

/**
 * Writes a boolean object.
 *
 * @param {!boolean} value - The boolean value.
 * @returns {ZtcBuilder} this instance
 */
ZtcBuilder.prototype.boolean = function (value) {
    return this.uint8(value ? 0x01 : 0x00);
};

/**
 * Writes a short address object.
 *
 * @param {!ShortAddress} shortAddress - the short address to use
 * @returns {ZtcBuilder} this instance
 */
ZtcBuilder.prototype.shortAddress = function (shortAddress) {
    return this.buffer(shortAddress.asBuffer());
};

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