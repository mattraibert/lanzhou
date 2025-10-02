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

    expected_output = <<~OUTPUT.strip
      sun salutation rep 1
      inhale up
      [sleep: 4]
      exhale fold
      [sleep: 4]
      inhale up
      [sleep: 4]
      exhale back
      [sleep: 4]
      inhale up
      [sleep: 4]
      exhale back
      [sleep: 4]
      breathe
      [sleep: 4]
      1
      [sleep: 4]
      2
      [sleep: 4]
      3
      [sleep: 4]
      4
      [sleep: 4]
      5
      [sleep: 4]
      inhale forward
      [sleep: 4]
      exhale down
      [sleep: 4]
      inhale up
      [sleep: 4]
      exhale hands down
      [sleep: 4]
      sun salutation rep 2
      inhale up
      [sleep: 4]
      exhale fold
      [sleep: 4]
      inhale up
      [sleep: 4]
      exhale back
      [sleep: 4]
      inhale up
      [sleep: 4]
      exhale back
      [sleep: 4]
      breathe
      [sleep: 4]
      1
      [sleep: 4]
      2
      [sleep: 4]
      3
      [sleep: 4]
      4
      [sleep: 4]
      5
      [sleep: 4]
      inhale forward
      [sleep: 4]
      exhale down
      [sleep: 4]
      inhale up
      [sleep: 4]
      exhale hands down
      [sleep: 4]
    OUTPUT

    expect(speaker.to_s).to eq(expected_output)
  end
end
