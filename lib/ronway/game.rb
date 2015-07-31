module Ronway
  class Game
    def initialize
      @grid = Grid.new(60)
    end

    def run
      puts "Starting"
      sleep 2
      clear_screen

      loop do
        @grid.generate!
        puts @grid.to_s
        sleep 0.25
        clear_screen
      end
    end

    private
    def clear_screen
      print "\e[H\e[2J"
    end
  end
end
