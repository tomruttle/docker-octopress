FROM ruby:1.9.3
MAINTAINER  Tom Ruttle <thruttle@gmail.com>

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get update && apt-get install -qy nodejs

# add the current blog source
ADD tomruttle.github.io /app
WORKDIR /app

# install octopress dependencies
RUN bundle install

# set up user so that host files have correct ownership
RUN addgroup --gid 1000 blog
RUN adduser --uid 1000 --gid 1000 blog
RUN chown -R blog.blog /app
USER blog

EXPOSE 4000

# base command
ENTRYPOINT ["rake"]

CMD ["preview"]
