# Assignment Ruby day 1
# Bas van Summeren<BasVanSummeren@hotmail.com>

#Default Output
puts "Hello, World"

#Get the location of the Ruby Word
HelloRuby = "Hello, Ruby!"
puts HelloRuby
#Get the index
index = HelloRuby.index("Ruby")
puts "Ruby is at: "+ HelloRuby.to_s
#String replacement. Take the index and the next 3 characters and replace them with: Rody
# Idea from http://www.techotopia.com/index.php/Ruby_String_Replacement,_Substitution_and_Insertion
HelloRuby[index .. (index+3)]= "Rody"
puts HelloRuby


#Basic loop
i = 0
while i<10
  puts "Bas"
  i+=1
end

#Use the basic conversion to convert the position in the loop to a string
i = 1
while i<=10
  puts "This sentence is number " + i.to_s
  i+=1
end

#This is the highest number that will be guessed
highestNumber = 10
#Make guessed negative so we will never have a correct answer at the start
guessed = -1
#Use the rand function that was described in the book to get a random number between 0 and highestNumber +1
number = rand(highestNumber+1)
puts "Guess the number from 0 to " +highestNumber.to_s+ ":"
#Loop while not complete
while (guessed!=number)
  puts "Type your guess (0 to "+highestNumber.to_s+") and press Enter"
  #Get input from keyboard and convert it to a number: http://stackoverflow.com/questions/6556280/read-input-from-console-in-ruby
  guessed = gets.chomp().to_i
  #Print the guessed number. NOTE: If something else then a number is guessed, it will be 0
  puts "You guessed: " + guessed.to_s
  #Inline conditions for putting information out
  puts "You guessed too high" if (guessed >number)
  puts "You guessed too low" if (guessed< number)
end
puts "Congratulations"
