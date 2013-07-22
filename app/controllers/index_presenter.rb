module Raspas
  class Raspas::IndexPresenter

    def initialize(author)
      @author = author
    end

    def recent_raspa
      @recent_raspa ||= @author.raspas.first
    end

  end
end

# REVISE check if needed?