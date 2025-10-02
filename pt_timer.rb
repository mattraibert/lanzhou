#!/usr/bin/env ruby
require_relative 'lib/exercise_runner'
require_relative 'lib/workout_loader'
require_relative 'lib/skip_handler'

# PT Workout Timer Script
# Usage: chmod +x pt_timer.rb && ./pt_timer.rb [start_index]
# Example: ./pt_timer.rb 3  (starts from 3rd exercise, 0-indexed)

# Prevent computer from sleeping during workout
caffeinate_pid = spawn('caffeinate', '-d')

# Ensure caffeinate is killed when script exits
at_exit { Process.kill('TERM', caffeinate_pid) rescue nil }

# Read exercises from CSV
exercises = WorkoutLoader.load_exercises

# Get starting index from command line argument (default to 0)
start_index = ARGV[0] ? ARGV[0].to_i : 0

# Validate start_index
if start_index < 0 || start_index >= exercises.length
  puts "Invalid start index. Must be between 0 and #{exercises.length - 1}"
  exit 1
end

puts "Starting from exercise #{start_index + 1}: #{exercises[start_index][:name]}\n\n" if start_index > 0

begin
  exercises[start_index..-1].each_with_index do |exercise, offset|
    exercise_index = start_index + offset
    ExerciseRunner.new(exercise, exercise_index, exercises.length).perform
  end

  puts "Workout finished!"
rescue QuitWorkout
  puts "\nWorkout ended early."
  exit 0
end