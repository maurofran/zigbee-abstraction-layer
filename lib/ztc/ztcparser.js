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
    return this.uint8("syn").tap(function () {
        // Check for read SYN byte
        if (this.vars.syn === ZtcFrame.SYN) {
            var checksum = 0;
            this.uint8("opCodeGroup").uint8("opCode").uint8("size").tap(function () {
                checksum = checksum ^ this.vars.opCodeGroup ^ this.vars.opCode ^ this.vars.size;
                this.buffer("payload", this.vars.size).tap(function () {
                    for (var i = 0; i < this.vars.payload.length; i++) {
                        checksum = checksum ^ this.vars.payload[i];
                    }
                    var parser = new ZtcParser();
                    parser.write(this.vars.payload);
                    this.vars[name] = ZtcFrame.create(this.vars.opCodeGroup, this.vars.opCode, this.vars.size, parser);
                    delete this.vars.opCodeGroup;
                    delete this.vars.opCode;
                    delete this.vars.size;
                    delete this.vars.payload;
                });
            }).uint8("checksum").tap(function () {
                this.vars.valid = this.vars.checksum === checksum;
                this.vars.calculatedChecksum = checksum;
            });
        }
    });
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