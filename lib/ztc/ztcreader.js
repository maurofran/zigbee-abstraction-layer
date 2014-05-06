/*
 * ztcreader.json
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var dissolve = require("dissolve"),
    events = require("events"),
    util = require("util"),
    ZtcFrame = require("./ztcframe");

/**
 * Creates a new ZtcMessage that reads from the provided readable
 *
 * @param {!stream.Readable} readable the object from which read ZtcMessage.
 * @constructor
 */
function ZtcReader(readable) {
    events.EventEmitter.call(this);
    readable.pipe(this._createParser());
}

util.inherits(ZtcReader, events.EventEmitter);

/**
 * Create a new parser.
 *
 * @returns {Dissolve} the parser
 * @private
 */
ZtcReader.prototype._createParser = function () {
    var _self = this;
    return dissolve().loop(function () {
        this.uint8("sync")
            .tap(function () {
                if (this.vars.sync === ZtcFrame.SYN) {
                    this.uint8("opCodeGroup")
                        .uint8("opCode")
                        .uint8("length")
                        .tap(function () {
                            this.buffer("content", this.vars.length);
                        })
                        .uint8("checksum");
                }
            })
            .tap(function () {
                if (this.vars.sync === ZtcFrame.SYN) {
                    var frame = _self._createZtcFrame(this.vars);
                    var checksum = frame.calculateChecksum();
                    if (checksum === this.vars.checksum) {
                        _self.emit("frame", frame);
                    } else {
                        _self.emit("error", util.format("Invalid checksum found: %d expected, %d found",
                            this.vars.checskum, checksum));
                    }
                }
                this.vars = {};
            });
    });
};

/**
 * Create a new ZtcMessage given the provided data.
 *
 * @param {!Object} data the value used to create the ZtcMessage
 * @return {ZtcFrame} the ZtcFrame object
 * @private
 */
ZtcReader.prototype._createZtcFrame = function (data) {
    return new ZtcFrame(data.opCodeGroup, data.opCode, data.content);
};

module.exports = ZtcReader;