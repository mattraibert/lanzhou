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

    output = speaker.to_s
    File.write('spec/fixtures/alternating_reps_output.txt', output)

    expected_output = File.read('spec/fixtures/alternating_reps_expected.txt').strip

    expect(output).to eq(expected_output)
  end
end
