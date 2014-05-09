/*
 * readsas.js
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var ZtcFrame = require("../../ztcframe"),
    util = require("util");

/**
 * Creates a new WriteSAS frame with the provided data.
 *
 * @param {!ShortAddress} shortAddress - network short address
 * @param {!PANId} extendedPanId - extended PAN Id
 * @param {!PANId} apsUseExtendedPanId - APS use extended PAN id
 * @param {!number} panId - network PAN id
 * @param {!number} channelsMask - channel mask
 * @param {!number} protocolVersion - version of protocol used
 * @param {!number} stackProfile - stack profile
 * @param {!number} startupControl - startup control
 * @param {!IEEEAddress} trustCenterAddress - trust center IEEE address
 * @param {!Key} trustCenterMasterKey - trust center master key
 * @param {!Key} networkKey - network key
 * @param {!number} useInsecureJoin - use insecure join
 * @param {!Key} preconfiguredTrustCenterLinkKey - pre-configured trust center link key
 * @param {!number} activeNetworkKeySequenceNumber - active network key sequence number
 * @param {!number} networkKeyType - type of network key
 * @param {!ShortAddress} networkManagerAddress - network manager address
 * @param {!number} scanAttempts - scan attempts
 * @param {!number} timeBetweenScans - time between scans
 * @param {!number} rejoinInterval - rejoin interval
 * @param {!number} maximumRejoinInterval - maximum rejoin interval
 * @param {!number} indirectPollRate - indirect poll rate
 * @param {!number} parentLinkRetryThresold - parent link retry threshold
 * @param {!number} isConcentrator - is concentrator
 * @param {!number} concentratorRadius - concentrator radius
 * @param {!number} concentratorDiscoveryTime - concentrator discovery time
 * @constructor
 */
function WriteSAS(shortAddress, extendedPanId, apsUseExtendedPanId, panId, channelsMask, protocolVersion, stackProfile,
                  startupControl, trustCenterAddress, trustCenterMasterKey, networkKey, useInsecureJoin,
                  preconfiguredTrustCenterLinkKey, activeNetworkKeySequenceNumber, networkKeyType,
                  networkManagerAddress, scanAttempts, timeBetweenScans, rejoinInterval, maximumRejoinInterval,
                  indirectPollRate, parentLinkRetryThresold, isConcentrator, concentratorRadius,
                  concentratorDiscoveryTime) {
    ZtcFrame.call(this, WriteSAS.OPCODE_GROUP, WriteSAS.OPCODE);
    this.shortAddress = shortAddress;
    this.extendedPanId = extendedPanId;
    this.apsUseExtendedPanId = apsUseExtendedPanId;
    this.panId = panId;
    this.channelsMask = channelsMask;
    this.protocolVersion = protocolVersion;
    this.stackProfile = stackProfile;
    this.startupControl = startupControl;
    this.trustCenterAddress = trustCenterAddress;
    this.trustCenterMasterKey = trustCenterMasterKey;
    this.networkKey = networkKey;
    this.useInsecureJoin = useInsecureJoin;
    this.preconfiguredTrustCenterLinkKey = preconfiguredTrustCenterLinkKey;
    this.activeNetworkKeySequenceNumber = activeNetworkKeySequenceNumber;
    this.networkKeyType = networkKeyType;
    this.networkManagerAddress = networkManagerAddress;
    this.scanAttempts = scanAttempts;
    this.timeBetweenScans = timeBetweenScans;
    this.rejoinInterval = rejoinInterval;
    this.maximumRejoinInterval = maximumRejoinInterval;
    this.indirectPollRate = indirectPollRate;
    this.parentLinkRetryThresold = parentLinkRetryThresold;
    this.isConcentrator = isConcentrator;
    this.concentratorRadius = concentratorRadius;
    this.concentratorDiscoveryTime = concentratorDiscoveryTime;
}

util.inherits(WriteSAS, ZtcFrame);

/**
 * Writes the WriteSAS request payload.
 *
 * @param {!ZtcBuilder} builder - the builder to write to
 * @returns {ZtcBuilder} the builder
 * @protected
 */
WriteSAS.prototype._writePayload = function (builder) {
    return builder
        .uint8(101)
        .shortAddress(this.shortAddress)
        .panId(this.extendedPanId)
        .panId(this.apsUseExtendedPanId)
        .uint16le(this.panId)
        .uint32le(this.channelsMask)
        .uint8(this.protocolVersion)
        .uint8(this.stackProfile)
        .uint8(this.startupControl)
        .ieeeAddress(this.trustCenterAddress)
        .key(this.trustCenterMasterKey)
        .key(this.networkKey)
        .uint8(this.useInsecureJoin)
        .key(this.preconfiguredTrustCenterLinkKey)
        .uint8(this.activeNetworkKeySequenceNumber)
        .uint8(this.networkKeyType)
        .shortAddress(this.networkManagerAddress)
        .uint8(this.scanAttempts)
        .uint16le(this.timeBetweenScans)
        .uint16le(this.rejoinInterval)
        .uint16le(this.maximumRejoinInterval)
        .uint16le(this.indirectPollRate)
        .uint8(this.isConcentrator)
        .uint8(this.concentratorRadius)
        .uint8(this.concentratorDiscoveryTime);
};

/**
 * Constant for opcode group.
 *
 * @type {number}
 */
WriteSAS.OPCODE_GROUP = 0x50;

/**
 * Constant for opcode.
 *
 * @type {number}
 */
WriteSAS.OPCODE = 0x01;

ZtcFrame.registerFrame(WriteSAS);

module.exports = WriteSAS;