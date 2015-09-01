# Assignment Ruby day 3
# Bas van Summeren<BasVanSummeren@hotmail.com>

class CsvRow
  attr_accessor :values

  def initialize(headers, values)
    i=0;
    @values ={}
    headers.each{|head|
      @values[head]=values[i]
      i+=1
    }
  end

  def method_missing(name, *args)
    temp = @values[name.to_s]
    puts @values[name]
    if(temp.nil?)
      super.method_missing name, args
    else
      return temp
    end
  end

end

module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end
  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end
  module InstanceMethods
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ' )
      file.each do |row|
        @csv_contents.push(CsvRow.new(@headers, row.chomp.split(', ' )))
      end
    end
    attr_accessor :headers, :csv_contents
    def initialize
      read
    end
  end
end
class Persoon # no inheritance! You can mix it in
  include ActsAsCsv
  acts_as_csv

  def each(&block)
    @csv_contents.each(&block)
  end

end
m = Persoon.new

m.each{|row|
  puts "Persoon"
  puts "Naam: "+ row.naam
  puts "Woonplaats: "+ row.woonplaats
  puts "Leeftijd : "+row.leeftijd
  puts "Geslacht : "+row.geslacht
  puts "---------------------------"
}
