require_relative '../rep_performer'

class Bilateral
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
      @speaker.say("set #{set_num}")

      @reps.times do |rep_index|
        rep_num = rep_index + 1

        @speaker.say(rep_num.to_s)
        @rep_performer.perform

        is_last_rep_of_set = (rep_index == @reps - 1)

        if is_last_rep_of_set
          @speaker.say("rest")
          @speaker.sleep @rest
        end
      end
    end
  end
end
