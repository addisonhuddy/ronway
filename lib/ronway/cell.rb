module Ronway
  class Cell
    attr_reader :status

    def initialize(status = nil)
      @status = status
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
  end
end
