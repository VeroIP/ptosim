module Landing
  class HowItWorksComponent < ApplicationComponent
    STEPS = [
      { n: "01", title: "Upload the file", body: "Specification plus a claim set for a new filing, or the pending claims and the current Office action for a live case." },
      { n: "02", title: "Set the strategy", body: "Your organization's prosecution posture — hold claims early, amend hard to cut rounds — guides every simulated response." },
      { n: "03", title: "Run examination", body: "Rejections, responses, and amendments iterate until the case is allowed or the record is exhausted." },
      { n: "04", title: "Pick your path", body: "Take the final allowance or stop at an interim round. Every option arrives costed and dated." }
    ].freeze
  end
end
