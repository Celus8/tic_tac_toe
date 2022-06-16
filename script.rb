require 'pry-byebug'

class Board
  attr_reader :board

  def initialize
    @board = Array.new(9, 'empty')
  end

  def print_board
    i = 0
    @board.each do |box|
      case box
      when 'empty'
        print '- '
        i += 1
      when 'cross'
        print 'x '
        i += 1
      when 'knot'
        print 'o '
        i += 1
      end
      if (i % 3).zero?
        print "\n"
      end
    end
  end

  def make_play(position, play)
    if @board[position - 1] == 'empty'
      @board[position - 1] = play
      true
    else
      puts "You can't play there!"
      false
    end
  end

  def choose_play(play)
    loop do
      print_board
      i = gets.chomp.to_i
      break if i.zero?

      play_made = make_play(i, play)
      break if play_made
    end
  end

  def full?
    sum = @board.reduce(0) do |accumulator, box|
      if box == 'empty'
        accumulator += 1
      end
      accumulator
    end
    sum.zero? ? true : false
  end
end

class GameController
  def initialize
    @playing_board = Board.new
  end

  def play
    loop do
      break if @playing_board.full?

      @playing_board.choose_play('cross')
      @playing_board.choose_play('knot')
    end
    puts 'End!'
  end
end

game = GameController.new
game.play
