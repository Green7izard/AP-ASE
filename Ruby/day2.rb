# Assignment Ruby day 2
# Bas van Summeren<BasVanSummeren@hotmail.com>

#Amount of rows to be printed
numberRows = 4;
#Amount of numbers per row
numbersPerRow = 4;
#Create a empty array
number = []
#Use the times loop to automatically fill the array
(numberRows*numbersPerRow).times() { number.push(rand(100)) }

step = 0;
#For each value
number.each { |current|
  #Go a step up
  step+=1
  #Print to the same line if not at the end
  print current.to_s + ", " if step<numbersPerRow
  #if at the end, make a new line and reset the step
  if step>=numbersPerRow
    puts current
    step = 0
  end
}

puts "\n\n"

class Tree
  attr_accessor :children, :node_name

  def initialize(name, children={})
    @node_name = name
    #Make sure it exists
    @children={}
    #loop Through the received parts
    children.each { |relationName, child|
      #If the child is already a tree keep it this way
      if (child.is_a?(Tree))
        @children[relationName.to_s] = child
        #if its a hash, use the hash to create a new tree
      elsif (child.is_a?({}.class))
        @children[relationName.to_s] = Tree.new(relationName, child)
      end
    }


  end

  def visit_all(&block)
    visit &block
    @children.each { |relationName, c| c.visit_all &block if c.is_a?(Tree) }
  end

  def visit(&block)
    block.call self
  end
end

Child = Tree.new("Kid");
Father = Tree.new("Dad", {"Child" => Child});
GrandFather = Tree.new("Grandpa", {"Son" => Father})


puts "Visiting a node of Father"
Father.visit { |node| puts node.node_name }
puts
puts "visiting entire tree of GrandFather"
GrandFather.visit_all { |node| puts node.node_name }

puts
puts "Creating nodes with: {`grandpa` => {` dad` => {`child 1` => {}, `child 2` => {} }, `uncle` => {`child 3` => {}, `child 4` => {} } } }"
Tree2 = Tree.new("Great Grandpa", {"grandpa" => {"dad" => {"child 1" => {}, "child 2" => {}}, "uncle" => {"child 3" => {}, "child 4" => {}}}})
puts Tree2.visit_all { |node| puts node.node_name }
puts
puts


#Module that includes the fucntion for finding the text in files
module FileGrep
  def grep_file (file, searchFor)
    i=1;
    lines=[]
#Loop through the line with the each function: http://stackoverflow.com/questions/6012930/read-lines-of-a-file-in-ruby
    file.each_line { |text|
      #Search the line for the index of the search pattern. If its
      if !text.match(searchFor).nil?
        print "Line "+ i.to_s + " : "
        puts text
        lines.push(i)
      end
      i+=1;
    }
    return lines
  end
end

#The FileReader class
class FileReader
  include FileGrep
  attr_accessor :fileName

  def initialize(fileName)
    puts "FileReader Creation"
    @fileName = fileName.to_s
  end

  def search_for_string(searchFor)
    #Open the file
    puts "Searching for "+searchFor.to_s
    openFile=File.open(@fileName, 'r')
    grep_file(openFile, searchFor)
    openFile.close
  end

end

#Create the reader with the desired filename
reader = FileReader.new("Day2.txt")

#Put in a value, can be string or rexex
searchFor = /Controller/

reader.search_for_string(searchFor)
