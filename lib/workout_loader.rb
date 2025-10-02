require 'csv'

class WorkoutLoader
  def self.load_exercises(csv_path = 'exercises.csv')
    CSV.read(csv_path, headers: true).map do |row|
      {
        name: row['exercise_name'],
        sets: row['sets'].to_i,
        reps: row['reps'].to_i,
        duration: parse_duration(row['duration']),
        rest: parse_duration(row['rest']),
        pattern: row['pattern']
      }
    end
  end

  private

  def self.parse_duration(duration_str)
    return 0 if duration_str.nil? || duration_str.strip.empty?
    duration_str.to_i
  end
end
