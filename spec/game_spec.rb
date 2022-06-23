# Подключаем джем для тестирования
require 'rspec'

# Подключаем класс, который будем првоерять
require 'game'

# Описываем сценарий
describe Game do

  # Зададим общее условие для двух кейсов (загадываем слово)
  before do
    @game = Game.new("тестирование")
  end

  # Описываем кейсы
  it "Победный кейс" do
    # Убедимся сразу, что игра "в процессе"
    expect(@game.status).to eq 0

    # Дальше отгадываем слово
    "тестирование".each_char do |char|
      @game.next_step(char)
    end

    # Првоеряем кол-во ошибок и статус игры
    @game.errors == 0
    @game.status == 1
  end

  it "Проигрышный кейс" do
    # Убедимся сразу, что игра "в процессе"
    expect(@game.status).to eq 0

    # Дальше специально пытаемся не отгадать слово
    "абвгдежзик".each_char do |char|
      @game.next_step(char)
    end

    # Првоеряем кол-во ошибок и статус игры
    @game.errors == 7
    @game.status == -1
  end

end