# RVM bootstrap
$:.unshift(File.expand_path("~/.rvm/lib"))

set :application, "quiz"
set :repository,  "git@github.com:EnOD/quiz.git"

set :rvm_ruby_string, 'ruby-1.9.2@quiz'   
set :rvm_type, :user
require "rvm/capistrano" 

set :scm, :git
set :branch, "master"

set :git_shallow_clone, 1
set :deploy_via, :checkout
set :deploy_to, "~/web/quiz"

default_run_options[:pty] = true

set :user, "enod"
set :use_sudo, false

server "guki.org", :app, :web, :db, :primary => true


after "deploy:update", 'deploy:symlink'
after "deploy:symlink", 'deploy:cleanup'
# after "deploy:bundle", 'deploy:whenever'
after "deploy", "deploy:bundle"


namespace :deploy do
  task :symlink do
    run "rm -Rf #{release_path}/log"
    run "rm -Rf #{release_path}/public/remote"
    run "rm -Rf #{release_path}/public/assets"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"

    run "ln -nfs #{shared_path}/log #{release_path}/log"
    run "ln -nfs #{shared_path}/sockets #{release_path}/tmp/sockets"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  task :bundle do
    run "cd #{release_path} && bundle install"
  end

  task :assets do
    # mv assets/* /home/user/apps/demoform/shared/assets/
    #run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"

    #run "cd #{deploy_to}/current && bundle exec rake assets:clean"
    # run "cd #{deploy_to}/current && bundle exec rake assets:clean"
    # run "cd #{deploy_to}/current && bundle exec rake assets:precompile"

    # run "rm -Rf #{shared_path}/assets/*"
    # run "mv #{deploy_to}/current/public/assets/* #{shared_path}/assets/"
    # run "rm -Rf #{deploy_to}/current/public/assets"
    # run "ln -nfs #{shared_path}/assets #{deploy_to}/current/public/assets"
  end
end