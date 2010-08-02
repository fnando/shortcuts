load "deploy" if respond_to?(:namespace) # cap2 differentiator

default_run_options[:pty] = true

set :user, "fnando"
set :domain, "simplesideias.com.br"
set :application, "shortcuts"

set :repository,  "git://github.com/fnando/shortcuts.git"
set :deploy_to, "/home/#{user}/#{application}.#{domain}"
set :deploy_via, :remote_cache
set :scm, "git"
set :branch, "master"
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false
set :keep_releases, 2

server domain, :app, :web
server domain, :db, :primary => true

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
