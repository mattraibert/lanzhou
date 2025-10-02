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

        is_last_rep_of_set = (rep_index == @reps - 1)
        is_last_set = (set_index == @sets - 1)

        unless is_last_rep_of_set && is_last_set
          if is_last_rep_of_set
            @speaker.say("rest")
            @speaker.sleep @rest
          end
        end
      end
    end
  end
end
