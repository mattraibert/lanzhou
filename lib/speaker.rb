class Speaker
  def initialize(voice = "Ava (Enhanced)")
    @voice = voice
  end

  def say(text)
    `say -v "#{@voice}" "#{text}"`
  end

  def play_sound(sound_path)
    `afplay #{sound_path}`
  end

  def sleep(seconds)
    Kernel.sleep(seconds)
  end
end