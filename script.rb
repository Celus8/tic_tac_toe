class Board
  attr_reader :board

  def initialize
    @board = Array.new(9, 'empty')
  end

  def print_board
    i = 0
    @board.each_with_index do |box, index|
      case box
      when 'empty'
        print "#{index + 1} "
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

  def choose_play(play)
    exit = false
    loop do
      print_board
      i = gets.chomp.to_i
      if i.zero?
        exit = true
        break
      end

      play_made = make_play(i, play)
      break if play_made
    end
    exit
  end

  def full?
    !@board.include?('empty')
  end

  def win?(play)
    lines = []
    win = false
    for i in 0..2
      lines << create_line(@board[i * 3], @board[i * 3 + 1], @board[i * 3 + 2])
      lines << create_line(@board[i], @board[i+3], @board[i+6])
    end
    lines << create_line(@board[0], @board[4], @board[8])
    lines << create_line(@board[2], @board[4], @board[6])
    lines.each do |line|
      if line.all?(play)
        win = true
      end
    end
    puts "#{play.upcase} won!" if win
    win
  end

  private

  def create_line(x, y, z)
    [x, y, z]
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
end

class GameController
  def initialize
    @playing_board = Board.new
  end

  def play
    puts 'Welcome to Tic Tac Toe! The first player plays crosses, and the
    second one plays knots. To play a certain box, type a number from 1 to 9.
    Inputting a 0 or any other text will terminte the game. Have fun :)'
    loop do
      exit = @playing_board.choose_play('cross')
      if exit || @playing_board.win?('cross') || @playing_board.full?
        @playing_board.print_board
        break
      end
      exit = @playing_board.choose_play('knot')
      if exit || @playing_board.win?('knot') || @playing_board.full?
        @playing_board.print_board
        break
      end
    end
    puts 'End!'
  end
end

game = GameController.new
game.play
