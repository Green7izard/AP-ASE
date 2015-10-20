%%%-------------------------------------------------------------------
%%% @author Bas van Summeren
%%% @doc
%%% Day 2 of Erlang
%%% @end
%%% Created : 16. okt 2015 23:40
%%%-------------------------------------------------------------------
-module(day2).
-author("Bas van Summeren").

%% API
-export([execute/0, getValue/2, exampleList/0, getTotalPrice/1, determineWinner/1]).

execute()->io:fwrite("Day 2 of erlang~n"),
io:fwrite("Searching for key: erlang in the list: ~w ~n", [exampleList()]),
io:fwrite("Value is: ~s ~n~n",[getValue(exampleList(), erlang)]),
io:fwrite("Getting the prices for: ~w ~n", [exampleItems()]),
io:fwrite("Totals: ~w ~n~n", [getTotalPrice(exampleItems())]),
io:fwrite("Checking board: ~w ~n", [xWins()]),
io:fwrite("Winner: ~w ~n", [determineWinner(xWins())]),
  io:fwrite("Checking board: ~w ~n", [oWins()]),
  io:fwrite("Winner: ~w ~n", [determineWinner(oWins())]),
  io:fwrite("Checking board: ~w ~n", [nobodyWins()]),
  io:fwrite("Winner: ~w ~n", [determineWinner(nobodyWins())]).

getValue([], _)->none;
getValue([{Key, Value}|_], Key)->Value;
getValue([{_, _}|Tail], Key)->getValue(Tail, Key).

exampleList() -> [{erlang, "a functional language"}, {ruby, "an OO language"}].

getTotalPrice([])->[];
getTotalPrice(Items)->[{Item, Quantity*Price}||{Item, Quantity, Price}<-Items].

exampleItems() -> [{hammer, 1, 5.7}, {nail, 300, 0.1}, {plank, 30, 0.75}].

%http://learnyousomeerlang.com/syntax-in-functions
determineWinner({W,W,W,_,_,_,_,_,_}) when W /= empty ->W;
determineWinner({_,_,_,W,W,W,_,_,_}) when W /= empty->W;
determineWinner({_,_,_,_,_,_,W,W,W}) when W /= empty->W;
determineWinner({W,_,_,W,_,_,W,_,_}) when W /= empty->W;
determineWinner({_,W,_,_,W,_,_,W,_}) when W /= empty->W;
determineWinner({_,_,W,_,_,W,_,_,W}) when W /= empty->W;
determineWinner({W,_,_,_,W,_,_,_,W}) when W /= empty->W;
determineWinner({_,_,W,_,W,_,W,_,_}) when W /= empty->W;

determineWinner({empty,_,_,_,_,_,_,_,_})->no_winner;
determineWinner({_,empty,_,_,_,_,_,_,_})->no_winner;
determineWinner({_,_,empty,_,_,_,_,_,_})->no_winner;
determineWinner({_,_,_,empty,_,_,_,_,_})->no_winner;
determineWinner({_,_,_,_,empty,_,_,_,_})->no_winner;
determineWinner({_,_,_,_,_,empty,_,_,_})->no_winner;
determineWinner({_,_,_,_,_,_,empty,_,_})->no_winner;
determineWinner({_,_,_,_,_,_,_,empty,_})->no_winner;
determineWinner({_,_,_,_,_,_,_,_,empty})->no_winner;

determineWinner({_,_,_,_,_,_,_,_,_})->cat.

xWins()->{x,o,o,
          o,x,o,
          empty,o,x }.

oWins()->{x,o,o,
          o,x,o,
          empty,o,o }.

nobodyWins()->{x,o,x,
               o,x,o,
               o,x,o }.
