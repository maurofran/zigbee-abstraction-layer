###
  ztc-parser-spec.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

{expect} = require "chai"
moment = require "moment"
ZtcParser = require "../../lib/ztc/ztc-parser"
datatypes = require "../../lib/ztc/datatypes"

describe "ZtcParser", () ->
  fixture = null

  beforeEach () ->
    fixture = new ZtcParser

  describe "#moment(name)", () ->
    it "Should create a moment instance variable and return this.", (done) ->
      fixture.moment "time"
      fixture.tap () -> @push @vars

      fixture.on "readable", () ->
        data = fixture.read();
        expect(data).to.contain.keys ["time"]
        expect(moment.isMoment(data.time)).to.be.true
        done()

      fixture.end new Buffer([0x05, 0x43, 0x27, 0x98])

  describe "#boolean(name)", () ->
    it "Should create a boolean variable and return this.", (done) ->
      fixture.boolean "value"
      fixture.tap () -> @push @vars
      fixture.on "readable", () ->
        data = fixture.read()
        expect(data).to.contain.keys ["value"]
        expect(data.value).to.be.true
        done()
      fixture.end new Buffer([0x01])

  describe "#shortAddress(name)", () ->
    it "Should create a short address variable and return this.", (done) ->
      fixture.shortAddress "shortAddress"
      fixture.tap () -> @push @vars
      fixture.on "readable", () ->
        data = fixture.read()
        expect(data).to.contain.keys ["shortAddress"]
        expect(data.shortAddress).to.be.instanceof datatypes.ShortAddress
        done()
      fixture.end new Buffer([0x01, 0x02])

  describe "#ieeeAddress(name)", () ->
    it "Should create an IEEE address variable and return this.", (done) ->
      fixture.ieeeAddress "networkAddress"
      fixture.tap () -> @push @vars
      fixture.on "readable", () ->
        data = fixture.read()
        expect(data).to.contain.keys ["networkAddress"]
        expect(data.networkAddress).to.be.instanceof datatypes.IEEEAddress
        done()
      fixture.end new Buffer([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])

  describe "#panId(name)", () ->
    it "Should create a PANId variable and return this.", (done) ->
      fixture.panId "extendedPANId"
      fixture.tap () -> @push @vars
      fixture.on "readable", () ->
        data = fixture.read()
        expect(data).to.contain.keys ["extendedPANId"]
        expect(data.extendedPANId).to.be.instanceof datatypes.PANId
        done()
      fixture.end new Buffer([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])

  describe "#key(name)", () ->
    it "Should create a Key variable and return this.", (done) ->
      fixture.key "networkKey"
      fixture.tap () -> @push @vars
      fixture.on "readable", () ->
        data = fixture.read()
        expect(data).to.contain.keys ["networkKey"]
        expect(data.networkKey).to.be.instanceof datatypes.Key
        done()
      fixture.end new Buffer("1234567890ABCDEF")