require 'csv'
##require './lib/lib/chinese_detector'
##require './lib/lib/script_detector'
puts "CSV Reader"

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


options = Options.new(ARGV[0], ARGV[1])
puts "#{options.input} >> #{options.output}"

file = File.open(options.input,"r:ISO-8859-1")
CSV.foreach(file) do |row|
    puts "#{row}"
end

