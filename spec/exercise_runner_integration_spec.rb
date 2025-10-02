require_relative '../lib/exercise_runner'
require_relative 'support/text_printing_speaker'

RSpec.describe ExerciseRunner do
  it 'announces exercise, counts down, runs pattern, and announces completion' do
    speaker = TextPrintingSpeaker.new
    exercise = {
      name: "kneeling windmill stretch",
      sets: 3,
      reps: 1,
      duration: 30,
      rest: 5,
      pattern: "right then left"
    }

    runner = ExerciseRunner.new(exercise, 0, 2, speaker: speaker)

    # Suppress puts output
    allow(runner).to receive(:puts)

    runner.perform

    expected_output = <<~OUTPUT.strip
      kneeling windmill stretch
      10
      [sleep: 0.5]
      9
      [sleep: 0.5]
      8
      [sleep: 0.5]
      7
      [sleep: 0.5]
      6
      [sleep: 0.5]
      5
      [sleep: 0.5]
      4
      [sleep: 0.5]
      3
      [sleep: 0.5]
      2
      [sleep: 0.5]
      1
      [sleep: 0.5]
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
      next exercise
    OUTPUT

    expect(speaker.to_s).to eq(expected_output)
  end
end
