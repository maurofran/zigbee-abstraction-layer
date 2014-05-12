###
  cpu-reset.js
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require("../../ztc-frame")

class CPUReset extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x08

  constructor: () ->
    super CPUReset.OPCODE_GROUP, CPUReset.OPCODE

ZtcFrame.registerFrame CPUReset

module.exports = CPUReset