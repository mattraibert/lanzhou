require_relative 'audio_constants'

class RepPerformer
  @@last_rep_end_time = nil

  def initialize(speaker, duration)
    @speaker = speaker
    @duration = duration
  end

  def perform
    start_time = Time.now

    # Print time between reps if this isn't the first rep
    if @@last_rep_end_time
      time_between_reps = start_time - @@last_rep_end_time
      puts "Time between reps: #{time_between_reps.round(1)}s"
    end

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

    end_time = Time.now
    actual_duration = end_time - start_time
    puts "Rep duration: #{actual_duration.round(1)}s"

    @@last_rep_end_time = end_time
  end
end
