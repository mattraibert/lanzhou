#!/usr/bin/env ruby
require 'csv'
require_relative 'lib/exercise_runner'

# PT Workout Timer Script
# Usage: chmod +x pt_timer.rb && ./pt_timer.rb

# Prevent computer from sleeping during workout
caffeinate_pid = spawn('caffeinate', '-d')

# Ensure caffeinate is killed when script exits
at_exit { Process.kill('TERM', caffeinate_pid) rescue nil }

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

def parse_duration(duration_str)
  return 0 if duration_str.nil? || duration_str.strip.empty?
  duration_str.to_i
end

total_rounds = exercises.length * ROUNDS_PER_EXERCISE

round = 0
exercises.each_with_index do |exercise, exercise_index|
  round += exercise_index * ROUNDS_PER_EXERCISE
  ExerciseRunner.new(exercise, exercise_index, exercises.length).perform
end

puts "Workout finished!"