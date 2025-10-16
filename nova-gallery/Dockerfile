# STAGE 1: Builder
# This stage downloads the application source code.
FROM debian:bookworm-slim as builder

# Install necessary build tools
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Download and extract novagallery source
RUN curl -fsSL https://github.com/novafacile/novagallery/archive/refs/tags/v2.0.tar.gz -o novagallery.tar.gz \
    && tar -xzf novagallery.tar.gz --strip-components=1 \
    && rm novagallery.tar.gz

# STAGE 2: Final Image
# This stage builds the lean, production-ready image.
FROM php:8.2-apache

# Install the helper script for PHP extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Make the script executable
RUN chmod +x /usr/local/bin/install-php-extensions

# Install required PHP extensions (gd for images, exif for metadata)
# The script handles system dependencies automatically.
RUN install-php-extensions gd exif

# Enable Apache's rewrite module for clean URLs
RUN a2enmod rewrite

# Copy the application code from the builder stage
COPY --from=builder /app /var/www/html

# The 'storage' and 'galleries' directories will be managed by volumes.
# However, we need to ensure the storage directory exists and has the correct ownership
# for the case where a volume is not immediately mounted.
RUN mkdir -p /var/www/html/storage \
    && chown -R www-data:www-data /var/www/html/storage \
    && chmod -R 775 /var/www/html/storage

    