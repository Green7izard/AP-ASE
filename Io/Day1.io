"Answers for Io Day1 \n By Bas van Summeren<BasVanSummeren@hotmail.com>"println


if(1+1==2) then("1+1=2" println
) else ("1+1 != 2" println)

"\n"println

if(1=="one") then( "1=One, Not strong typed" println
)else("1 != one, Strong typed" println) 

"\n"println

if(0)  then("0 Is true" println
}else ("0 is not true" println)

if("") then("Empty string is true" println
} else ("Empty String is false" println)

if("A") then("Filled string is true" println
} else ("Filled String is false" println)

"\n"println

"Creating a random Object" println

"TestObject := Object clone
TestObject testvalue := \"Test\"
TestObject testvalue2 := \"Test2\"" println

TestObject := Object clone
TestObject testvalue := "Test"
TestObject testvalue2 := "Test"
TestObject println
TestObject slotNames println
"You can see The slots and values by printing the object.\nYou can also receive all available slots with the slotNames function" println

"\n"println


" = Is used for overwriting a existing slot value \n It will fail when the slot does not exist\n" println
" := Creates a slot if it does not exist and puts in the desired value\n" println
" ::= Creates a slot if it does not exist and puts in the desired value \nit also creates a setter"println
"Source: http://iolanguage.org/scm/io/docs/IoGuide.html#Syntax-Assignment \n" println

"To test we create a new value in the TestObject" println
"TestObject setterTest ::= \"Test3\"" println
TestObject setterTest ::= "Test3"
TestObject setterTest println
TestObject setSetterTest("Nieuwe waarde")
"TestObject setSetterTest(\"Nieuwe waarde\")" println
TestObject setterTest println

"\n"println

TestObject clone = method("The end of day one" println)

"TestObject clone:" println
TestObject clone
