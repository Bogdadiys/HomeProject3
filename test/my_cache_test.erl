-module(my_cache_test).
%-compile(export_all).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-author("Bogdan Kalyta").
create_test()->[
?_assertEqual(my_cache:create(),ok)].
insert_test()->[
?_assertEqual(  begin
			my_cache:create(),
			my_cache:insert(key,value,100)
		end,
		ok),
?_assertEqual(  begin
			my_cache:create(),
			my_cache:insert(key,value,qwerty)
		end,
		{error, undefined})].
lookup_test()->[
?_assertEqual(  begin
			my_cache:create(),
			my_cache:insert(key,value,100),
			my_cache:lookup(key)
		end,
		{ok,value}),
?_assertEqual(  begin
			my_cache:create(),
			my_cache:insert(key,value,-100),
			my_cache:lookup(key)
		end,
		{error, undefined})].
delete_absolete_test()->[
?_assertEqual(  begin
			my_cache:create(),
			my_cache:delete_absolete()
		end,
		ok)].
-endif.
