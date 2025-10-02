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

    output = speaker.to_s
    File.write('spec/fixtures/bilateral_output.txt', output)

    expected_output = File.read('spec/fixtures/bilateral_expected.txt').strip

    expect(output).to eq(expected_output)
  end
end
