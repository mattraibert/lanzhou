require_relative '../lib/exercise_runner'

RSpec.describe ExerciseRunner do
  let(:exercise) { "Shoulder Stretch" }
  let(:exercise_index) { 0 }
  let(:total_exercises) { 3 }
  let(:runner) { described_class.new(exercise, exercise_index, total_exercises) }

  before do
    # Mock all system calls
    allow(runner).to receive(:`).and_return(nil)
    allow(runner).to receive(:sleep)
    allow(runner).to receive(:puts)
  end

  describe '#determine_side_and_rep' do
    it 'returns right side for rounds 1-3' do
      expect(runner.send(:determine_side_and_rep, 1)).to eq(["right side", 1])
      expect(runner.send(:determine_side_and_rep, 2)).to eq(["right side", 2])
      expect(runner.send(:determine_side_and_rep, 3)).to eq(["right side", 3])
    end

    it 'returns left side for rounds 4-6' do
      expect(runner.send(:determine_side_and_rep, 4)).to eq(["left side", 1])
      expect(runner.send(:determine_side_and_rep, 5)).to eq(["left side", 2])
      expect(runner.send(:determine_side_and_rep, 6)).to eq(["left side", 3])
    end
  end

  describe '#number_to_ordinal' do
    it 'converts numbers to ordinal words' do
      expect(runner.send(:number_to_ordinal, 1)).to eq("first")
      expect(runner.send(:number_to_ordinal, 2)).to eq("second")
      expect(runner.send(:number_to_ordinal, 3)).to eq("third")
    end
  end

  describe '#announce_completion' do
    context 'when round 3' do
      it 'announces switch' do
        expect(runner).to receive(:`).with('say "switch"')
        runner.send(:announce_completion, 3)
      end
    end

    context 'when round 6 on last exercise' do
      let(:exercise_index) { 2 }

      it 'announces workout complete' do
        expect(runner).to receive(:`).with('say "workout complete"')
        runner.send(:announce_completion, 6)
      end
    end

    context 'when round 6 on non-last exercise' do
      it 'announces next exercise' do
        expect(runner).to receive(:`).with('say "next exercise"')
        runner.send(:announce_completion, 6)
      end
    end

    context 'when other rounds' do
      it 'announces rest' do
        expect(runner).to receive(:`).with('say "rest"')
        allow(runner).to receive(:announce_remaining_reps)
        runner.send(:announce_completion, 1)
      end
    end
  end

  describe '#announce_remaining_reps' do
    it 'announces two left for rounds 1 and 4' do
      expect(runner).to receive(:`).with('say "two left"')
      runner.send(:announce_remaining_reps, 1)

      expect(runner).to receive(:`).with('say "two left"')
      runner.send(:announce_remaining_reps, 4)
    end

    it 'announces one left for rounds 2 and 5' do
      expect(runner).to receive(:`).with('say "one left"')
      runner.send(:announce_remaining_reps, 2)

      expect(runner).to receive(:`).with('say "one left"')
      runner.send(:announce_remaining_reps, 5)
    end

    it 'announces nothing for rounds 3 and 6' do
      expect(runner).not_to receive(:`)
      runner.send(:announce_remaining_reps, 3)
      runner.send(:announce_remaining_reps, 6)
    end
  end

  describe '#rest_unless_final_round' do
    context 'on final round of last exercise' do
      let(:exercise_index) { 2 }

      it 'does not sleep' do
        expect(runner).not_to receive(:sleep)
        runner.send(:rest_unless_final_round, 6)
      end
    end

    context 'on any other round' do
      it 'sleeps for REST_DURATION' do
        expect(runner).to receive(:sleep).with(REST_DURATION)
        runner.send(:rest_unless_final_round, 1)
      end
    end
  end

  describe '#perform_stretch' do
    it 'plays start sound and announces intervals' do
      expect(runner).to receive(:`).with('say "start [[slnc 500]]"')
      expect(runner).to receive(:`).with('afplay /System/Library/Sounds/Glass.aiff')
      expect(runner).to receive(:`).with('say "10 seconds"')
      expect(runner).to receive(:`).with('say "20 seconds"')
      expect(runner).to receive(:`).with('say "25 seconds"')

      runner.send(:perform_stretch)
    end

    it 'sleeps for correct durations' do
      expect(runner).to receive(:sleep).with(10)  # 0 to 10
      expect(runner).to receive(:sleep).with(10)  # 10 to 20
      expect(runner).to receive(:sleep).with(5)   # 20 to 25
      expect(runner).to receive(:sleep).with(5)   # 25 to 30

      runner.send(:perform_stretch)
    end
  end

  describe '#perform' do
    it 'runs all 6 rounds for the exercise' do
      expect(runner).to receive(:announce_and_countdown).exactly(6).times
      expect(runner).to receive(:perform_stretch).exactly(6).times
      expect(runner).to receive(:announce_completion).exactly(6).times
      expect(runner).to receive(:rest_unless_final_round).exactly(6).times

      runner.perform
    end
  end
end