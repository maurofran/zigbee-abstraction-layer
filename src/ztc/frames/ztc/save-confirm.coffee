###
  save-confirm.coffee
  https://github.com/maurofranceschini/zal

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###
"use strict";

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class SaveConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0xE4

  @Status =
    SUCCESS: 0x00

  constructor: (parser) ->
    super SaveConfirm.OPCODE_GROUP, SaveConfirm.OPCODE
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame SaveConfirm

module.exports = SaveConfirm