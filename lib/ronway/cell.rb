module Ronway
  class Cell
    attr_reader :status

    def initialize(status = nil)
      @status = status || [:alive, :dead].sample #TODO make this more realistic
    end

    def alive?
      @status == :alive
    end

    def dead?
      @status == :dead
    end

    def live!
      @status = :alive
    end

    def die!
      @status = :dead
    end

    def to_s
      @status == :alive ? "o" : " "
    end
  end
end
