require_relative '../rep_performer'

class AlternatingSets
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
      side = determine_side(set_num)
      set_on_this_side = ((set_num + 1) / 2)

      @speaker.say("#{side} set #{set_on_this_side}")

      @reps.times do |rep_index|
        rep_num = rep_index + 1
        @speaker.say(rep_num.to_s)
        @rep_performer.perform
      end

      announce_completion(set_num, total_sets)
      rest_unless_final_set(set_num, total_sets)
    end
  end

  private

  def determine_side(set_num)
    set_num.odd? ? "right side" : "left side"
  end

  def announce_completion(set_num, total_sets)
    if set_num == total_sets
      # Last set - no announcement
    elsif set_num.odd?
      @speaker.say("switch")
    else
      @speaker.say("rest")
      announce_remaining_sets(set_num, total_sets)
    end
  end

  def announce_remaining_sets(set_num, total_sets)
    remaining = total_sets - set_num

    if remaining == 4
      @speaker.say("two left each side")
    elsif remaining == 2
      @speaker.say("one left each side")
    end
  end

  def rest_unless_final_set(set_num, total_sets)
    return if set_num == total_sets
    @speaker.sleep @rest
  end
end