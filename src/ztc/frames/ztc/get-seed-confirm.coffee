###
  get-seed-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class GetSeedConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0xD0

  constructor: (parser) ->
    super GetSeedConfirm.OPCODE_GROUP, GetSeedConfirm.OPCODE
    parser.uint16le "seed"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame GetSeedConfirm

module.exports = GetSeedConfirm