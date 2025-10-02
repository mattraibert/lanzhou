# Notification intervals during stretch (in seconds)
STRETCH_NOTIFICATIONS = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120]

class RightThenLeft
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

    total_rounds = @sets * 2

    (1..total_rounds).each do |round|
      side, rep = determine_side_and_rep(round)
      rep_word = number_to_ordinal(rep)

      @speaker.say("#{side} #{rep_word} rep")
      perform_stretch
      announce_completion(round, total_rounds, is_last_exercise)
      rest_unless_final_round(round, total_rounds, is_last_exercise)
    end
  end

  private

  def determine_side_and_rep(round)
    if round <= @sets
      ["right side", round]
    else
      ["left side", round - @sets]
    end
  end

  def number_to_ordinal(num)
    case num
    when 1 then "first"
    when 2 then "second"
    when 3 then "third"
    else num.to_s + "th"
    end
  end

  def perform_stretch
    @speaker.say("start [[slnc 500]]")
    @speaker.play_sound('/System/Library/Sounds/Glass.aiff')

    elapsed = 0
    notifications = STRETCH_NOTIFICATIONS.select { |t| t < @duration }
    notifications.each do |notification_time|
      sleep(notification_time - elapsed)
      @speaker.say("#{notification_time} seconds")
      elapsed = notification_time
    end
    sleep(@duration - elapsed)
  end

  def announce_completion(round, total_rounds, is_last_exercise)
    if round == @sets
      @speaker.say("switch")
    elsif round == total_rounds
      @speaker.say(is_last_exercise ? "workout complete" : "next exercise")
    else
      @speaker.say("rest")
      announce_remaining_reps(round)
    end
  end

  def announce_remaining_reps(round)
    remaining = if round < @sets
      @sets - round
    else
      total_rounds - round
    end

    if remaining == 2
      @speaker.say("two left")
    elsif remaining == 1
      @speaker.say("one left")
    end
  end

  def rest_unless_final_round(round, total_rounds, is_last_exercise)
    return if is_last_exercise && round == total_rounds
    sleep @rest
  end
end
