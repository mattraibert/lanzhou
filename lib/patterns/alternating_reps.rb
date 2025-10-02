class AlternatingReps
  def initialize(exercise, speaker)
    @exercise_name = exercise[:name]
    @sets = exercise[:sets]
    @reps = exercise[:reps]
    @duration = exercise[:duration]
    @rest = exercise[:rest]
    @speaker = speaker
  end

  def perform(is_last_exercise)
    # Initial countdown at start of exercise
    @speaker.say("#{@exercise_name}")
    10.downto(1) do |count|
      @speaker.say(count.to_s)
      sleep 0.5
    end

    @sets.times do |set_index|
      set_num = set_index + 1

      @reps.times do |rep_index|
        side = rep_index.even? ? "right" : "left"
        rep_num = rep_index + 1

        @speaker.say("#{side} rep #{rep_num} set #{set_num}")
        perform_rep

        is_last_rep_of_set = (rep_index == @reps - 1)
        is_last_set = (set_index == @sets - 1)

        if is_last_rep_of_set && is_last_set
          @speaker.say(is_last_exercise ? "workout complete" : "next exercise")
        elsif is_last_rep_of_set
          @speaker.say("rest")
          sleep @rest unless is_last_exercise && is_last_set
        end
      end
    end
  end

  private

  def perform_rep
    @speaker.say("start [[slnc 500]]")
    @speaker.play_sound('/System/Library/Sounds/Glass.aiff')
    sleep @duration
  end
end
