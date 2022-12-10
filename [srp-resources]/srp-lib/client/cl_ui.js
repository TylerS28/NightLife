const registered = [];

function RegisterUICallback(name, cb) {
    AddEventHandler(`_aui_uiReq:${name}`, cb);

    if (GetResourceState('srp-ui') === 'started') exports['srp-ui'].RegisterUIEvent(name);

    registered.push(name);
}

function SendUIMessage(data) {
    exports['srp-ui'].SendUIMessage(data);
}

function SetUIFocus(hasFocus, hasCursor) {
    exports['srp-ui'].SetUIFocus(hasFocus, hasCursor);
}

function GetUIFocus() {
    return exports['srp-ui'].GetUIFocus();
}

AddEventHandler('_aui_uiReady', () => {
    registered.forEach((eventName) => exports['srp-ui'].RegisterUIEvent(eventName));
});