class Bilateral
  def initialize(exercise, speaker)
    @exercise_name = exercise[:name]
    @sets = exercise[:sets]
    @reps = exercise[:reps]
    @duration = exercise[:duration]
    @rest = exercise[:rest]
    @speaker = speaker
  end

  def perform
    @sets.times do |set_index|
      set_num = set_index + 1
      @speaker.say("set #{set_num}")

      @reps.times do |rep_index|
        rep_num = rep_index + 1

        @speaker.say(rep_num)
        perform_rep

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

  private

  def perform_rep
    @speaker.play_sound('/System/Library/Sounds/Glass.aiff')
    @speaker.sleep @duration
    @speaker.play_sound('/System/Library/Sounds/Bottle.aiff')
  end
end
