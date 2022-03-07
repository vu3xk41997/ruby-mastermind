# create Display
module Display
    def display_intro
        "Welcome to MASTERMIND!\n\n"
    end

    def display_intro_promt
        "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    end

    def display_instruction
        <<~HEREDOC

            The computer will create a 4 digits secret code with 6 different colors.
            The colors are (r)ed, (b)lue, (g)reen, (y)ellow, (o)range, (p)urple.

            You have 12 chances to guess the correct answer.
            During each guess, the code will be checked with the secret code and display the matching result.
            If both color and position matched, it will show as \"◉\".
            If only color matched, it will show as \"◯\".
            If you got the secret code within 12 chances, you win!

            Should we (p)lay or you want to (q)uit?
        HEREDOC
    end

    def display_guess_promt
        <<~HEREDOC

            I have generated a beginner sequence with four elements made up of:
            (r)ed, (b)lue, (g)reen, (y)ellow, (o)range, (p)urple.
            Use (q)uit at any time to end the game.

        HEREDOC
    end

    def display_input_error
        "\e[31mInvalid input, please try again.\e[0m"
    end

    def display_clue(exact, correct)
        print "Clues:"
        exact.times { print " ◉ " }
        correct.times { print " ◯ " }
        puts " "
    end

    def display_winner
        "You win!"
    end

    def display_loser
        "You lose."
    end
end



# create Clue
module Clue

    def compare(master, guess)
        temp_master = master.clone
        temp_guess = guess.clone
        @exact_number = exact_match(temp_master, temp_guess)
        @correct_number = correct_color(temp_master, temp_guess)
        # @total_number = @exact_number + @same_number
    end

    def exact_match(master, guess)
        exact = 0
        master.each_with_index do |item, index|
          next unless item == guess[index]
    
          exact += 1
          master[index] = '◉'
          guess[index]  = '◉'
        end
        exact
      end
    
      def correct_color(master, guess)
        correct = 0
        guess.each_index do |index|
          next unless guess[index] != '◉' && master.include?(guess[index])
    
          same += 1
          remove = master.find_index(guess[index])
          master[remove] = '◯'
          guess[index] = '◯'
        end
        correct
      end

    def game_solved?(master, guess)
        master == guess
    end

    def repeat_game
        puts "Play again? (y/n)"
        repeat_input = gets.chomp.downcase
        if repeat_input == 'y'
            play
        else
            puts "See you!"
        end
    end
end



# create Game
class Game

    @@colors = ["r", "b", "g", "y", "o", "p"].freeze
    
    include Display
    include Clue

    attr_reader :player
    def initialize
        @player = Guess_player.new
    end

    def play
        puts display_intro
        puts display_intro_promt
        intro_input = gets.chomp.downcase
        case intro_input
        when "p"
            game_start
        when "i"
            puts display_instruction
            instriction_input = gets.chomp.downcase
            until instriction_input.match?(/^p$|^q$/)
                puts display_input_error
                instriction_input = gets.chomp.downcase
            end
            if instriction_input == "p"
                game_start
            elsif instriction_input =="q"
                warn "See you next time."
                exit 1
            end
        when "q"
            warn "See you next time."
            exit 1
        else
            puts display_input_error
            play
        end
    end

    def game_start
        puts display_guess_promt
        set_secret_code
        @player.guess
        compare(@@secret_code, @player.guess_array)
        display_clue(@exact_number, @correct_number)
    end

    def set_secret_code
        @@secret_code = [@@colors.sample, @@colors.sample, @@colors.sample, @@colors.sample]
        p @@secret_code
    end

end

class Guess_player

    attr_reader :guess_array

    def initialize
        @guess_array = []
    end

    def guess
        puts "Choose from the following: (r)ed, (b)lue, (g)reen, (y)ellow, (o)range, (p)urple"
        for i in 1..4
            player_guess = gets.chomp
            i += 1
            if player_guess == "q"
                warn "See you next time."
                exit 1
            else
                @guess_array.push(player_guess)
            end
        end
        puts "\nYour guess is #{@guess_array}"
    end

    def clear_guess
        @guess_array = []
    end
end

# main
Game.new.play