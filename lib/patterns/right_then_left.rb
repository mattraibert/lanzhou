require_relative '../audio_constants'

class RightThenLeft
  def initialize(exercise, speaker)
    @exercise_name = exercise[:name]
    @sets = exercise[:sets]
    @reps = exercise[:reps]
    @duration = exercise[:duration]
    @rest = exercise[:rest]
    @speaker = speaker
  end

  def perform
    total_sets = @sets * 2

    (1..total_sets).each do |set_num|
      side, rep = determine_side_and_rep(set_num)
      rep_word = number_to_ordinal(rep)

      @speaker.say("#{side} #{rep_word} rep")
      perform_stretch
      announce_completion(set_num, total_sets)
      rest_unless_final_set(set_num, total_sets)
    end
  end

  private

  def determine_side_and_rep(set_num)
    if set_num <= @sets
      ["right side", set_num]
    else
      ["left side", set_num - @sets]
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
    @speaker.play_sound(START_SOUND)

    elapsed = 0
    notifications = STRETCH_NOTIFICATIONS.select { |t| t < @duration }
    notifications.each do |notification_time|
      @speaker.sleep(notification_time - elapsed)
      @speaker.say("#{notification_time} seconds")
      elapsed = notification_time
    end
    @speaker.sleep(@duration - elapsed)
    @speaker.play_sound(END_SOUND)
  end

  def announce_completion(set_num, total_sets)
    if set_num == @sets
      @speaker.say("switch")
    elsif set_num != total_sets
      @speaker.say("rest")
      announce_remaining_reps(set_num)
    end
  end

  def announce_remaining_reps(set_num)
    total_sets = @sets * 2
    remaining = if set_num < @sets
      @sets - set_num
    else
      total_sets - set_num
    end

    if remaining == 2
      @speaker.say("two left")
    elsif remaining == 1
      @speaker.say("one left")
    end
  end

  def rest_unless_final_set(set_num, total_sets)
    return if set_num == total_sets
    @speaker.sleep @rest
  end
end
