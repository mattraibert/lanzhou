require_relative 'audio_constants'
require_relative 'rep_timer'

class RepPerformer
  def initialize(speaker, duration)
    @speaker = speaker
    @duration = duration
  end

  def perform
    RepTimer.time_rep do
      @speaker.play_sound(START_SOUND)

      elapsed = 0
      notifications = STRETCH_NOTIFICATIONS.select { |t| t < @duration }
      notifications.each do |notification_time|
        @speaker.sleep(notification_time - elapsed)
        @speaker.say_async("#{notification_time} seconds")
        elapsed = notification_time
      end
      @speaker.sleep(@duration - elapsed)
      @speaker.play_sound(END_SOUND)
    end
  end
end
