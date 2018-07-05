-module(my_cache).
-export([create/0,insert/3,lookup/1,delete_obsolete/0]).
-author("Kalyta Bogdan").

create() ->
	ets:new(cache,[public,named_table]),
	ok.

insert(Key,Value,LiveTime) when is_integer(LiveTime) ->
	ets:insert(cache,[{Key,Value,os:system_time(seconds) + LiveTime}]),
	ok;
insert(_,_,_) ->
	{error, undefined}.

lookup(Key) ->
	case ets:match(cache,{Key,'_','$1'}) of
		[_] ->
			[{Key,Value,LiveTime}]=ets:lookup(cache,Key),
			CurrentLiveTime = os:system_time(seconds),
			case LiveTime < CurrentLiveTime of
				false ->
					{ok,Value};
				true ->
					ets:delete(cache,Key),
					io:format("Item is expired for ~p seconds~n",[CurrentLiveTime-LiveTime])
			end;
		[] ->
			{error, undefined}
	end.

delete_obsolete() ->
	ets:delete(cache).
