%
% Copyright (c) 2016 Petr Gotthard <petr.gotthard@centrum.cz>
% All rights reserved.
% Distributed under the terms of the MIT License. See the LICENSE file.
%
% The 'Sensors GPS Demo' application from the Semtech LoRa Demo Kit
% https://github.com/Lora-net/LoRaMac-node
%
-module(lorawan_application_semtech_mote).
-behaviour(lorawan_application).

-export([init/1, handle_join/3, handle_rx/5]).

init(_App) ->
    ok.

handle_join(_DevAddr, _App, _AppID) ->
    % accept any device
    ok.

% the data structure is explained in
% https://github.com/Lora-net/LoRaMac-node/blob/master/src/apps/LoRaMac/classA/LoRaMote/main.c#L207
handle_rx(DevAddr, _App, _AppID, 2, <<LED, Press:16, Temp:16, _AltBar:16, Batt, _Lat:24, _Lon:24, _AltGps:16>>) ->
    lager:debug("PUSH_DATA ~w ~w ~w ~w",[DevAddr, Press, Temp, Batt]),
    % blink with the LED indicator
    {send, 2, <<((LED+1) rem 2)>>};

handle_rx(_DevAddr, _App, _AppID, Port, Data) ->
    {error, {unexpected_data, Port, Data}}.

% end of file
