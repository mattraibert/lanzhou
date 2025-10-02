require_relative 'speaker'

# Timing constants
ROUNDS_PER_SIDE = 3
TOTAL_SIDES = 2
ROUNDS_PER_EXERCISE = ROUNDS_PER_SIDE * TOTAL_SIDES
STRETCH_DURATION = 30
REST_DURATION = 2
COUNTDOWN_DURATION = 5

# Notification intervals during stretch (in seconds)
STRETCH_NOTIFICATIONS = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120]

# Sound file
START_SOUND = '/System/Library/Sounds/Glass.aiff'

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
    10.downto(1) do |count|
      @speaker.say(count.to_s)
      @speaker.sleep 0.5
    end

    # TODO: Dispatch to pattern handler here
    (1..ROUNDS_PER_EXERCISE).each do |exercise_round|
      side, rep = determine_side_and_rep(exercise_round)
      rep_word = number_to_ordinal(rep)

      @speaker.say("#{side} #{rep_word} rep")
      perform_stretch
      announce_completion(exercise_round)
      rest_unless_final_round(exercise_round)
    end

    # Announce completion
    @speaker.say(@is_last_exercise ? "workout complete" : "next exercise")
  end

  private

  def determine_side_and_rep(exercise_round)
    if exercise_round <= ROUNDS_PER_SIDE
      ["right side", exercise_round]
    else
      ["left side", exercise_round - ROUNDS_PER_SIDE]
    end
  end

  def number_to_ordinal(num)
    case num
    when 1 then "first"
    when 2 then "second"
    when 3 then "third"
    end
  end

  def perform_stretch
    @speaker.say("start [[slnc 500]]")
    @speaker.play_sound(START_SOUND)

    elapsed = 0
    notifications = STRETCH_NOTIFICATIONS.select { |t| t < @duration }
    notifications.each do |notification_time|
      @speaker.sleep(notification_time - elapsed)
      @speaker.say("#{notification_time} seconds")
      elapsed = notification_time
    end
    @speaker.sleep(@duration - elapsed)
  end

  def announce_completion(exercise_round)
    if exercise_round == ROUNDS_PER_SIDE
      @speaker.say("switch")
    elsif exercise_round == ROUNDS_PER_EXERCISE
      @speaker.say(@is_last_exercise ? "workout complete" : "next exercise")
    else
      @speaker.say("rest")
      announce_remaining_reps(exercise_round)
    end
  end

  def announce_remaining_reps(exercise_round)
    if exercise_round == 1 || exercise_round == ROUNDS_PER_SIDE + 1
      @speaker.say("two left")
    elsif exercise_round == 2 || exercise_round == ROUNDS_PER_SIDE + 2
      @speaker.say("one left")
    end
  end

  def rest_unless_final_round(exercise_round)
    return if @is_last_exercise && exercise_round == ROUNDS_PER_EXERCISE
    sleep @rest
  end
end