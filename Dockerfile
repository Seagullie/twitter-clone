# Use official Ruby image
FROM ruby:2.7.6

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs npm yarn postgresql-client

# Set working directory
WORKDIR /app

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application files
COPY . .

# Expose port (default for Rails)
EXPOSE 9998

# Start Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]