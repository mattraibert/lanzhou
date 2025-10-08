class Speaker
  def initialize(voice = "Ava (Enhanced)")
    @voice = voice
  end

  def say(text)
    system('say', '-v', @voice, text)
  end

  def say_async(text)
    pid = spawn('say', '-v', @voice, text)
    Process.detach(pid)
  end

  def play_sound(sound_path)
    pid = spawn('afplay', sound_path)
    Process.detach(pid)
    Kernel.sleep(0.5)
  end

  def sleep(seconds)
    Kernel.sleep(seconds)
  end
end