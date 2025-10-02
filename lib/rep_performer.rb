require_relative 'audio_constants'

class RepPerformer
  def initialize(speaker, duration)
    @speaker = speaker
    @duration = duration
  end

  def perform
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
end
