"Answers for Io Day2 \n By Bas van Summeren<BasVanSummeren@hotmail.com>"println
"Main guide: http://iolanguage.org/scm/io/docs/IoGuide.html"println

Fibonacci := Object clone
Fibonacci clone = Fibonacci
Fibonacci fib := method(number,
if(number <=1, return 1)
NotLast :=0
Last :=1
i := 1
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
#Copy the orignal function with the getSlot()
Number devide := Number getSlot("/")
#Return 0 if the parameter is 0, else use the old one
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

"" println
"Matrix" println
Matrix := Object clone
Matrix dim := method(x, y,
	"Creating list of " print
	x print
	" x " print
	y println
	instance := Matrix clone
	instance list := list();
	yList :=list();
	for(i, 0, y-1, yList append(0))
    for(i, 0, x - 1, instance list append( yList clone))
	instance
)
Matrix get := method(x, y, list at(x) at(y))
Matrix set := method(x, y, value, list at(x) atPut(y, value))
Matrix transpose := method(
	new_instance := Matrix dim(self list at(0) size, self list size);
	list foreach(x, alist,
		alist foreach(y, value, 
			y print
			"." print
			x print
			" = " print
			value println
			new_instance set(y, x, value))
		)
	new_instance
	)
Matrix print := method(
	self list foreach(sublist,
		sublist foreach(value,
			value print
			"    "print
		)
	"\n" print
	)
)

"Create new matrix" println
instance := Matrix dim(4, 2)
instance print
instance list size print 
" x " print
instance list at(0) size  println

"Putting X at 3.1" println
instance set (3, 1, "X")
"Putting K at 1.0" println
instance set (1, 0, "K")
"Putting 7 at 0.1" println
instance set (0, 1, 7)
"Putting O at 0.0"
instance set (0, 0, "O")

instance print

"Value at 3.1 is: " print
instance get(3,1) println
""println

"Transposing Matrix" println
instance transpose print
"" println

"Matrix and files: "println
""
"Storing the current matrix to: store.txt"println
f := File with("store.txt")
f remove
f create
f openForUpdating
"Use serialized in Object slots"
f write(instance serialized)
f close

"Written the object to store.txt" println

"Reading the object from: matrix.txt" println
instance = doFile("matrix.txt")
"Result: " println
instance print

""println

"Number Guessing" println
"Found random function at: http://stackoverflow.com/questions/7735448/random-value-bug-in-io"

NumberGuesser := Object clone
NumberGuesser value := Random value(100) floor
"Guess a number between 0 and 100" println
NumberGuesser prevDiff := 10000000000000
NumberGuesser finished := false
NumberGuesser guesses :=0
NumberGuesser guess := method(guessed,
	guesses = guesses + 1
	if(guessed asNumber == value, "Correct" println;  finished=true; return true,
		temp := value  - guessed asNumber;
		if(temp<0, temp = temp * -1)
		if(guesses > 1, if(temp<prevDiff, "Hotter"println, "Colder" println))
		prevDiff = temp
	)
)
while(NumberGuesser finished ==false,
NumberGuesser guess (File standardInput readLine))
