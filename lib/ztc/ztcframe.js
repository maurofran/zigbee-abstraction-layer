/*
 * ztcmessage.json
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

/**
 * Creates a new ZtcMessage object with the provided parameters.
 *
 * @param {!number} opCodeGroup - the opcode group
 * @param {!number} opCode - the opcode value
 * @param {!number} [length] - the length of the buffer
 * @param {ZtcParser} [parser] - the buffer
 * @constructor
 * @protected
 */
function ZtcFrame(opCodeGroup, opCode, length, parser) {
    this.opCodeGroup = opCodeGroup;
    this.opCode = opCode;
    if (length !== undefined && parser !== undefined) {
        parser.buffer("payload", length);
    }
}

/**
 * Constant used to provide the SYN of the ZtcMessage.
 *
 * @type {number}
 */
ZtcFrame.SYN = 0x02;

/**
 * Registry used to store the various instances of ZtcFrame for factories.
 *
 * @type {{number, {number, Function}}}
 * @private
 */
ZtcFrame._registry = {};

/**
 * Register the frame constructor function within the internal registry.
 *
 * @param constructor
 */
ZtcFrame.registerFrame = function (constructor) {
    if (ZtcFrame._registry[constructor.OPCODE_GROUP] === undefined) {
        ZtcFrame._registry[constructor.OPCODE_GROUP] = {};
    }
    ZtcFrame._registry[constructor.OPCODE_GROUP][constructor.OPCODE] = constructor;
};

/**
 * Create a new ZtcFrame instance, given the provided opCodeGroup, opCode and buffer
 *
 * @param {!int} opCodeGroup - opcode group
 * @param {!int} opCode - the opcode
 * @param {!int} size - the size of the buffer to be read
 * @param {!ZtcParser} parser - the parser to read the frame from
 * @returns {ZtcFrame} a ZtcFrame (or subclass of it)
 */
ZtcFrame.create = function (opCodeGroup, opCode, size, parser) {
    try {
        var Ctor = ZtcFrame._registry[opCodeGroup][opCode];
        return new Ctor(parser, size);
    } catch (ex) {
        // No specific ZtcFrame is registered.
        return new ZtcFrame(opCodeGroup, opCode, size, parser);
    }
};

/**
 * Writes the content of this ZtcFrame object using the provided ZtcBuilder.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the provided builder
 */
ZtcFrame.prototype.write = function (builder) {
    builder.uint8(ZtcFrame.SYN).uint8(this.opCodeGroup).uint8(this.opCode);
    this._writePayload(builder);
    return builder;
};

/**
 * Writes the payload of this ZtcFrame object using the provided ZtcBuilder instance.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the provided builder
 * @protected
 */
ZtcFrame.prototype._writePayload = function (builder) {
    return builder.uint8(0);
};

module.exports = ZtcFrame;