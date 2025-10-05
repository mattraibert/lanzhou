require_relative '../rep_performer'

class RightThenLeft
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
    total_sets = @sets * 2

    (1..total_sets).each do |set_num|
      side, rep = determine_side_and_rep(set_num)
      rep_word = number_to_ordinal(rep)

      @speaker.say("#{side} #{rep_word} rep")
      @rep_performer.perform
      announce_completion(set_num, total_sets)
      rest_after_set(set_num, total_sets)
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

  def announce_completion(set_num, total_sets)
    if set_num == @sets
      @speaker.say("switch")
    else
      @speaker.say("rest")
      announce_remaining_reps(set_num) unless set_num == total_sets
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

  def rest_after_set(set_num, total_sets)
    @speaker.sleep @rest
  end
end
