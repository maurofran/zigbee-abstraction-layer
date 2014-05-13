###
  ztc-builder-spec.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

{expect} = require "chai"
moment = require "moment"
ZtcBuilder = require "../../lib/ztc/ztc-builder"
{ShortAddress} = require "../../lib/ztc/datatypes"
{IEEEAddress} = require "../../lib/ztc/datatypes"
{PANId} = require "../../lib/ztc/datatypes"
{Key} = require "../../lib/ztc/datatypes"

describe "ZtcBuilder", () ->
  fixture = null

  beforeEach () ->
    fixture = new ZtcBuilder

  describe "#moment(moment)", () ->
    it "Should write a moment object and return this.", () ->
      time = moment [2000, 0, 1, 0, 0, 32, 0]
      buffer = fixture.moment(time).result()

      expect(buffer).is.not.null
      expect(buffer).to.have.length 4
      expect(buffer).to.deep.equal new Buffer([0x20, 0x00, 0x00, 0x00])

  describe "#boolean(value)", () ->
    it "Should write a boolean object and return this.", () ->
      buffer = fixture.boolean(true).result()

      expect(buffer).is.not.null
      expect(buffer).to.have.length 1
      expect(buffer).to.deep.equal new Buffer([0x01])

  describe "#shortAddress(shortAddress)", () ->
    it "Should write a short address object and return this.", () ->
      shortAddress = new ShortAddress new Buffer([0x01, 0x02])
      buffer = fixture.shortAddress(shortAddress).result()

      expect(buffer).is.not.null
      expect(buffer).to.have.length 2
      expect(buffer).to.deep.equal shortAddress.asBuffer()

  describe "#ieeeAddress(ieeeAddress)", () ->
    it "Should write an IEEE address object and return this.", () ->
      ieeeAddress = new IEEEAddress new Buffer("01234567")
      buffer = fixture.ieeeAddress(ieeeAddress).result()

      expect(buffer).is.not.null
      expect(buffer).to.have.length 8
      expect(buffer).to.deep.equal ieeeAddress.asBuffer()

    it "Should write an empty IEEE address object and return this.", () ->
      buffer = fixture.ieeeAddress(null).result()

      expect(buffer).is.not.null
      expect(buffer).to.have.length 8
      expect(buffer).to.deep.equal IEEEAddress.EMPTY_ADDRESS.asBuffer()

  describe "#panId(panId)", () ->
    it "Should write a PANId object and return this.", () ->
      panId = new PANId new Buffer("12345678")
      buffer = fixture.panId(panId).result()

      expect(buffer).is.not.null
      expect(buffer).to.have.length 8
      expect(buffer).to.deep.equal panId.asBuffer()

  describe "#key(key)", () ->
    it "Should write a Key object and return this.", () ->
      key = new Key new Buffer("0123456789ABCDEF")
      buffer = fixture.key(key).result()

      expect(buffer).is.not.null
      expect(buffer).to.have.length 16
      expect(buffer).to.deep.equal key.asBuffer()

