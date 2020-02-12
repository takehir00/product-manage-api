# config valid for current version and patch releases of Capistrano
lock "~> 3.11.1"

set :application, "okuyamaproductapi"
set :repo_url, "git@bitbucket.org:teamlabengineering/okuyama_itemapi.git"

set :branch, ENV['BRANCH'] || "master"

# デプロイ先のディレクトリ
set :deploy_to, "~/okuyamaproductapi"

# 本番サーバー上で実行するコマンドを定義する
task :uptime do
    on "ec2-3-115-73-2.ap-northeast-1.compute.amazonaws.com" do
        execute "nohup target/universal/stage/bin/okuyamaproductapi -Dplay.http.secret.key=abcdefghijk -Dconfig.file=$(pwd)/conf/prod.conf &"
    end
end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
