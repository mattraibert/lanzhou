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

    output = speaker.to_s
    File.write('spec/fixtures/right_then_left_output.txt', output)

    expected_output = File.read('spec/fixtures/right_then_left_expected.txt').strip

    expect(output).to eq(expected_output)
  end
end
