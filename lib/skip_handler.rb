require 'io/console'

class SkipExercise < StandardError; end
class QuitWorkout < StandardError; end
class RestartExercise < StandardError; end
class PreviousExercise < StandardError; end

module SkipHandler
  @listener_thread = nil
  @paused = false

  def self.start_listening(main_thread)
    @listener_thread = Thread.new do
      loop do
        char = STDIN.getch rescue nil

        case char
        when 's', 'S'
          puts "\n⏭  Skipping exercise..."
          main_thread.raise(SkipExercise)
          break
        when 'b', 'B'
          puts "\n⏮  Going back to previous exercise..."
          main_thread.raise(PreviousExercise)
          break
        when 'q', 'Q', "\u0003"  # 'q', 'Q', or Ctrl-C
          puts "\n🛑 Quitting workout..."
          main_thread.raise(QuitWorkout)
          break
        when 'r', 'R'
          puts "\n🔄 Restarting exercise..."
          main_thread.raise(RestartExercise)
          break
        when 'p', 'P'
          handle_pause
        end
      end
    end
  end

  def self.stop_listening
    @listener_thread&.kill
    @listener_thread = nil
    @paused = false
  end

  def self.handle_pause
    @paused = !@paused
    if @paused
      puts "\n⏸  Paused (press 'p' to resume)"
      sleep 0.1 until !@paused
    else
      puts "\n▶️  Resuming..."
    end
  end
end
