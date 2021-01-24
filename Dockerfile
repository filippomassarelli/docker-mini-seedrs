FROM ruby:2.5.7

RUN apt-get update -qq && apt-get install -y postgresql-client
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# ENTRYPOINT ["./entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]


# So we start from Ruby 2.7 pre-built image and then install PostgreSQL client into the system, this is a Debian based system so we use apt-get. 
# Next, we freeze the bundle config which will actually help us maintain consistency over the dockerized system and host system. 
# If Gemfile was modified but we did not run bundle install, this is where it will throw an error

# Now we set our working directory inside the docker system to be /app. 
# We copy over the Gemfile and Gemfile.lock over to the docker's app directory and run bundle install inside docker. 
# After bundle install finishes we copy over all the files from our host system to the docker system.

# After that, we execute a shell script which we will come back shortly and then we expose port 3000 and start the rails server binding it to 0.0.0.0.