module Landing
  class RoundsComponent < ApplicationComponent
    ROUNDS = [
      {
        id: "R1",
        headline: "§103 over Kim in view of Alvarez",
        posture: "Argue only — no amendment",
        scope: "scope 100%",
        reasoning: "Kim teaches the recited weight computation but is silent on updating during a single frame interval. Examiner maps \"per-interval\" to Alvarez's periodic recalibration and asserts obvious combination for reduced latency.",
        delta_before: "1. A method comprising: computing a weight vector for each of a plurality of antenna elements",
        delta_add: " — no change —",
        open: false
      },
      {
        id: "R2",
        headline: "§103 maintained, Alvarez mapping narrowed",
        posture: "Narrow amendment + declaration",
        scope: "scope 91%",
        reasoning: "Examiner concedes Alvarez's recalibration is inter-frame, but maintains the rejection on the broader \"updating\" language. Indicates allowable subject matter if the interval constraint is recited affirmatively.",
        delta_before: "1. ... computing a weight vector",
        delta_add: ", wherein the computing is completed within a single frame interval,",
        open: true
      },
      {
        id: "R3",
        headline: "Notice of allowance",
        posture: "Interval limitation entered",
        scope: "scope 88%",
        reasoning: "No prior art of record teaches completing the weight computation within a single frame interval while maintaining the recited convergence bound. Claims 1–14 allowed as amended.",
        delta_before: "1. ... within a single frame interval",
        delta_add: ", the vector satisfying a convergence bound of the preceding interval.",
        open: false
      }
    ].freeze
  end
end
