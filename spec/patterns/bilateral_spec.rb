require_relative '../../lib/patterns/bilateral'
require_relative '../support/text_printing_speaker'

RSpec.describe Bilateral do
  it 'performs reps without side announcements' do
    speaker = TextPrintingSpeaker.new
    exercise = {
      name: "bridge",
      sets: 2,
      reps: 10,
      duration: 10,
      rest: 30
    }

    pattern = Bilateral.new(exercise, speaker)
    pattern.perform

    expected_output = <<~OUTPUT.strip
      rep 1 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 2 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 3 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 4 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 5 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 6 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 7 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 8 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 9 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 10 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rest
      [sleep: 30]
      rep 1 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 2 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 3 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 4 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 5 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 6 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 7 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 8 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 9 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rep 10 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
    OUTPUT

    expect(speaker.to_s).to eq(expected_output)
  end
end
