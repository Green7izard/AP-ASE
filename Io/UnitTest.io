doFile("Day3.io")
"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" println
"Unit test for Io Day3 \nBy Bas van Summeren<BasVanSummeren@hotmail.com>"println
"Source: http://www.javajigi.net/display/WEB20/Io+Language+UnitTest" println

UnitTest proto slotNames println

ListTest := UnitTest clone do (
  testCreate := method(
	
    list := [1, 2, 3, 4, 5]
    assertNotEquals(list, nil)
	assertEquals(list isKindOf(List), true);
  )
  
  testSize := method(
    list := [1, 2, 3, 4, 5]
	assertEquals(list size, 5);
  )
  
  testNumbers := method(
    list := [0, 1, 2, 3, 4]
	for(i,0, 4, assertEquals(doMessage(list at(i)) , i))
  )
)

ListTest run