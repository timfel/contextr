require "thread"
module MutexCode #:nodoc:
  unless defined? Mutex
    class Mutex
      def synchronize
        yield
      end

      def locked?
        false
      end
    end
  end

  def semaphore
    @semaphore ||= Mutex.new
  end

  def synchronized
    semaphore.synchronize do
      yield
    end
  end

  def is_blocked?
    semaphore.locked?
  end

  def only_once
    synchronized do
      yield
    end unless is_blocked?
  end
end
