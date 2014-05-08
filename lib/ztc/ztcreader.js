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
    ZtcParser = require("./ztcparser"),
    ZtcFrame = require("./ztcframe");

/**
 * Creates a new ZtcMessage that reads from the provided readable
 *
 * @param {!Readable} readable the object from which read ZtcMessage.
 * @constructor
 */
function ZtcReader(readable) {
    events.EventEmitter.call(this);
    this.parser = new ZtcParser();
    readable.pipe(this.parser);
    var _self = this;
    this.parser.loop(function() {
        this.ztcFrame("frame").tap(function () {
            if (this.vars.frame !== undefined) {
                if (this.vars.valid) {
                    _self.emit("frame", this.vars.frame);
                } else {
                    _self.emit("error", util.format("Invalid checksum detected: %d expected, %d found",
                            this.vars.checksum, this.vars.calculatedChecksum));
                }
            }
            this.vars = {};
        });
    });
}

util.inherits(ZtcReader, events.EventEmitter);

module.exports = ZtcReader;