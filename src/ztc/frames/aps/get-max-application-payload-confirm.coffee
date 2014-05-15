###
  get-max-application-payload-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class GetMaxApplicationPayloadConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x27

  constructor: (parser) ->
    super GetMaxApplicationPayloadConfirm.OPCODE_GROUP, GetMaxApplicationPayloadConfirm.OPCODE
    parser.uint8 "maxPayload"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame GetMaxApplicationPayloadConfirm

module.exports = GetMaxApplicationPayloadConfirm