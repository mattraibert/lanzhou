#!/usr/bin/env ruby

# PT Workout Timer Script
# Usage: chmod +x pt_timer.rb && ./pt_timer.rb

(1..6).each do |round|
  puts "Round #{round} of 6"

  # Determine side and rep number
  if round <= 3
    side = "right side"
    rep = round
  else
    side = "left side"
    rep = round - 3
  end

  # Convert rep number to ordinal
  rep_word = case rep
             when 1 then "first"
             when 2 then "second"
             when 3 then "third"
             end

  # Get ready countdown
  `say "#{side} #{rep_word} rep"`
  3.downto(1) do |count|
    `say "#{count}"`
    sleep 1
  end

  # Start with bell sound
  `say "start [[slnc 500]]"`
  `afplay /System/Library/Sounds/Glass.aiff`

  # 30 second stretch with notifications
  sleep 10
  `say "10 seconds"`
  sleep 10
  `say "20 seconds"`
  sleep 5
  `say "25 seconds"`
  sleep 5

  # Different messaging based on round
  if round == 3
    `say "switch"`
  elsif round == 6
    `say "workout complete"`
  else
    `say "rest"`

    # Add "X left" cueing for appropriate rounds
    if round == 1 || round == 4
      `say "two left"`
    elsif round == 2 || round == 5
      `say "one left"`
    end
  end

  # 5 second rest (except on final round)
  if round < 6
    sleep 5
  end
end

puts "Workout finished!"