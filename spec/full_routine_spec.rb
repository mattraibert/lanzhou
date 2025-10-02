require_relative '../lib/exercise_runner'
require_relative '../lib/workout_loader'
require_relative 'support/text_printing_speaker'

RSpec.describe 'Full workout routine' do
  it 'runs the complete routine from exercises.csv' do
    speaker = TextPrintingSpeaker.new

    # Read exercises from CSV
    exercises = WorkoutLoader.load_exercises

    # Run each exercise
    exercises.each_with_index do |exercise, exercise_index|
      runner = ExerciseRunner.new(exercise, exercise_index, exercises.length, speaker: speaker)
      allow(runner).to receive(:puts) # Suppress puts output
      runner.perform
    end

    # Get the full output
    output = speaker.to_s

    # Write the output to a file for inspection
    File.write('spec/fixtures/full_routine_output.txt', output)

    # Print the full routine
    puts "\n" + "="*80
    puts "FULL WORKOUT ROUTINE OUTPUT"
    puts "="*80
    puts output
    puts "="*80
    puts "\n✓ Full routine completed successfully!"
    puts "  Total exercises: #{exercises.length}"
    puts "  Total output lines: #{output.lines.count}"
    puts "  Output saved to: spec/fixtures/full_routine_output.txt"

    # Verify the output contains expected elements
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

    # Check for alternating reps pattern (now simplified)
    expect(output).to include("right")
    expect(output).to include("left")
    expect(output).to include("halfway")

    # Check for bilateral pattern
    expect(output).to include("rep 1 set 1")

    # Check completion
    expect(output).to include("workout complete")
  end
end
