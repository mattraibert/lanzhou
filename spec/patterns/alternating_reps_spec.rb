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
      right
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 5.0]
      halfway
      [sleep: 5.0]
      left
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 5.0]
      halfway
      [sleep: 5.0]
      right
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 5.0]
      halfway
      [sleep: 5.0]
      left
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 5.0]
      halfway
      [sleep: 5.0]
      right
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 5.0]
      halfway
      [sleep: 5.0]
      rest
      [sleep: 30]
      right
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 5.0]
      halfway
      [sleep: 5.0]
      left
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 5.0]
      halfway
      [sleep: 5.0]
      right
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 5.0]
      halfway
      [sleep: 5.0]
      left
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 5.0]
      halfway
      [sleep: 5.0]
      right
      [sound: /System/Library/Sounds/Glass.aiff]
      [sleep: 5.0]
      halfway
      [sleep: 5.0]
    OUTPUT

    expect(speaker.to_s).to eq(expected_output)
  end
end
