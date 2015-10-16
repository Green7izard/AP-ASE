%%%-------------------------------------------------------------------
%%% @author Bas van Summeren
%%% @doc
%%% Day1 of Erlang
%%% @end
%%% Created : 16. okt 2015 13:16
%%%-------------------------------------------------------------------
-module(day1).
-author("Bas van Summeren").

%% API
-export([executeDay1/0, countWords/1, recursionCounter/0, printStatus/1]).

executeDay1()->io:fwrite("Counting the words of: 'Het is dag 1 van Erlang! Lang leve deze Taal!' : ~B ~n",[countWords("Het is dag 1 van Erlang! Lang leve deze Taal!")]),
              io:fwrite("~nStarting Count:~n"), recursionCounter(), io:fwrite("~n"),
              io:fwrite("~nPrinting a Succes state:~n"),printStatus("success"),
              io:fwrite("Printing a error with message: 'Illegal Argument':~n"), printStatus({error, "Illegal Argument"}).

%%Count the words
%%Empty lists dont get anything
countWords([])->0;
%%Otherwise call on the double parameter kind
countWords(Text)->countWords(Text, 1).

%%Again: nothing is nothing
countWords([], Count)->Count;
%% \n
countWords([10|T], Count)->countWords(T, Count+1);
%% Space
countWords([32|T], Count)->countWords(T, Count+1);
%% \t
countWords([9|T], Count)->countWords(T, Count+1);
%% \e
countWords([27|T], Count)->countWords(T, Count+1);
%% No word seperator
countWords([_|T], Count)->countWords(T, Count).

%% Count recusivly, use pattern matching to stop at 10
recursionCounter()->recursionCounter(1).
recursionCounter(10)->io:fwrite("Finished counting to 10!~n");
recursionCounter(Number)->io:fwrite("Counting: ~B ~n", [Number]),recursionCounter(Number+1).

printStatus(success)->io:fwrite("Successfully Executed!~n");
printStatus("success")->printStatus(success);
printStatus({error, Message})->io:fwrite("A Error has occured: ~s ~n", [Message]);
printStatus({"error", Message})->printStatus({error, Message}).
