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

exercise_durations = []
workout_start_time = Time.now

begin
  current_index = start_index

  while current_index < exercises.length
    begin
      exercise = exercises[current_index]
      exercise_start_time = Time.now
      ExerciseRunner.new(exercise, current_index, exercises.length).perform
      exercise_end_time = Time.now

      duration = exercise_end_time - exercise_start_time
      exercise_durations << { name: exercise[:name], duration: duration }
      puts "Duration: #{(duration / 60).floor}:#{(duration % 60).round.to_s.rjust(2, '0')}"

      current_index += 1  # Move to next exercise
    rescue PreviousExercise
      if current_index > 0
        current_index -= 1  # Go back to previous exercise
      else
        puts "\nAlready at first exercise!"
      end
    end
  end

  workout_end_time = Time.now
  total_duration = workout_end_time - workout_start_time

  puts "\n" + "="*50
  puts "Workout finished!"
  puts "="*50
  puts "\nExercise Durations:"
  exercise_durations.each_with_index do |entry, i|
    mins = (entry[:duration] / 60).floor
    secs = (entry[:duration] % 60).round
    puts "#{i + 1}. #{entry[:name]}: #{mins}:#{secs.to_s.rjust(2, '0')}"
  end
  puts "\nTotal Workout Time: #{(total_duration / 60).floor}:#{(total_duration % 60).round.to_s.rjust(2, '0')}"
  puts "="*50
rescue QuitWorkout
  puts "\nWorkout ended early."
  exit 0
end