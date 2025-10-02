require_relative '../../lib/patterns/right_then_left'
require_relative '../support/text_printing_speaker'

RSpec.describe RightThenLeft do
  it 'runs all reps on right side then left side' do
    speaker = TextPrintingSpeaker.new
    exercise = {
      name: "kneeling windmill stretch",
      sets: 3,
      reps: 1,
      duration: 30,
      rest: 5
    }

    pattern = RightThenLeft.new(exercise, speaker)
    pattern.perform

    expected_output = <<~OUTPUT.strip
      right side first rep
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      10 seconds
      [sleep: 10]
      20 seconds
      [sleep: 10]
      rest
      two left
      [sleep: 5]
      right side second rep
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      10 seconds
      [sleep: 10]
      20 seconds
      [sleep: 10]
      rest
      one left
      [sleep: 5]
      right side third rep
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      10 seconds
      [sleep: 10]
      20 seconds
      [sleep: 10]
      switch
      [sleep: 5]
      left side first rep
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      10 seconds
      [sleep: 10]
      20 seconds
      [sleep: 10]
      rest
      two left
      [sleep: 5]
      left side second rep
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      10 seconds
      [sleep: 10]
      20 seconds
      [sleep: 10]
      rest
      one left
      [sleep: 5]
      left side third rep
      start [[slnc 500]]
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 10]
      10 seconds
      [sleep: 10]
      20 seconds
      [sleep: 10]
    OUTPUT

    expect(speaker.to_s).to eq(expected_output)
  end
end
