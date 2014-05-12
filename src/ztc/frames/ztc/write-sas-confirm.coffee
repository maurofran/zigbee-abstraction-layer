###
  write-sas-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class WriteSASConfirm extends ZtcFrame
  @OPCODE_GROUP = 0x50
  @OPCODE = 0x04

  @Status =
    SUCCESS: 0x00

  constructor: (parser) ->
    super WriteSASConfirm.OPCODE_GROUP, WriteSASConfirm.OPCODE
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame WriteSASConfirm

module.exports = WriteSASConfirm