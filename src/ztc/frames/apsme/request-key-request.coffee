###
  request-key-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class RequestKeyRequest extends ZtcFrame
  @OPCODE_GROUP = 0x99
  @OPCODE = 0xD3

  @KeyType =
    NETWORK_KEY: 0x01
    APPLICATION_KEY: 0x02
  
  constructor: (@dstAddress, @type, @partnerAddress) ->
    super RequestKeyRequest.OPCODE_GROUP, RequestKeyRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 17
    builder.ieeeAddress @dstAddress
    builder.uint8 @type
    builder.ieeeAddress @partnerAddress

ZtcFrame.registerFrame RequestKeyRequest

module.exports = RequestKeyRequest