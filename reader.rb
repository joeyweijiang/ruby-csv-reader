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

options = Options.new(ARGV[0], ARGV[1])             # Get input and output
outAry = Array.new                                  # Array for output
puts "Reading words from #{options.input} >> #{options.output}"    

file = File.open(options.input,"r:ISO-8859-1")      # Read file in default format in case
CSV.foreach(file) do |row|                          # Check each name column words
    next if row.size < 2 || row[1] == nil 
    if row[1].chinese?
        if row[1].traditional_chinese?
            puts row[1]
            outAry.push(row[1])
        end
    end
end

File.open(options.output,'w') do |f| 
    f << outAry.map{|words| words}.join("\n")       # Dump to output file
end 

