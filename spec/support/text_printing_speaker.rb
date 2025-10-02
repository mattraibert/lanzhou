class TextPrintingSpeaker
  attr_reader :output

  def initialize
    @output = []
  end

  def say(text)
    @output << text
  end

  def play_sound(sound_path)
    @output << "[sound: #{sound_path}]"
  end

  def sleep(seconds)
    @output << "[sleep: #{seconds}]"
  end

  def to_s
    @output.join("\n")
  end
end
