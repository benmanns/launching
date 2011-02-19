path = File.expand_path(File.dirname(__FILE__))

worker_processes 16
working_directory path

preload_app true

timeout 30

listen File.join(path, 'tmp', 'sockets', 'unicorn.sock')

pid File.join(path, 'tmp', 'pids', 'unicorn.pid')

stderr_path File.join(path, 'log', 'unicorn.stderr.log')
stdout_path File.join(path, 'log' ,'unicorn.stdout.log')

