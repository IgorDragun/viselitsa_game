# Создадим класс, в котором опишем все, что связано с состоянием игры:
# - загаданное слово;
# - отгаданные буквы;
# - буквы, которых в слове не оказалось;
# - количество ошибок;
# - статус игры.


class Game

	# Конструктор класса
	def initialize(slovo)
		@letters = get_letters(slovo)
		@errors = 0
		@good_letters = []
		@bad_letters = []
		@special_letters = convert_letters(@letters)
		@status = 0   #  "0" – игра активна, "-1" – игра закончена поражением, "1 – игра закончена победой
	end


	# Геттеры для переменных экземпляра класса
	def status
		return @status		
	end

	def errors
		return @errors		
	end

	def letters
		return @letters		
	end

	def good_letters
		return @good_letters		
	end

	def bad_letters
		return @bad_letters		
	end


	# Метод для получения загаданного слова и превращения его в массив
	def get_letters(slovo)

		if slovo == nil || slovo == ""
			abort "Чтобы сыграть в эту игру, введите слово в качестве аргумента при запуске программы!"
		end

		return slovo = slovo.split("")
	end


	# Метод для обработки массива с загаданным словом для учета букв "ё" и "й"
	def convert_letters(letters)
		special_letters = []

		letters.each do |item|
			special_letters << item
			if item == "е"
				special_letters << "ё"
			elsif item == "ё"
				special_letters << "е"
			elsif item == "и"
				special_letters << "й"
			elsif item == "й"
				special_letters << "и"
			end
		end

		special_letters = special_letters.uniq
		return special_letters
	end


	# Метод для запроса у игрока букв
	def ask_next_letter
		letter = ""

		while letter == "" do
			letter = STDIN.gets.chomp
		end

		# Добавим условие для того, чтобы учитывать буквы е/ё как одну, и буквы и/й как одну.
		if letter == "е" || letter == "ё"
			letter = "её"
		elsif letter == "и" || letter == "й"
			letter = "ий"
		end

		next_step(letter)
	end


	# Метод для проверки введенной буквы и определения следующего шага
	def next_step(letter)

		if @status == -1 || @status == 1
			return
		end

		letter.each_char do |letter|
			if (@good_letters.include?(letter)) || (@bad_letters.include?(letter))
				return
			end
		end

		if letter.size == 1

			if @letters.include?(letter)
				@good_letters << letter

				if @good_letters.uniq.size == @special_letters.size
					@status = 1
				end

			else
				@bad_letters << letter
				@errors += 1

				if @errors >= 7
					@status = -1
				end
			end

		elsif letter.size == 2

			if (@letters.include?(letter[0])) || (@letters.include?(letter[1]))
				@good_letters << letter[0]
				@good_letters << letter[1]

				if @good_letters.uniq.size == @special_letters.size
					@status = 1
				end

			else
				@bad_letters << letter[0]
				@bad_letters << letter[1]
				@errors += 1

				if @errors >= 7
					@status = -1
				end
			end
		end
	end
end