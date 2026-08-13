module Ui
  class SectionHeadingComponent < ApplicationComponent
    def initialize(title:, eyebrow: nil, lede: nil, tone: :light, align: :left)
      @title = title
      @eyebrow = eyebrow
      @lede = lede
      @tone = tone
      @align = align
    end

    def title_color
      @tone == :dark ? "color: var(--color-dark-fg);" : "color: var(--color-ink);"
    end

    def lede_color
      @tone == :dark ? "color: var(--color-dark-fg-muted);" : "color: var(--color-ink-muted);"
    end

    def align_style
      case @align
      when :center then "text-align:center;"
      when :right then "text-align:right;"
      else ""
      end
    end

    def eyebrow_tone
      @tone == :dark ? :dark : :accent
    end
  end
end
