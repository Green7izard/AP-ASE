# Assignment Ruby day 3
# Bas van Summeren<BasVanSummeren@hotmail.com>

class CsvRow
  attr_accessor :values

  #Laat de constructor door de opgegeven headers en waarden loopen om deze te verwerken
  def initialize(headers, values)
    i=0;
    @values ={}
    headers.each{|head|
      @values[head]=values[i]
      i+=1
    }
  end

  #Wanneer de aangegeven naam bestaat in de variabelen retourneert deze variable
  #Wanneer de variabele niet bestaat zal de superclasse het afhandelen
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
        #In plaats van de informatie rechtstreeks in de array te pushen zal de data aan de constuctor van CsvRow worden gegeven
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

  #Delegeer deze functie door naar de array met resultaten
  def each(&block)
    @csv_contents.each(&block)
  end

end
m = Persoon.new

#Print de gegevens met de functies
m.each{|row|
  puts "Persoon"
  puts "Naam: "+ row.naam
  puts "Woonplaats: "+ row.woonplaats
  puts "Leeftijd : "+row.leeftijd
  puts "Geslacht : "+row.geslacht
  puts "---------------------------"
}
