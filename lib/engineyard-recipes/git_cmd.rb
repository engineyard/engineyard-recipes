module Engineyard::Recipes
  module GitCmd
    class << self
      attr_accessor :test_mode
    end
    
    def self.git(command)
      if test_mode
        git_mock_log = File.expand_path("../../../tmp/git.log", __FILE__)
        File.open(git_mock_log, "a") { |file| file << command; file << "\n" }
      else
        puts "git #{command}"
        `git #{command}`
      end
    end

    def git(command)
      Engineyard::Recipes::GitCmd.git(command)
    end
  end
end
