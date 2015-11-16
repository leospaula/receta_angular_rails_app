
# If you have a very small app you may be able to
# increase this, but in general 3 workers seems to
# work best
#worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
worker_processes 3

# Immediately restart any workers that
# haven't responded within 15 seconds
timeout 20

# Load your app into the master before forking
# workers for super-fast worker spawn times
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end