###
  event.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class Event extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x04

  @Status =
    SUCCESS: 0x00
    INVALID_REQUEST: 0xFF

  @HandlerId =
    # Nwk to Mcps Saphandler is called.
    NWK_MCPS: 0x00
    # Mcps to Nwk Saphandler is called.
    MCPS_NWK: 0x01
    # Nwk to Mlme Saphandler is called.
    NWK_MLME: 0x02
    # Mlme to Nwk Saphandler is called.
    MLME_NWK: 0x03
    # Nwk to Asp Saphandler is called.
    NWK_ASP: 0x04
    # Mcps to Nwk Saphandler is called.
    ASP_NWK: 0x05
    # Aps to Nlde Saphandler is called.
    APS_NLDE: 0x06
    # Nlde to Aps Saphandler is called.
    NLDE_APS: 0x07
    # Zdo to Nlme Saphandler is called.
    ZDO_NLME: 0x08
    # Nlme to Zdo Saphandler is called.
    NLME_ZDO: 0x09
    # Af to Apse Saphandler is called.
    AF_APSDE: 0x0A
    # Apsde to Af Saphandler is called.
    APSDE_AF: 0x0B
    # App to Afde Saphandler is called.
    APP_AFDE: 0x0C
    # Afde to App Saphandler is called.
    AFDE_APP: 0x0D
    # Zdo to Apsme Saphandler is called.
    ZDO_ASPME: 0x0E
    # Apsme to Zdo Saphandler is called.
    ASPME_ZDO: 0x0F
    # App to Zdp Saphandler is called.
    APP_ZDP: 0x10
    # Zdp to App Saphandler is called.
    ZDP_APP: 0x11

  constructor: (parser) ->
    super Event.OPCODE_GROUP, Event.OPCODE
    parser.uint8 "status"
    parser.uint8 "sapId"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame Event

module.exports = Event