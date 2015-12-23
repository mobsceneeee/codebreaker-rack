module Codebreaker
  class Game
  	NUMBER_OF_TURNS = 10
    SECRET_CODE_LENGTH = 4 

    attr_accessor :user_guesses_and_answers, :game_status, :result_saved
    attr_reader :number_of_turns, :hints_avaliable

  	def initialize
      @secret_code = ""
      @number_of_turns = NUMBER_OF_TURNS 
      @hint_position = rand(SECRET_CODE_LENGTH)
      @hints_avaliable = 1
      @user_guesses_and_answers = []
      @game_status = "not_completed"
      @result_saved = false
    end
 
    def start
      SECRET_CODE_LENGTH.times {@secret_code << (1 + rand(6)).to_s}
    end

    def mark_user_guess(user_input)
    	answer = ""
      tmp_input = ""
      tmp_code = ""
      for i in 0...SECRET_CODE_LENGTH
        if user_input[i] == @secret_code[i]
          answer << "+"
        else 
          tmp_input << user_input[i]
          tmp_code << @secret_code[i]
        end 
      end
      if tmp_code.size > 0 
      	for i in 0...tmp_code.size
      		if tmp_code.include? tmp_input[i]
      			answer << "-"
      		end	
      	end
      end
      return answer
    end

    def analize(user_input)
      marked_guess = mark_user_guess(user_input)
      if user_input.match(/^[1-6]{4}$/)
        user_guesses_and_answers << {user_input => marked_guess}
        decrease_avaliable_turns
      else 
        user_guesses_and_answers << {user_input => "Wrong guess. Must be 4 numbers. Each from 1 to 6."}
      end

      if marked_guess == "++++"
        @game_status = "win"         
      elsif number_of_turns <= 0
        @game_status = "lose"
      end
    end

    def hint
      hint = "****" 
      hint[@hint_position] = @secret_code[@hint_position]
      @hints_avaliable -= 1
      return hint
    end

    def decrease_avaliable_turns
      @number_of_turns -= 1  
    end

    def save_to(file_name)
      File.open(file_name, 'w') {|f| f.write(YAML.dump(self)) }
    end

    def self.load_from(file_name)
      YAML.load(File.read(file_name))
    end
  end
end


