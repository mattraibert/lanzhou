require 'io/console'

class SkipExercise < StandardError; end

module SkipHandler
  @listener_thread = nil

  def self.start_listening(main_thread)
    @listener_thread = Thread.new do
      loop do
        char = STDIN.getch rescue nil
        if char == 's' || char == 'S'
          puts "\n⏭  Skipping exercise..."
          main_thread.raise(SkipExercise)
          break
        end
      end
    end
  end

  def self.stop_listening
    @listener_thread&.kill
    @listener_thread = nil
  end
end
