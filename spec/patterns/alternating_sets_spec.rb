require_relative '../../lib/patterns/alternating_sets'
require_relative '../support/text_printing_speaker'

RSpec.describe AlternatingSets do
  it 'performs full sets alternating between sides' do
    speaker = TextPrintingSpeaker.new
    exercise = {
      name: "banded clamshell",
      sets: 3,
      reps: 10,
      duration: 10,
      rest: 20
    }

    pattern = AlternatingSets.new(exercise, speaker)
    pattern.perform

    output = speaker.to_s
    File.write('spec/fixtures/alternating_sets_output.txt', output)

    expected_output = File.read('spec/fixtures/alternating_sets_expected.txt').strip

    expect(output).to eq(expected_output)
  end
end