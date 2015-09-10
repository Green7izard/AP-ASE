// Create tail function like in Scala, Prolog, Haskell
List tail := method(
	if(head!=nil,
	temp := clone
	temp removeAt(0)
	return(temp), return(nil));
	)
// Create head function like in Scala, Prolog, Haskell
List head := method(at(0))

// Simple size method 
List mySize := method(
	if(head==nil,
		return 0,
		curTail := tail;
		if(curTail==nil,
			return 1,
			return 1 + (curTail mySize)
		)
	)
)

List mySum := method()

// Recursive minimum function
List myMin := method()

// Remove element using head and tail
List removeElement := method(number,
	
)

// Create average function using sum and size
List avg := method ()

// Create reverseMe using head and tail
List reverseMe := method(
tempList := List clone
curHead := head
if(curHead != nil,
	tempList := tail reverseMe
	tempList append(curHead))
tempList
)

// Sum using builtIn uniqueCount
List incredibleSum := method( result := 0
    uniqueCount foreach(value,
        result = result + (value at(0) * (value at(1))
    )
    return result)

/**
 * Testcase for List Functions
 */
listTestCase := UnitTest do(
	setUp := method(
		self oneToTen := list(1,2,3,4,5,6,7,8,9,10)
	)

	test_HeadOfEmptyListShouldBeNil := method(
		assertEquals(nil, list() head)
	)

	test_HeadOfOneListShouldBeOne := method(
		assertEquals(1, list(1) head)
	)

	test_TailOfEmptyListShouldBeNil := method(
		assertEquals(nil, list() tail)
	)

	test_ReverseOfOneToTenIsTenToOne := method(
		assertEquals(list(10,9,8,7,6,5,4,3,2,1), oneToTen reverseMe)
	)
	
	test_ReverseOfEmptyListShouldByEmpty := method(
		assertEquals(list(), list() reverseMe)
	)

	test_mySizeOfEmptyListShouldBeZero := method(
		assertEquals(0, list() mySize)
	)

	test_mySizeOfSingleItemShouldBeOne := method(
		assertEquals(1, list(1) mySize)
	)
)

FileCollector run
DirectoryCollector run