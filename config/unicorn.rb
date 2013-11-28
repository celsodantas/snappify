worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true
listen ENV['PORT'], :backlog => Integer(ENV['UNICORN_BACKLOG'] || 16)

before_fork do |server, worker|

  Signal.trap 'TERM' do
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end