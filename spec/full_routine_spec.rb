require 'csv'
require_relative '../lib/exercise_runner'
require_relative 'support/text_printing_speaker'

RSpec.describe 'Full workout routine' do
  it 'runs the complete routine from exercises.csv' do
    speaker = TextPrintingSpeaker.new

    def parse_duration(duration_str)
      return 0 if duration_str.nil? || duration_str.strip.empty?
      duration_str.to_i
    end

    # Read exercises from CSV
    exercises = CSV.read('exercises.csv', headers: true).map do |row|
      {
        name: row['exercise_name'],
        sets: row['sets'].to_i,
        reps: row['reps'].to_i,
        duration: parse_duration(row['duration']),
        rest: parse_duration(row['rest']),
        pattern: row['pattern']
      }
    end

    # Run each exercise
    exercises.each_with_index do |exercise, exercise_index|
      runner = ExerciseRunner.new(exercise, exercise_index, exercises.length, speaker: speaker)
      allow(runner).to receive(:puts) # Suppress puts output
      runner.perform
    end

    # Verify the output contains expected elements
    output = speaker.to_s

    # Check for each exercise name
    expect(output).to include("sun salutation rep 1")
    expect(output).to include("kneeling windmill stretch")
    expect(output).to include("strap hamstring stretch")
    expect(output).to include("active pigeon pose")
    expect(output).to include("passive pigeon pose")
    expect(output).to include("pigeon prep")
    expect(output).to include("blocked flexed dead bug")
    expect(output).to include("bridge")

    # Check for warm-up flow cues
    expect(output).to include("inhale up")
    expect(output).to include("exhale fold")
    expect(output).to include("breathe")

    # Check for right then left pattern
    expect(output).to include("right side first rep")
    expect(output).to include("left side first rep")
    expect(output).to include("switch")

    # Check for alternating reps pattern
    expect(output).to include("right rep 1 set 1")
    expect(output).to include("left rep 2 set 1")

    # Check for bilateral pattern
    expect(output).to include("rep 1 set 1")

    # Check completion
    expect(output).to include("workout complete")

    # Verify structure - should have 9 exercises (one per line in CSV)
    exercise_announcements = output.scan(/^(sun salutation|kneeling windmill stretch|strap hamstring stretch|active pigeon pose|passive pigeon pose|pigeon prep|blocked flexed dead bug|bridge)/).length
    expect(exercise_announcements).to be >= 9

    puts "\n✓ Full routine completed successfully!"
    puts "  Total exercises: #{exercises.length}"
    puts "  Total output lines: #{output.lines.count}"
  end
end
