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
exercises = CSV.read('exercises.csv', headers: true).map { |row| row['exercise_name'] }
total_rounds = exercises.length * ROUNDS_PER_EXERCISE

round = 0
exercises.each_with_index do |exercise, exercise_index|
  round += exercise_index * ROUNDS_PER_EXERCISE
  ExerciseRunner.new(exercise, exercise_index, exercises.length).perform
end

puts "Workout finished!"