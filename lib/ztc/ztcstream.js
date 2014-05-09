/*
 * ztcstream.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
/* jshint bitwise: false */
"use strict";

var Transform = require("stream").Transform,
    util = require("util"),
    ZtcFrame = require("./ztcframe");

/**
 * Creates a new ZtcStream instance.
 *
 * @param {Object} options - The options to be provided to read an write streams.
 * @constructor
 */
function ZtcStream(options) {
    Transform.call(this, options);
    options = options || {};
    this._mode = options.mode || ZtcStream.Mode.CALCULATE;
    this._checksum = null;
    this._payloadLength = null;
    this._remainingBytes = null;
    this._buffers = [];
}

util.inherits(ZtcStream, Transform);

/**
 * Constant used to provide the operating mode of this ZtcStream.
 *
 * @type {{CALCULATE: number, VERIFY: number}}
 */
ZtcStream.Mode = {
    CALCULATE: 0x00,
    VERIFY: 0x01
};

/**
 * Transform the input buffer, by adding the _checksum.
 *
 * @param {Buffer|String} chunk - The chunk to be transformed.
 * @param {String} [encoding] - The encoding if <code>chunk</code> is a string.
 * @param {Function} callback - The callback to be invoked on completion
 * @private
 */
ZtcStream.prototype._transform = function (chunk, encoding, callback) {
    var pos = 0,
        start = 0;
    while (pos < chunk.length && this._checksum === null) {
        if (chunk[pos] === ZtcFrame.SYN) {
            start = pos;
            this._checksum = 0;
            this._remainingBytes = 3;
        }
        pos++;
    }
    // Once here we have found the SYN and pos is the byte after SYN.
    while (pos < chunk.length && this._payloadLength === null && this._remainingBytes > 0) {
        this._checksum = this._checksum ^ chunk[pos];
        if (this._remainingBytes === 1) {
            this._payloadLength = chunk[pos];
        }
        pos++;
        this._remainingBytes--;
    }
    if (this._checksum !== null) {
        if (this._remainingBytes === 0) {
            // Once here we have read the payload length.
            this._remainingBytes = this._payloadLength;
            while (pos < chunk.length && this._remainingBytes > 0) {
                this._checksum = this._checksum ^ chunk[pos];
                pos++;
                this._remainingBytes--;
            }
            // Once here we have finished the buffer or the payload.
            if (this._mode === ZtcStream.Mode.VERIFY) {
                if (pos < chunk.length) {
                    var checksum = chunk[pos++];
                    if (checksum === this._checksum) {
                        // Checksum is Ok
                        for (var i = 0; i < this._buffers.length; i++) {
                            this.push(this._buffers[i]);
                        }
                        this.push(chunk.slice(start, pos));
                    }
                    // Checksum is failing
                    this._buffers = [];
                    this._checksum = null;
                    this._remainingBytes = null;
                    this._payloadLength = null;
                    this._transform(chunk.slice(pos), encoding, callback);
                } else {
                    this._buffers.push(chunk.slice(start));
                    callback(null);
                }
            } else {
                if (this._remainingBytes > 0) {
                    // We have finished the buffer.
                    this.push(chunk.slice(start));
                    callback(null);
                } else {
                    // We have finished the payload.
                    this.push(chunk.slice(start, pos));
                    this.push(new Buffer([this._checksum]));
                    this._buffers = [];
                    this._checksum = null;
                    this._remainingBytes = null;
                    this._payloadLength = null;
                    if (pos === chunk.length) {
                        // No more byte to transform.
                        callback(null);
                    } else {
                        // Transform the rest of the payload.
                        this._transform(chunk.slice(pos), encoding, callback);
                    }
                }
            }
        } else {
            var toSend = chunk.slice(start);
            if (this._mode === ZtcStream.Mode.CALCULATE) {
                this.push(toSend);
            } else {
                this._buffers.push(toSend);
            }
            callback(null);
        }
    }
};

module.exports = ZtcStream;