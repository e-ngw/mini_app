FROM ruby:3.2.2

ENV TZ=Asia/Tokyo
ENV LANG=ja_JP.UTF-8
ENV LC_ALL=C.UTF-8
ENV EDITOR=vim

RUN apt-get update && apt-get install -y postgresql-client vim build-essential

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install --jobs=4 --retry=3

COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
