###
  add-group-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class AddGroupConfirm extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0xE8

  @Status =
    SUCCESS: 0x00
    TABLE_FULL: 0xAE
    INVALID_PARAMETER: 0xA6
    APS_NOT_SUPPORTED: 0x84

  constructor: (parser) ->
    super AddGroupConfirm.OPCODE_GROUP, AddGroupConfirm.OPCODE
    parser.uint8 "status"
    parser.shortAddress "groupId"
    parser.uint8 "endpoint"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame AddGroupConfirm

module.exports = AddGroupConfirm