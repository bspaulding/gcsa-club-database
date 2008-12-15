set :application, "gcsa-club-database"
set :domain,      "172.16.17.58"

# github specific config
default_run_options[:pty] = true
set :repository,  "git@github.com:bspaulding/#{application}.git"
set :scm,         "git"
set :scm_passphrase, "rail5"
set :branch, "master"
set :deploy_via, :remote_cache

set :user, "rails"
set :use_sudo,    false
set :deploy_to,   "/railsapps/#{application}"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end