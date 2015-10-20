%%%-------------------------------------------------------------------
%%% @author Bas van Summeren
%%% @doc
%%%     Day 3 of erlang
%%% @end
%%% Created : 20. okt 2015 18:31
%%%-------------------------------------------------------------------
-module(day3).
-author("Bas van Summeren").

%% API
-export([execute/0, translate/1, createDoctor/0, translator/0, translator_doctor/0]).

execute()->io:fwrite("Day 3 of erlang!~n"),
          createDoctor(), doctor ! translator, timer:sleep(3),
          io:fwrite("Translating 'casa': ~s ~n", [translate("casa")]),
          io:fwrite("Translating 'blanca': ~s ~n", [translate("blanca")]),
          io:fwrite("Translating 'si': ~s ~n", [translate("si")]),timer:sleep(5),
          io:fwrite("Translating 'casa': ~s ~n", [translate("casa")]),
          io:fwrite("Translating 'blanca': ~s ~n", [translate("blanca")]),
          io:fwrite("Translating 'si': ~s ~n", [translate("si")]),timer:sleep(5),
          io:fwrite("Translating 'casa': ~s ~n", [translate("casa")]),
          io:fwrite("Translating 'blanca': ~s ~n", [translate("blanca")]),
          io:fwrite("Translating 'si': ~s ~n", [translate("si")]),timer:sleep(5),
          io:fwrite("Translating 'casa': ~s ~n", [translate("casa")]),
          io:fwrite("Translating 'blanca': ~s ~n", [translate("blanca")]),
          io:fwrite("Translating 'si': ~s ~n", [translate("si")]),

  timer:sleep(5000), io:fwrite("If run from Intellij it will now attempt to terminate every process, resulting in error messages!").


%%Translator from the book
translator() ->
  receive
    {From, "casa" } ->
      From ! "house" ,
      translator();
    {From, "blanca" } ->
      From ! "white" ,
      translator();
    {From, Word} ->
      From ! "I don't understand. Im Dying!" ,
      exit({Word, not_understood, received_at, erlang:time()})
  end.

translate(Translation) ->
  translator ! {self(), Translation},
  receive
    Result -> Result
  end.

createDoctor()-> register(doctor_doctor, spawn_link(fun doctor_doctor/0)), timer:sleep(2),
  doctor_doctor ! new, timer:sleep(2), doctor ! new, timer:sleep(10).

%Adapted from the revolver process
translator_doctor() ->
  process_flag(trap_exit, true),
  receive
    new ->
      io:format("Creating and monitoring translator.~n" ),
      register(translator, spawn_link(fun translator/0)),
      translator_doctor();
    {'EXIT', From, Reason} ->
      io:format("The translator ~p died with reason ~p." , [From, Reason]),
      io:format(" Restarting. ~n" ),
      self() ! new,
      translator_doctor()
  end.


doctor_doctor() ->
  process_flag(trap_exit, true),
  receive
    new ->
      io:format("Creating and monitoring doctor.~n" ),
      register(doctor, spawn_link(fun translator_doctor/0)),
      doctor_doctor();
    {'EXIT', From, Reason} ->
      io:format("The doctor ~p died with reason ~p." , [From, Reason]),
      io:format(" Restarting. ~n" ),
      self() ! new,
      doctor_doctor()
  end.
