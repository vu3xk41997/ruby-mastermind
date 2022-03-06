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
            If both color and position matched, it will show as \"correct match\".
            If only color matched, it will show as \"correct color\".
            If you got the secret code within 12 chances, you win!

            Should we (p)lay or you want to (q)uit?
        HEREDOC
    end

    def display_guess_promt
        <<~HEREDOC

            I have generated a beginner sequence with four elements made up of:
            (r)ed, (b)lue, (g)reen, (y)ellow, (o)range, (p)urple.
            Use (q)uit at any time to end the game.

            What's your guess?
        HEREDOC
    end

    def display_input_error
        "\e[31mInvalid input, please try again.\e[0m"
    end

    def display_winner
        "You win!"
    end

    def display_loser
        "You lose."
    end
end

# create Game
class Game

    @@colors = ["r", "b", "g", "y", "o", "p"]
    
    include Display

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
            guess
        when "i"
            puts display_instruction
            instriction_input = gets.chomp.downcase
            until instriction_input.match?(/^p$|^q$/)
                puts display_input_error
                instriction_input = gets.chomp.downcase
            end
            if instriction_input == "p"
                guess
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

    def guess
        set_secret_code
        puts display_guess_promt
        guess = gets.chomp
    end

    def set_secret_code
        code = [@@colors.sample, @@colors.sample, @@colors.sample, @@colors.sample]
    end

end

class Guess_player

    attr_reader :guess_array, :code

    def initialize
        @guess_array = []
        @code = []
    end
end

# main
Game.new.play