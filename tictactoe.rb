# Initialize the board
def initialize_board
  b = {}
  (1..9).each {|position| b[position] = ' '}
  b
end

# Set up 9-square gameboard
def draw_board(b)
  system 'clear'
  puts "------------------"
  puts "  #{b[1]}  |  #{b[2]}  |  #{b[3]}"
  puts "------------------"
  puts "  #{b[4]}  |  #{b[5]}  |  #{b[6]}"
  puts "------------------"
  puts "  #{b[7]}  |  #{b[8]}  |  #{b[9]}"
  puts "------------------"
end

def empty_positions(b)
  b.select {|k, v| v == ' '}.keys
end

def occupied_positions(b)
  b.select{|k, v| v == 'X'}.keys
  b.select{|k, v| v == 'O'}.keys
end

def player_picks_square(b)
  begin
    puts "Please pick a square (1-9)."
    position = gets.chomp.to_i
  end until empty_positions(b).include?(position)
  b[position] = 'X'
end

def computer_picks_square(b)
  position = empty_positions(b).sample
  b[position] = 'O'
end

def check_winner(b)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|
    if b[line[0]] == 'X' and b[line[1]] == 'X' and b[line[2]] == 'X'
      return 'Player'
    elsif b[line[0]] == 'O' and b[line[1]] == 'O' and b[line[2]] == 'O'
      return 'Computer'
    else 
      return nil
    end
  end
end

b = initialize_board
draw_board(b)

# Loop until a winner is found, or until all squares are taken (tie)  
begin 
  player_picks_square(b)
  computer_picks_square(b)
  draw_board(b)
  winner = check_winner(b)
end until winner || empty_positions(b).empty?

if winner
  puts "#{winner} won!"
else
  puts "It's a tie!"
end