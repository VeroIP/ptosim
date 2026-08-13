module Ui
  class StatComponent < ApplicationComponent
    def initialize(figure:, label:, size: :md, tone: :light)
      @figure = figure
      @label = label
      @size = size
      @tone = tone
    end

    def figure_style
      base = "font-family:var(--font-display);line-height:1;"
      case @size
      when :sm then base + "font-weight:500;font-size:30px;"
      when :lg then base + "font-weight:600;font-size:36px;letter-spacing:-0.02em;"
      else base + "font-weight:500;font-size:26px;"
      end
    end

    def label_style
      color = @tone == :dark ? "var(--color-dark-fg-soft)" : "var(--color-ink-soft)"
      "font-size:#{@size == :sm ? '11.5px' : '13px'};line-height:1.4;color:#{color};margin-top:#{@size == :sm ? '4px' : '8px'};"
    end
  end
end
