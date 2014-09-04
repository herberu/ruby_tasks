class MagicWord

        def initialize word
                @word = word
                @magic_word = "*"*word.length
        end

        def include_suggest? suggest
                @word.include? suggest
        end

        def replace_in_magic_word suggest

                if suggest.length == 1
                        index = 0
                        while index < @word.length  do
                                if @word[index] == suggest
                                        @magic_word[index] = suggest
                                 end
                                index  = index + 1
                        end
                else
                        suggest_index  = @word.index(suggest)
                        last_index = suggest_index + suggest.length
                        index = 0
                        while suggest_index < last_index do
                                @magic_word[suggest_index] = suggest[index]
                                index = index + 1
                                suggest_index = suggest_index + 1
                        end

                end

                @magic_word
        end

        def get_magic_word
                 @magic_word
        end

        def get_word
                @word
        end

end



class Hangman

        def initialize
                @lives = 3
                @score = 0
                @words = []
                @current_index = 0

                @words[0] = MagicWord.new "ruby"
                @words[1] = MagicWord.new  "computer"
                @words[2] = MagicWord.new "trackpad"

                puts "Welcome to Hangman game!"
                puts "Are you ready to start?"
        end

        def cur_word
                @words[@current_index]
        end

        def start
                puts "You have #{@lives} lives"
                puts "You can get 10 points for each correct answer"
                puts "Starting..."

                start_proc = Proc.new do

                        while @current_index < 3 && @lives > 0 do
                                ask
                        end

                        puts "You finished the game, your score is #{@score}"
                        puts "Thanks for play with us!!!"

                end

                start_proc.call

        end
        
        def ask
                puts cur_word.get_magic_word
                puts "Whats is your suggest?"
                suggest = gets.chomp

                if suggest.empty?
                        puts "You can't set Enter key"
                        return
                end

                if cur_word.include_suggest? suggest
                        @score = @score + 10
                        puts "That's correct!"
                        puts "Your score is #{@score}"
                        cur_word.replace_in_magic_word suggest


                        unless  cur_word.get_magic_word.include? "*"
                                @current_index = @current_index + 1
                        end
                else
                        @lives = @lives - 1
                        puts "Error!!!"
                        puts "You have #{@lives} lives"
                end

        end
end



hangman = Hangman.new
hangman.start
