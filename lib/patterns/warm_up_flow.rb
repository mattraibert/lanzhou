class WarmUpFlow
  FLOW_CUES = [
    "inhale up",
    "exhale fold",
    "inhale up",
    "exhale back",
    "inhale up",
    "exhale back",
    "breathe",
    "1", "2", "3", "4", "5",
    "inhale forward",
    "exhale down",
    "inhale up",
    "exhale hands down"
  ]

  def initialize(exercise, speaker)
    @exercise_name = exercise[:name]
    @sets = exercise[:sets]
    @reps = exercise[:reps]
    @duration = exercise[:duration]
    @speaker = speaker
  end

  def perform
    total_reps = @sets * @reps

    total_reps.times do |i|
      rep_num = i + 1
      @speaker.say("#{@exercise_name} rep #{rep_num}")
      perform_flow
    end
  end

  private

  def perform_flow
    FLOW_CUES.each do |cue|
      @speaker.say(cue)
      @speaker.sleep @duration
    end
  end
end
