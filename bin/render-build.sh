set -o errexit

bundle install
bundle exec rails assets:precompile
# bundle exec rails assets:clean
# bundle exec rails db:migrate #DB移行のため一時的に無効化