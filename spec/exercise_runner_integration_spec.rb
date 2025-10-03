require_relative '../lib/exercise_runner'
require_relative 'support/text_printing_speaker'

RSpec.describe ExerciseRunner do
  it 'announces exercise, counts down, delegates to pattern, and announces completion' do
    speaker = TextPrintingSpeaker.new
    exercise = {
      name: "test exercise",
      sets: 3,
      reps: 1,
      duration: 30,
      rest: 5,
      pattern: "right then left"
    }

    runner = ExerciseRunner.new(exercise, 0, 2, speaker: speaker)

    # Mock the pattern
    mock_pattern = double("pattern")
    expect(mock_pattern).to receive(:perform)
    allow(runner).to receive(:create_pattern).and_return(mock_pattern)

    # Suppress puts output
    allow(runner).to receive(:puts)

    runner.perform

    expected_output = <<~OUTPUT.strip
      test exercise
      [sound: /System/Library/Sounds/Basso.aiff]
      [sound: /System/Library/Sounds/Basso.aiff]
      [sound: /System/Library/Sounds/Basso.aiff]
      [sound: /System/Library/Sounds/Basso.aiff]
      next exercise
    OUTPUT

    expect(speaker.to_s).to eq(expected_output)
  end

  it 'announces "workout complete" on the last exercise' do
    speaker = TextPrintingSpeaker.new
    exercise = {
      name: "final exercise",
      sets: 1,
      reps: 1,
      duration: 10,
      rest: 5,
      pattern: "bilateral"
    }

    runner = ExerciseRunner.new(exercise, 1, 2, speaker: speaker)

    # Mock the pattern
    mock_pattern = double("pattern")
    expect(mock_pattern).to receive(:perform)
    allow(runner).to receive(:create_pattern).and_return(mock_pattern)

    # Suppress puts output
    allow(runner).to receive(:puts)

    runner.perform

    expected_output = <<~OUTPUT.strip
      final exercise
      [sound: /System/Library/Sounds/Basso.aiff]
      [sound: /System/Library/Sounds/Basso.aiff]
      [sound: /System/Library/Sounds/Basso.aiff]
      [sound: /System/Library/Sounds/Basso.aiff]
      workout complete
    OUTPUT

    expect(speaker.to_s).to eq(expected_output)
  end

  describe '#create_pattern' do
    let(:speaker) { TextPrintingSpeaker.new }
    let(:runner) { ExerciseRunner.new(exercise, 0, 1, speaker: speaker) }

    context 'with "right then left" pattern' do
      let(:exercise) { { name: "test", sets: 1, reps: 1, duration: 10, rest: 5, pattern: "right then left" } }

      it 'creates a RightThenLeft pattern' do
        pattern = runner.send(:create_pattern)
        expect(pattern).to be_a(RightThenLeft)
      end
    end

    context 'with "alternating reps" pattern' do
      let(:exercise) { { name: "test", sets: 1, reps: 1, duration: 10, rest: 5, pattern: "alternating reps" } }

      it 'creates an AlternatingReps pattern' do
        pattern = runner.send(:create_pattern)
        expect(pattern).to be_a(AlternatingReps)
      end
    end

    context 'with "bilateral" pattern' do
      let(:exercise) { { name: "test", sets: 1, reps: 1, duration: 10, rest: 5, pattern: "bilateral" } }

      it 'creates a Bilateral pattern' do
        pattern = runner.send(:create_pattern)
        expect(pattern).to be_a(Bilateral)
      end
    end

    context 'with "warm-up flow" pattern' do
      let(:exercise) { { name: "test", sets: 1, reps: 1, duration: 10, rest: 5, pattern: "warm-up flow" } }

      it 'creates a WarmUpFlow pattern' do
        pattern = runner.send(:create_pattern)
        expect(pattern).to be_a(WarmUpFlow)
      end
    end

    context 'with unknown pattern' do
      let(:exercise) { { name: "test", sets: 1, reps: 1, duration: 10, rest: 5, pattern: "unknown" } }

      it 'raises an error' do
        expect { runner.send(:create_pattern) }.to raise_error("Unknown pattern: unknown")
      end
    end
  end
end
