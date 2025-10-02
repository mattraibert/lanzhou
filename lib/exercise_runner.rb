require_relative 'speaker'
require_relative 'patterns/right_then_left'
require_relative 'patterns/alternating_reps'
require_relative 'patterns/bilateral'
require_relative 'patterns/warm_up_flow'
require_relative 'audio_constants'

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
    puts "\n=== Exercise #{@exercise_index + 1} of #{@total_exercises}: #{@exercise_name} ==="

    # Announce exercise and countdown
    @speaker.say("#{@exercise_name}")
    6.times do |count|
      @speaker.play_sound(COUNTDOWN_SOUND)
    end

    # Dispatch to pattern handler
    pattern = create_pattern
    pattern.perform

    # Announce completion
    @speaker.say(@is_last_exercise ? "workout complete" : "next exercise")
  end

  private

  def create_pattern
    pattern_name = @exercise[:pattern]

    case pattern_name
    when "right then left"
      RightThenLeft.new(@exercise, @speaker)
    when "alternating reps"
      AlternatingReps.new(@exercise, @speaker)
    when "bilateral"
      Bilateral.new(@exercise, @speaker)
    when "warm-up flow"
      WarmUpFlow.new(@exercise, @speaker)
    else
      raise "Unknown pattern: #{pattern_name}"
    end
  end
end