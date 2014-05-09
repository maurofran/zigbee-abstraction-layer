/*
 * ztcparser.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
/* jshint bitwise: false */
"use strict";

var Dissolve = require("dissolve"),
    util = require("util"),
    datatypes = require("./datatypes"),
    ShortAddress = datatypes.ShortAddress,
    IEEEAddress = datatypes.IEEEAddress,
    PANId = datatypes.PANId,
    Key = datatypes.Key,
    ZtcFrame = require("./ztcframe");

require("./frames");

/**
 * Creates a new ZtcParser object given the provided buffer content.
 *
 * @constructor
 */
function ZtcParser() {
    Dissolve.call(this);
}

util.inherits(ZtcParser, Dissolve);

/**
 * Method used to parse a ZTC frame.
 *
 * @param {!String} name - the name of the field
 * @returns {ZtcParser} this instance
 */
ZtcParser.prototype.ztcFrame = function (name) {
    return this.uint8("syn").uint8("opCodeGroup").uint8("opCode").uint8("size").tap(function() {
        this.vars[name] = ZtcFrame.create(this.vars.opCodeGroup, this.vars.opCode, this.vars.size, this);
        delete this.vars.opCodeGroup;
        delete this.vars.opCode;
        delete this.vars.size;
    }).uint8("checksum");
};

/**
 * Method used to read a short address.
 *
 * @param {!String} name - the name of the field
 * @returns {ZtcParser} this instance
 */
ZtcParser.prototype.shortAddress = function (name) {
    return this.buffer(name, ShortAddress.LENGTH).tap(function () {
        this.vars[name] = new ShortAddress(this.vars[name]);
    });
};

/**
 * Method used to read an IEEE address.
 *
 * @param {!String} name - the name of the field
 * @returns {ZtcParser} this instance
 */
ZtcParser.prototype.ieeeAddress = function (name) {
    return this.buffer(name, IEEEAddress.LENGTH).tap(function () {
        this.vars[name] = new IEEEAddress(this.vars[name]);
    });
};

/**
 * Method used to read a PAN Id value.
 *
 * @param {!String} name - the name of the field
 * @return {ZtcParser} this instance
 */
ZtcParser.prototype.panId = function (name) {
    return this.buffer(name, PANId.LENGTH).tap(function () {
        this.vars[name] = new PANId(this.vars[name]);
    });
};

/**
 * Method used to read a Key value.
 *
 * @param {!String} name - the name of the field
 * @return {ZtcParser} this instance
 */
ZtcParser.prototype.key = function (name) {
    return this.buffer(name, Key.LENGTH).tap(function () {
        this.vars[name] = new Key(this.vars[name]);
    });
};

module.exports = ZtcParser;