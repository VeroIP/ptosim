module Ui
  # @label Stat
  class StatComponentPreview < Lookbook::Preview
    def small
      render Ui::StatComponent.new(figure: "3", label: "rounds to allowance", size: :sm)
    end

    def medium
      render Ui::StatComponent.new(figure: "$8.8k", label: "Spend avoided")
    end

    def large
      render Ui::StatComponent.new(figure: "62%", label: "Cases where an earlier exit retained more scope", size: :lg)
    end
  end
end
