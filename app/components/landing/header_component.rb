module Landing
  class HeaderComponent < ApplicationComponent
    NAV = [
      { label: "How it works", href: "#how" },
      { label: "Simulation", href: "#rounds" },
      { label: "Metrics", href: "#metrics" },
      { label: "Pricing", href: "#pricing" }
    ].freeze
  end
end
