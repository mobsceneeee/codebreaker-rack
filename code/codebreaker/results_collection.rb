module Codebreaker   
  class ResultsCollection 
    attr_accessor :results

  	def initialize
      @results = []
    end

    def save_to(file_name)
  	  File.open(file_name, 'w') {|f| f.write(YAML.dump(self)) }
  	end

  	def self.load_from(file_name)
  	  YAML.load(File.read(file_name))
  	end
  end
end