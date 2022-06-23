# Создадим класс для вывода информации об игре на экран

class ResultPrinter

	# Опишем конструктов
	def initialize
		@status_image = []
		current_path = File.dirname(__FILE__)
		counter = 0

		while counter <= 7 do
			file_name = current_path + "/../image/#{counter}.txt"

			# Обработка отсутствия файла через исключение
			begin Errno::ENOENT
				file = File.new(file_name)
				@status_image << file.read
				file.close
			rescue
				@status_image << "\nИзображение не подгрузилось :(\n"
			end

			counter += 1
		end
	end


	# Метод для отображения статуса игры
	def print_status(game)

		cls

		puts "\nСлово: #{get_word_for_print(game.letters, game.good_letters)}"
		puts "\nКоличество допущенных ошибок: #{game.errors}"
		puts "Неверно названные буквы: #{game.bad_letters.join(", ")}"
		print_viselitsa(game.errors)

		if game.status == -1
			puts "\nК сожалению, Вы проиграли :("
			puts "Было загадано слово: #{game.letters.join("")}"
			exit
		elsif game.status == 1
			puts "\nПоздравляем! Вы победили!"
		else
			puts "У Вас осталось #{7 - game.errors} попыток."
		end
	end


	# Метод для очистки экрана
	def cls
		system "cls"
	end


	# Метод для отображения загаданного слова с учетом отгаданных букв
	def get_word_for_print(letters, good_letters)
		result = ""

		for letter in letters
			if good_letters.include?(letter)
				result += letter + " "
			else
				result += "_ "
			end
		end

		return result
	end


	# Метод для отрисовки виселицы
	def print_viselitsa(errors)
		puts @status_image[errors]
	end
end