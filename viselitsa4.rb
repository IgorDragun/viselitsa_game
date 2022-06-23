require_relative "lib/game.rb"
require_relative "lib/result_printer.rb"
require_relative "lib/word_reader.rb"

word_reader = WordReader.new

file_path = File.dirname(__FILE__) + "/data/words.txt"

slovo = word_reader.read_from_file(file_path)

game = Game.new(slovo)
printer = ResultPrinter.new

while game.status == 0
	printer.print_status(game)
	game.ask_next_letter
end

printer.print_status(game)