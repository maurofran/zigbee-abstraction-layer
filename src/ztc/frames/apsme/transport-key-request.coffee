###
  transport-key-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class TransportKeyRequest extends ZtcFrame
  @OPCODE_GROUP = 0x99
  @OPCODE = 0xD1

  @KeyType =
    TRUST_CENTER_MASTER_KEY: 0x00
    NETWORK_KEY: 0x01
    APPLICATION_MASTER_1_LINK_KEY: 0x02
    APPLICATION_MASTER_2_LINK_KEY: 0x03
    HIGH_SECURITY_NETWORK_KEY: 0x05

  constructor: (@keyType, others) ->
    super TransportKeyRequest.OPCODE_GROUP, TransportKeyRequest.OPCODE
    switch @keyType
      when TransportKeyRequest.KeyType.TRUST_CENTER_MASTER_KEY
        {@destAddress, @parentAddress, @tcMasterKey} = others
      when TransportKeyRequest.KeyType.NETWORK_KEY
        {@destAddress, @keySeqNumber, @networkKey, @useParent, @parentAddress} = others
      when TransportKeyRequest.KeyType.HIGH_SECURITY_NETWORK_KEY
        {@destAddress, @keySeqNumber, @networkKey, @useParent, @parentAddress} = others
      when TransportKeyRequest.KeyType.APPLICATION_MASTER_1_LINK_KEY
        {@destAddress, @partnerAddress, @initiator, @key} = others
      when TransportKeyRequest.KeyType.APPLICATION_MASTER_2_LINK_KEY
        {@destAddress, @partnerAddress, @initiator, @key} = others

  _writePayload: (builder) ->
    switch @keyType
      when TransportKeyRequest.KeyType.TRUST_CENTER_MASTER_KEY
        builder.uint8 2 + 32
        builder.uint8 @keyType
        builder.ieeeAddress @destAddress
        builder.ieeeAddress @parentAddress
        builder.key @tcMasterKey
      when TransportKeyRequest.KeyType.NETWORK_KEY
        builder.uint8 2 + 34
        builder.uint8 @keyType
        builder.ieeeAddress @destAddress
        builder.uint8 @keySeqNumber
        builder.key @networkKey
        builder.boolean @useParent
        builder.ieeeAddress @parentAddress ? null
      when TransportKeyRequest.KeyType.HIGH_SECURITY_NETWORK_KEY
        builder.uint8 2 + 34
        builder.uint8 @keyType
        builder.ieeeAddress @destAddress
        builder.uint8 @keySeqNumber
        builder.key @networkKey
        builder.boolean @useParent
        builder.ieeeAddress @parentAddress ? null
      when TransportKeyRequest.KeyType.APPLICATION_MASTER_1_LINK_KEY
        builder.uint8 2 + 33
        builder.uint8 @keyType
        builder.ieeeAddress @destAddress
        builder.ieeeAddress @partnerAddress
        builder.boolean @initiator
        builder.key @key
      when TransportKeyRequest.KeyType.APPLICATION_MASTER_2_LINK_KEY
        builder.uint8 2 + 33
        builder.uint8 @keyType
        builder.ieeeAddress @destAddress
        builder.ieeeAddress @partnerAddress
        builder.boolean @initiator
        builder.key @key

ZtcFrame.registerFrame TransportKeyRequest

module.exports = TransportKeyRequest