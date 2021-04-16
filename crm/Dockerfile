#Stage 1 - Install dependencies and build the app
FROM cirrusci/flutter:beta AS build-env

# Copy files to container and build
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter build web --no-sound-null-safety --web-renderer canvaskit

# Stage 2 - Create the run-time image
FROM nginx
COPY --from=build-env /app/build/web /usr/share/nginx/html