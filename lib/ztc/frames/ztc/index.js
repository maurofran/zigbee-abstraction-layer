/*
 * index.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

module.exports = {
    Const: require("./consts"),

    ReadSAS: {
        Request: require("./readsas"),
        Confirm: require("./readsasconfirm")
    },
    WriteSAS: {
        Request: require("./writesas"),
        Confirm: require("./writesasconfirm")
    },

    SaveConfirm: require("./saveconfirm"),
    CPUReset: require("./cpureset"),
    DebugEvent: require("./debugevent"),
    ErrorEvent: require("./errorevent"),
    Event: require("./event"),

    GetChannel: {
        Request: require("./getchannelrequest"),
        Confirm: require("./getchannelconfirm")
    },
    GetMode: {
        Request: require("./getmoderequest"),
        Confirm: require("./getmodeconfirm")
    },
    GetNumOfMsgs: {
        Request: require("./getnumofmsgsrequest"),
        Confirm: require("./getnumofmsgsconfirm")
    },
    GetPanID: {
        Request: require("./getpanidrequest"),
        Confirm: require("./getpanidconfirm")
    },
    ModeSelect: {
        Request: require("./modeselectrequest"),
        Confirm: require("./modeselectconfirm")
    },
    NVGetDataSetDesc: {
        Request: require("./nvgetdatasetdescrequest"),
        Confirm: require("./nvgetdatasetdescconfirm")
    },
    NVGetPageHeaders: {
        Request: require("./nvgetpageheadersrequest"),
        Confirm: require("./nvgetpageheadersconfirm")
    },
    Ping: {
        Request: require("./pingrequest"),
        Confirm: require("./pingconfirm")
    },
    ReadExtAddr: {
        Request: require("./readextaddrrequest"),
        Confirm: require("./readextaddrconfirm")
    },
    ReadMemoryBlock: {
        Request: require("./readmemoryblockrequest"),
        Confirm: require("./readmemoryblockconfirm")
    },
    RadioRegisterRead: {
        Request: require("./radioregisterreadrequest"),
        Confirm: require("./radioregisterreadconfirm")
    },
    RadioRegisterWrite: {
        Request: require("./radioregisterwriterequest"),
        Confirm: require("./radioregisterwriteconfirm")
    },
    SetChannel: {
        Request: require("./setchannelrequest"),
        Confirm: require("./setchannelconfirm")
    },
    SetPanID: {
        Request: require("./setpanidrequest"),
        Confirm: require("./setpanidconfirm")
    },
    WriteExtAddr: {
        Request: require("./writeextaddrrequest"),
        Confirm: require("./writeextaddrconfirm")
    },
    WriteMemoryBlock: {
        Request: require("./writememoryblockrequest"),
        Confirm: require("./writememoryblockconfirm")
    },
    AddToAddressMap: {
        Request: require("./addtoaddressmaprequest"),
        Confirm: require("./addtoaddressmapconfirm")
    },
    GetSeed: {
        Request: require("./getseedrequest"),
        Confirm: require("./getseedconfirm")
    },
    RemoveFromAddressMap: {
        Request: require("./removefromaddressmaprequest"),
        Confirm: require("./removefromaddressmapconfirm")
    }
};