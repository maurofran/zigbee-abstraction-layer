/*
 * saveconfirm.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcPayload = require("../ztcpayload"),
    _ = require("underscore"),
    dissolve = require("dissolve"),
    util = require("util");

/**
 * Create a new SaveConfirm instance.
 *
 * @param {!Buffer} content the content to create message for
 * @constructor
 */
function SaveConfirm(content) {
    ZtcPayload.call(this);
    this._parseContent(content);
}

util.inherits(SaveConfirm, ZtcPayload);

/**
 * Parse the provided buffer and set the properties of this object accordingly.
 *
 * @param {!Buffer} content the buffer to parse
 * @private
 */
SaveConfirm.prototype._parseContent = function (content) {
    var _self = this;

    dissolve()
        .uint8("status")
        .tap(function () {
            _.extend(_self, this.vars);
            this.vars = {};
        })
        .write(content);
};

/**
 * The opcode group constant.
 *
 * @type {number}
 */
SaveConfirm.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
SaveConfirm.OPCODE = 0xE4;

module.exports = SaveConfirm;