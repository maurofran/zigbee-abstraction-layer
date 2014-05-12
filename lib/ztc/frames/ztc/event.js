
/*
  event.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
 */

(function() {
  var Event, ZtcFrame, _,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  ZtcFrame = require("../../ztc-frame");

  _ = require("lodash");

  Event = (function(_super) {
    __extends(Event, _super);

    Event.OPCODE_GROUP = 0xA4;

    Event.OPCODE = 0x04;

    Event.Status = {
      SUCCESS: 0x00,
      INVALID_REQUEST: 0xFF
    };

    Event.HandlerId = {
      NWK_MCPS: 0x00,
      MCPS_NWK: 0x01,
      NWK_MLME: 0x02,
      MLME_NWK: 0x03,
      NWK_ASP: 0x04,
      ASP_NWK: 0x05,
      APS_NLDE: 0x06,
      NLDE_APS: 0x07,
      ZDO_NLME: 0x08,
      NLME_ZDO: 0x09,
      AF_APSDE: 0x0A,
      APSDE_AF: 0x0B,
      APP_AFDE: 0x0C,
      AFDE_APP: 0x0D,
      ZDO_ASPME: 0x0E,
      ASPME_ZDO: 0x0F,
      APP_ZDP: 0x10,
      ZDP_APP: 0x11
    };

    function Event(parser) {
      Event.__super__.constructor.call(this, Event.OPCODE_GROUP, Event.OPCODE);
      parser.uint8("status");
      parser.uint8("sapId");
      parser.tap((function(_this) {
        return function() {
          return _.assign(_this, parser.vars);
        };
      })(this));
    }

    return Event;

  })(ZtcFrame);

  ZtcFrame.registerFrame(Event);

  module.exports = Event;

}).call(this);

//# sourceMappingURL=event.js.map
