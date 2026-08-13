module Landing
  class FooterComponent < ApplicationComponent
    def initialize(year: Date.current.year)
      @year = year
    end

    attr_reader :year
  end
end
