###
  ztc-stream.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

{Transform} = require("stream")
ZtcFrame = require("./ztc-frame")

class ZtcStream extends Transform
  # Constants used to provide the operating mode of this ZtcStream.
  @Mode:
    CALCULATE: 0x00
    VERIFY: 0x01

  # Creates a new ZtcStream instance.
  #
  # @param [Object] options the options to be provided to read and write streams
  constructor: (options) ->
    super options
    @_mode = options?.mode ? ZtcStream.Mode.CALCULATE
    @_checksum = null
    @_payloadLength = null
    @_remainingBytes = null
    @_buffers = []

  _transform: (chunk, encoding, callback) ->
    pos = 0
    start = 0

    while pos < chunk.length and not @_checksum?
      if chunk[pos] is ZtcFrame.SYN
        start = pos
        @_checksum = 0
        @_remainingBytes = 3
      pos++
    # Once here whe have found the SYN and pos is the position in the chunk just after SYN
    while pos < chunk.length and not @_payloadLength? and @_remainingBytes > 0
      @_checksum = @_checksum ^ chunk[pos]
      @_payloadLength = chunk[pos] if @_remainingBytes is 1
      pos++
      @_remainingBytes--

    if @_checksum?
      if @_remainingBytes is 0
        # Once here we have read the payload length.
        @_remainingBytes = @_payloadLength
        while pos < chunk.length and @_remainingBytes > 0
          @_checksum = @_checksum ^ chunk[pos]
          pos++
          @_remainingBytes--
        # Once here we have finished the buffer or the payload
        if @_mode is ZtcStream.Mode.VERIFY
          if pos < chunk.length
            checksum = chunk[pos++]
            if checksum is @_checksum
              # Checksum is OK
              @push buffer for buffer in @_buffers
              @push chunk.slice(start, pos)
            @_buffers = []
            @_checksum = null
            @_remainingBytes = null
            @_payloadLength = null
            @_transform chunk.slice(pos), encoding, callback
          else
            @_buffers.push chunk.slice(start)
            callback null
        else
          if @_remainingBytes > 0
            # We have fininshed the buffer
            @push chunk.slice(start)
            callback null
          else
            @push chunk.slice(start, pos)
            @push new Buffer([@_checksum])
            @_buffers = []
            @_checksum = null
            @_remainingBytes = null
            @_payloadLength = null
            if pos is chunk.length
              callback null
            else
              @_transform chunk.slice(pos), encoding, callback
      else
        toSend = chunk.slice(start)
        if @_mode is ZtcStream.Mode.CALCULATE
          @push toSend
        else
          @_buffers.push toSend
        callback null
    else
      callback null

module.exports = ZtcStream