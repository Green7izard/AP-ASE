"Answers for Io Day1 \n By Bas van Summeren<BasVanSummeren@hotmail.com>"println

Fibonacci := Object clone
Fibonacci clone = Fibonacci
Fibonacci fib := method(number,
if(number <=2, return 1)
NotLast :=1
Last :=1
i := 2
while(i<number, i=i+1; temp := Last + NotLast; NotLast=Last; Last=temp;)
return Last
)
"Fibonacci: " println
Fibonacci fib(1) println
Fibonacci fib(2) println
Fibonacci fib(3) println
Fibonacci fib(4) println
Fibonacci fib(5) println
Fibonacci fib(6) println
Fibonacci fib(7) println
Fibonacci fib(8) println
Fibonacci fib(9) println
Fibonacci fib(10) println
Fibonacci fib(11) println
Fibonacci fib(12) println
Fibonacci fib(13) println
Fibonacci fib(14) println
Fibonacci fib(15) println
"" println

"Overwritten / Function" println
Number devide := Number getSlot("/")

Number / = method(number,
	if(number==0, 0,  self devide(number))
)
"3/0: " print
(3/0) println
"3/5: " print
(3/5)  println 

"" println

"Average List" println
AverageList := List clone
AverageList get_average := method(
	total :=0;
	foreach(
		number,	
		
		if(number proto == Number,
		total = total + number; ,
		Exception raise("It isnt a number!");)) 
	total / (self size) )
AverageList get_total :=method(
	total := 0
	foreach(number,
	if (number proto == Number, total = total + number,  total = total + number get_total))
	total
)
theList := AverageList clone
theList append(1)
theList append(2)
theList append(3)
theList append(4)
theList append(5)

"Average of list containing (1, 2, 3, 4, 5) : " print
theList get_average println
"Adding \"Banaan\"" println
theList append("Banaan")
e := try(theList get_average)
if(e==nil, "No exception Caught"println, "Exception caught: " print; e catch(Exception, e error println))
"" println
"Removing Banaan" println
theList remove("Banaan")
"Total of the list: " print
theList get_total println

"Cloning the list, adding 6 to the new list, and adding it to the existing list" println
newList := theList clone
newList append(6)
theList append(newList)
"Total of the lists: " print
theList get_total println

"TODO 5, 6, 7 ,8 "

