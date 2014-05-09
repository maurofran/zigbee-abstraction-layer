/*
 * ztcreader.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var events = require("events"),
    util = require("util"),
    ZtcParser = require("./ztcparser"),
    ZtcStream = require("./ztcstream");

/**
 * Creates a new ZtcMessage that reads from the provided readable
 *
 * @param {!Readable} readable the object from which read ZtcMessage.
 * @constructor
 */
function ZtcReader(readable) {
    events.EventEmitter.call(this);
    this.parser = new ZtcParser();
    var stream = new ZtcStream({ mode: ZtcStream.Mode.VERIFY });
    readable.pipe(stream).pipe(this.parser);
    var _self = this;
    this.parser.loop(function() {
        this.ztcFrame("frame").tap(function () {
            _self.emit("frame", this.vars.frame);
            this.vars = {};
        });
    });
}

util.inherits(ZtcReader, events.EventEmitter);

module.exports = ZtcReader;