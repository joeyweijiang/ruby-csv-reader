require 'csv'
require File.dirname(__FILE__) + '/lib/lib/script_detector.rb'
puts "CSV Reader Script Start:"

class Options
    def initialize(input, output)
        @input 	= input
        @output	= output
    end
    def input
        @input
    end
    def output
        @output
    end
end

if ARGV.size < 2
    puts "Error: Script needs 2 parameters as input file and output file.\n try: ruby reader.rb input.csv output.txt\n"
    abort
end
rowId = 1
options = Options.new(ARGV[0], ARGV[1])             # Get input and output
hashlist = Hash.new()                               # hash list
outAry = Array.new                                  # Array for output
puts "Reading words from #{options.input} >> #{options.output}"    

file = File.open(options.input,"r:ISO-8859-1")      # Read file in default format in case
CSV.foreach(file, headers: true, encoding: 'iso-8859-1:utf-8') do |row|                          # Check each name column words
    puts "Read line #{rowId}"

    amount = row[14].nil?? "":row[14]
    if (amount == "")
        rowId += 1
        next
    end

    key = row[4]+row[5]+row[6]+row[7]+row[8] + row[9] + row[10] +row[11] + row[12] + amount
    value = "$ " +amount.to_s + " @Line" +rowId.to_s

    if (hashlist.has_key?(key))    
        puts "#{key} => #{value} "
        outAry.push("#{key} => #{value} ")
    else 
        hashlist[key] = value
    end
    
    rowId += 1
end

File.open(options.output,'w') do |f| 
    f << outAry.map{|words| words}.join("\n")       # Dump to output file
end 


