class WordReader

	def read_from_file(file_path)

		# Обработка отсутствия файла через исключение
		begin
			file = File.new(file_path, "r")
		rescue Errno::ENOENT => error
			abort "Ошибка: #{error}.\nНе найден файл со словами :("
		end

		words = file.readlines
		word = words.sample.chomp

		return word
	end
end