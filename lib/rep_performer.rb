require_relative 'audio_constants'

class RepPerformer
  def initialize(speaker, duration)
    @speaker = speaker
    @duration = duration
  end

  def perform
    @speaker.play_sound(START_SOUND)
    @speaker.sleep @duration
    @speaker.play_sound(END_SOUND)
  end
end
