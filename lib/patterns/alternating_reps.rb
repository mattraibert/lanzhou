require_relative '../rep_performer'

class AlternatingReps
  def initialize(exercise, speaker)
    @exercise_name = exercise[:name]
    @sets = exercise[:sets]
    @reps = exercise[:reps]
    @duration = exercise[:duration]
    @rest = exercise[:rest]
    @speaker = speaker
    @rep_performer = RepPerformer.new(speaker, exercise[:duration])
  end

  def perform
    @sets.times do |set_index|
      set_num = set_index + 1

      @reps.times do |rep_index|
        # Each rep is a pair: right then left
        @speaker.say("right")
        @rep_performer.perform

        @speaker.say("left")
        @rep_performer.perform
      end

      @speaker.say("rest")
      @speaker.sleep @rest
    end
  end
end
