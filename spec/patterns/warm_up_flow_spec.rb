require_relative '../../lib/patterns/warm_up_flow'
require_relative '../support/text_printing_speaker'

RSpec.describe WarmUpFlow do
  it 'announces the complete warm-up flow sequence' do
    speaker = TextPrintingSpeaker.new
    exercise = {
      name: "sun salutation",
      sets: 2,
      reps: 1,
      duration: 4
    }

    flow = WarmUpFlow.new(exercise, speaker)
    flow.perform

    output = speaker.to_s
    File.write('spec/fixtures/warm_up_flow_output.txt', output)

    expected_output = File.read('spec/fixtures/warm_up_flow_expected.txt').strip

    expect(output).to eq(expected_output)
  end
end
