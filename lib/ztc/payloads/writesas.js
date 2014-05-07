/*
 * readsas.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcPayload = require("../ztcpayload"),
    //concentrate = require("concentrate"),
    util = require("util");


function WriteSAS() {
    ZtcPayload.call(this);
    /*
    Short Address 2 NWK short address
    Extended PAN Id 8
    APS Use Extended PAN Id 8
    PAN Id 2
    Channels Mask 4
    Protocol Version 1
    Stack Profile 1
    Startup Control 1
    Trust Center Address 8
    Trust Center Master Key 16
    Network Key 16
    Use Insecure Join 1
    Preconfigured Trust Center Link Key 16
    Active Nwk Key Seq Number 1
    Network Key Type 1
    Network Manager Address 2
    Scan attempts 1
    Time between scans 2
    Rejoin Interval 2
     Maximum Rejoin Interval 2
     Indirect Poll Rate 2
     Parent Link Retry Threshold 1
     Is Concentrator 1
     Concentrator Radius 1
     Concentrator Discovery Time 1
    */
}

util.inherits(WriteSAS, ZtcPayload);

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
WriteSAS.OPCODE_GROUP = 0x50;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
WriteSAS.OPCODE = 0x01;

WriteSAS.prototype.asBuffer = function () {

};

module.exports = WriteSAS;