module Landing
  class MetricsComponent < ApplicationComponent
    BULLETS = [
      "Cost per path, split between attorney time and Office fees.",
      "Scope retained at each exit, measured against the claims as filed.",
      "Portfolio view: which strategies actually close cases faster across your docket."
    ].freeze

    PATHS = [
      { name: "Argue through R3", meta: "3 rounds · 19 mo", cost: "$14,200", pct: 78 },
      { name: "Stop at R2", meta: "2 rounds · 13 mo", cost: "$9,600", pct: 53 },
      { name: "Amend at R1", meta: "1 round · 8 mo", cost: "$5,400", pct: 30 }
    ].freeze

    TILES = [
      { label: "Spend avoided", value: "$8.8k" },
      { label: "Months saved", value: "11" },
      { label: "Scope retained", value: "91%" }
    ].freeze
  end
end
