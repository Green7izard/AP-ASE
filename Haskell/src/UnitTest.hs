module UnitTest where

-- http://hunit.sourceforge.net/HUnit-1.0/Guide.html

import Test.HUnit
import Day2


doTest = runTestTT tests
tests = TestList [testDenominator5x8, testDenominator20x210, testDenominator5645654x4354333, testDenominator1000000x10]


testDenominator5x8 = TestCase (assertEqual "for (greatestDenominator 5 8)," (1) (greatestDenominator 5 8 ))
testDenominator20x210 = TestCase (assertEqual "for (greatestDenominator 20 210)," (10) (greatestDenominator 20 210 ))
testDenominator5645654x4354333 = TestCase (assertEqual "for (greatestDenominator 5645654 4354333)," (1) (greatestDenominator 5645654 4354333 ))
testDenominator1000000x10 = TestCase (assertEqual "for (greatestDenominator 1000000 10)," (10) (greatestDenominator 1000000 10 ))
