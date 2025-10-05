require_relative 'speaker'
require_relative 'patterns/right_then_left'
require_relative 'patterns/alternating_reps'
require_relative 'patterns/alternating_sets'
require_relative 'patterns/bilateral'
require_relative 'patterns/warm_up_flow'
require_relative 'audio_constants'
require_relative 'skip_handler'

class ExerciseRunner
  def initialize(exercise, exercise_index, total_exercises, speaker: Speaker.new)
    @exercise = exercise
    @exercise_name = exercise[:name]
    @duration = exercise[:duration]
    @rest = exercise[:rest]
    @exercise_index = exercise_index
    @total_exercises = total_exercises
    @is_last_exercise = exercise_index == total_exercises - 1
    @speaker = speaker
  end

  def perform
    loop do
      puts "\n=== Exercise #{@exercise_index + 1} of #{@total_exercises}: #{@exercise_name} ==="
      puts "(Press: 's' skip | 'b' back | 'r' restart | 'p' pause | 'q' or Ctrl-C quit)"

      SkipHandler.start_listening(Thread.current)

      begin
        # Announce exercise and countdown
        @speaker.say("#{@exercise_name}")
        4.times do |count|
          @speaker.play_sound(COUNTDOWN_SOUND)
        end

        # Dispatch to pattern handler
        pattern = create_pattern
        pattern.perform

        # Announce completion
        @speaker.say(@is_last_exercise ? "workout complete" : "next exercise")
        break  # Exercise completed successfully
      rescue SkipExercise
        # Exercise was skipped, just continue
        break
      rescue RestartExercise
        # Restart the exercise - loop will continue
        next
      rescue PreviousExercise, QuitWorkout
        # Re-raise to propagate up to main program
        raise
      ensure
        SkipHandler.stop_listening
      end
    end
  end

  private

  def create_pattern
    pattern_name = @exercise[:pattern]

    case pattern_name
    when "right then left"
      RightThenLeft.new(@exercise, @speaker)
    when "alternating reps"
      AlternatingReps.new(@exercise, @speaker)
    when "alternating sets"
      AlternatingSets.new(@exercise, @speaker)
    when "bilateral"
      Bilateral.new(@exercise, @speaker)
    when "warm-up flow"
      WarmUpFlow.new(@exercise, @speaker)
    else
      raise "Unknown pattern: #{pattern_name}"
    end
  end
end