module Landing
  class PricingComponent < ApplicationComponent
    TIERS = [
      {
        name: "Practice",
        who: "Single prosecution group getting started.",
        price: "$24k",
        unit: "per year + $180 per simulation",
        cta: "Book a demo",
        features: [
          "Up to 15 attorney seats",
          "Shared strategy presets",
          "Full simulated record and export",
          "Email support"
        ]
      },
      {
        name: "Firm",
        who: "Multi-office firms running a live docket.",
        price: "$60k",
        unit: "per year + $140 per simulation",
        cta: "Book a demo",
        features: [
          "Unlimited seats",
          "Per-client strategy libraries",
          "Cost and scope dashboards",
          "SSO and audit log",
          "Named account team"
        ]
      },
      {
        name: "Enterprise",
        who: "In-house teams and IP operations.",
        price: "Custom",
        unit: "volume simulation rates",
        cta: "Talk to us",
        features: [
          "Outside-counsel benchmarking",
          "Portfolio-level reporting",
          "Deployment in your tenancy",
          "Procurement and security review",
          "Custom strategy modeling"
        ]
      }
    ].freeze
  end
end
