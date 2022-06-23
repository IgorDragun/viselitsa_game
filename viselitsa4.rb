require_relative "game.rb"
require_relative "result_printer.rb"
require_relative "word_reader.rb"

word_reader = WordReader.new

slovo = word_reader.read_from_file("words.txt")

game = Game.new(slovo)
printer = ResultPrinter.new

while game.status == 0
	printer.print_status(game)
	game.ask_next_letter
end

printer.print_status(game)