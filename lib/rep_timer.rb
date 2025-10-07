# noinspection RubyClassVariableUsageInspection
class RepTimer
  @@last_rep_end_time = nil

  def self.time_rep
    start_time = Time.now

    if @@last_rep_end_time
      time_between_reps = start_time - @@last_rep_end_time
      puts "Time between reps: #{time_between_reps.round(1)}s"
    end

    yield

    end_time = Time.now
    duration = end_time - start_time
    puts "Rep duration: #{duration.round(1)}s"

    @@last_rep_end_time = end_time
  end
end