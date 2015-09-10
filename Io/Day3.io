"Answers for Io Day3 \n By Bas van Summeren<BasVanSummeren@hotmail.com>"println
"Adapted xml maker: "

Builder := Object clone
Builder forward := method(
	#Interpolate executes the code in the #{} and adds the return value
	returnValue := "<#{call message name}" interpolate
	call message arguments foreach(
	arg,
		temp := doMessage(arg)
		arg type println
		#isKindOf is a base function of Object for checking type
		if(temp isKindOf(Map),
			temp foreach(key, value, returnValue = returnValue .. "   ".. key .. " = " .. value))
	)
	
	returnValue = returnValue .. ">\n"
	call message arguments foreach(
	arg,
	content := self doMessage(arg)
	if(content isKindOf(Sequence),
	content split("\n") foreach(value, returnValue  = returnValue .."    " .. value .. "\n"))
	returnValue .. "</#{call message name}>" interpolate
	)
)
Builder ul(
li("Io" ),
li("Lua" ),
li(JavaScript("JQuerry"))) println

"\nEasy lists"println
#Same trick as the curlyBrackets, these are just square
squareBrackets := method(call message arguments)
List squareBrackets := method(
	newList := List clone
	call message arguments foreach(value,
		newValue=doMessage(value)
		newList append newValue;
		)
	newList
)

testlist := ["1", "2", "3" ,"4", "5"]
testlist println


"\nUse hash notation" println
#The books hash notation
OperatorTable addAssignOperator(":" , "atPutNumber" )
curlyBrackets := method(call message arguments)
Map curlyBrackets := method(
r := Map clone
call message arguments foreach(arg,
r doMessage(arg)
)
r
)
Map atPutNumber := method(
self atPut(
call evalArgAt(0) asMutable removePrefix("\"") removeSuffix(" \"" ),
call evalArgAt(1))
)
#Somehow if i use it as not a string i will get a list with index 0 = "Testhash" : "Test")
Builder useHash("{\"Testhash\" : \"Test\"}") println
