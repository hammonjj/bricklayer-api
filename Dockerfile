# Step 1: Build stage using the Dart SDK
FROM dart:stable AS build
WORKDIR /app

# Copy the Dart dependencies and install them
COPY pubspec.* ./
RUN dart pub get

# Copy all source files, including .env if present in the same directory
COPY . .

# Activate dart_frog_cli and create a production build
RUN dart pub global activate dart_frog_cli
RUN dart pub global run dart_frog_cli:dart_frog build

# Run `dart pub get` offline to confirm dependencies are up-to-date
RUN dart pub get --offline

# Compile the server with Ahead-Of-Time (AOT) compilation for efficient serving
RUN dart compile exe build/bin/server.dart -o build/bin/server

# Step 2: Use a minimal base image (Debian) instead of scratch
FROM debian:buster-slim

# Set working directory and copy necessary files
WORKDIR /app

# Copy runtime libraries, the server binary, and .env file from the build stage
COPY --from=build /runtime/ /
COPY --from=build /app/build/bin/server /app/bin/

# Install minimal dependencies if needed (e.g., bash for debugging)
RUN apt-get update && apt-get install -y bash && rm -rf /var/lib/apt/lists/*

# Expose the port your server listens on, e.g., 8080
EXPOSE 8080

# Start the server binary
CMD ["/app/bin/server"]
