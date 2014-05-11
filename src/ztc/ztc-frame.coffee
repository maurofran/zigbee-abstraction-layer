###
  ztc-message.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

# Registry of all the ZTC frames.
registry = {}

class ZtcFrame
  # Syncro byte value for ZTC messages.
  @SYN = 0x02

  @registerFrame: (clazz) ->
    registry[clazz.OPCODE_GROUP] = {} unless (registry[clazz.OPCODE_GROUP]?)
    registry[clazz.OPCODE_GROUP][clazz.OPCODE] = clazz

  # Create a new ZtcFrame instance for the provided data.
  #
  # @param [Number] opCodeGroup the opcode group
  # @param [Number] opCode the opcode
  # @param [Number] length the length of the buffer to read
  # @param [ZtcParser] the parser to use to read the payload
  @create: (opCodeGroup, opCode, length, parser) ->
    try
      new registry[opCodeGroup][opCode](parser, length)
    catch ex
      new ZtcFrame opCodeGroup, opCode, length, parser

  # Creates a new ZtcMessage
  #
  # @param [Number] opCodeGroup the opcode group
  # @param [Number] opCode the opcode
  # @param [Number] length the length of the buffer
  # @param [ZtcParser] parser the parser to use to read the payload
  constructor: (@opCodeGroup, @opCode, length, parser) ->
    parser.buffer("payload", length) if length? and parser?

  # Writes the conten of this ZtcFrame object using the provided builder
  #
  # @param [ZtcBuilder] builder the builder to use to write the frame
  # @returns [ZtcBuilder] the provided builder instance to chain method calls
  write: (builder) ->
    builder.uint8(ZtcFrame.SYN).uint8(@opCodeGroup).uint8(@opCode)
    @_writePayload builder

  # Writes the payload of this ZtcFrame object using the provided builder instance.
  #
  # @param [ZtcBuilder] builder the builder to use to write the payload
  # @returns [ZtcBuilder] the provided builder instance
  _writePayload: (builder) ->
    builder.uint8(0)

module.exports = ZtcFrame