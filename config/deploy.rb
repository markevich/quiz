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
after "deploy:bundle", "apache:restart"


namespace :deploy do
  task :symlink do
    run "ln -nfs #{shared_path}/log #{release_path}/log"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  task :bundle do
    run "cd #{release_path} && bundle install"
    run "cd #{release_path} && bundle exec rake db:migrate"
  end

end
namespace :apache do
  [:stop, :start, :restart, :reload].each do |action|
    desc "#{action.to_s.capitalize} Apache"
    task action, :roles => :web do
      invoke_command "/etc/init.d/apache2 #{action.to_s}", :via => run_method
    end
  end
end