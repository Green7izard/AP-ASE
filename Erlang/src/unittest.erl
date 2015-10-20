%%%-------------------------------------------------------------------
%%% @author Bas van Summeren
%%% @doc
%%%
%%% @end
%%% Created : 20. okt 2015 17:41
%%%-------------------------------------------------------------------
-module(unittest).
-author("Bas van Summeren").

-include_lib("eunit/include/eunit.hrl").

%http://www.erlang.org/doc/apps/eunit/chapter.html
count_nothing_test() ->?assert(day1:countWords("") =:= 0).
count_two_test() -> ?assert(day1:countWords("Hello World!")=:=2).
