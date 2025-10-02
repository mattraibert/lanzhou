require_relative '../../lib/patterns/alternating_reps'
require_relative '../support/text_printing_speaker'

RSpec.describe AlternatingReps do
  it 'alternates sides on each rep' do
    speaker = TextPrintingSpeaker.new
    exercise = {
      name: "blocked flexed dead bug",
      sets: 2,
      reps: 5,
      duration: 10,
      rest: 30
    }

    pattern = AlternatingReps.new(exercise, speaker)
    pattern.perform

    expected_output = <<~OUTPUT.strip
      right rep 1 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      left rep 2 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      right rep 3 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      left rep 4 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      right rep 5 set 1
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      rest
      [sleep: 30]
      right rep 1 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      left rep 2 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      right rep 3 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      left rep 4 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      right rep 5 set 2
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
    OUTPUT

    expect(speaker.to_s).to eq(expected_output)
  end
end
