###
  remove-all-groups-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class RemoveAllGroupsConfirm extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0xEA

  @Status =
    SUCCESS: 0x00
    INVALID_PARAMETER: 0xA6
    APS_NOT_SUPPORTED: 0x84

  constructor: (parser) ->
    super RemoveAllGroupsConfirm.OPCODE_GROUP, RemoveAllGroupsConfirm.OPCODE
    parser.uint8 "status"
    parser.uint8 "endpoint"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame RemoveAllGroupsConfirm

module.exports = RemoveAllGroupsConfirm