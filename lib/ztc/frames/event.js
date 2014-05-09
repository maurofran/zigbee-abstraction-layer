/*
 * event.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../ztcframe"),
    _ = require("underscore"),
    util = require("util");

/**
 * Create a new Event instance.
 *
 * @param {!ZtcParser} parser - the parser to read frame from
 * @constructor
 */
function Event(parser) {
    ZtcFrame.call(this);
    var _self = this;
    parser.uint8("status").uint8("sapID").tap(function() {
        _.extend(_self, this.vars);
    });
}

util.inherits(Event, ZtcFrame);

/**
 * The opcode group constant.
 *
 * @type {number}
 */
Event.OPCODE_GROUP = 0xA4;

/**
 * The opcode constant.
 *
 * @type {number}
 */
Event.OPCODE = 0x04;

/**
 * Event statuses.
 *
 * @type {{SUCCESS: number, INVALID_REQUEST: number}}
 */
Event.Status = {
    /** Success. */
    SUCCESS: 0x00,
    /** Event not implemented. */
    INVALID_REQUEST: 0xFF
};

/**
 * SAP Handler IDs
 * @type {{NWK_MCPS: number, MCPS_NWK: number, NWK_MLME: number, MLME_NWK: number, NWK_ASP: number, ASP_NWK: number,
 *         APS_NLDE: number, NLDE_APS: number, ZDO_NLME: number, NLME_ZDO: number, AF_APSDE: number, APSDE_AF: number,
 *         APP_AFDE: number, AFDE_APP: number, ZDO_ASPME: number, ASPME_ZDO: number, APP_ZDP: number, ZDP_APP: number}}
 */
Event.SAP = {
    /** Nwk to Mcps Saphandler is called. */
    NWK_MCPS: 0x00,
    /** Mcps to Nwk Saphandler is called. */
    MCPS_NWK: 0x01,
    /** Nwk to Mlme Saphandler is called. */
    NWK_MLME: 0x02,
    /** Mlme to Nwk Saphandler is called. */
    MLME_NWK: 0x03,
    /** Nwk to Asp Saphandler is called. */
    NWK_ASP: 0x04,
    /** Mcps to Nwk Saphandler is called. */
    ASP_NWK: 0x05,
    /** Aps to Nlde Saphandler is called. */
    APS_NLDE: 0x06,
    /** Nlde to Aps Saphandler is called. */
    NLDE_APS: 0x07,
    /** Zdo to Nlme Saphandler is called. */
    ZDO_NLME: 0x08,
    /** Nlme to Zdo Saphandler is called. */
    NLME_ZDO: 0x09,
    /** Af to Apse Saphandler is called. */
    AF_APSDE: 0x0A,
    /** Apsde to Af Saphandler is called. */
    APSDE_AF: 0x0B,
    /** App to Afde Saphandler is called. */
    APP_AFDE: 0x0C,
    /** Afde to App Saphandler is called. */
    AFDE_APP: 0x0D,
    /** Zdo to Apsme Saphandler is called. */
    ZDO_ASPME: 0x0E,
    /** Apsme to Zdo Saphandler is called. */
    ASPME_ZDO: 0x0F,
    /** App to Zdp Saphandler is called. */
    APP_ZDP: 0x10,
    /** Zdp to App Saphandler is called. */
    ZDP_APP: 0x11
};

ZtcFrame.registerFrame(Event);

module.exports = Event;