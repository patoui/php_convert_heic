FROM php:8.1

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
	autoconf \
	libtool \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    vim \
    unzip \
    git \
    curl

# Pull down related libs libde265, heif, ImageMagick, PHP's imagick extension
RUN cd /tmp && \
    git clone https://github.com/strukturag/libde265 && \
    git clone https://github.com/strukturag/libheif && \
	git clone https://github.com/ImageMagick/ImageMagick.git ImageMagick-7.1 && \
	curl -O http://pecl.php.net/get/imagick-3.7.0.tgz

# Install libde265
RUN cd /tmp/libde265 && \
    ./autogen.sh && \
    ./configure && \
    make -j$(nproc) && \
    make install

# Install libheif
RUN cd /tmp/libheif && \
    ./autogen.sh && \
    ./configure && \
    make -j$(nproc) && \
    make install

# Install ImageMagick
RUN cd /tmp/ImageMagick-7.1 && \
    ./configure --with-heic=yes && \
    make -j$(nproc) && \
    make install && \
	ldconfig

# Install PHP imagick extension
RUN	cd /tmp/ && \
	tar -xvzf imagick-3.7.0.tgz && \
    cd imagick-3.7.0 && \
    phpize && \
    ./configure && \
    make -j$(nproc) && \
    make install

# Install extensions
RUN docker-php-ext-enable imagick 

# Copy existing application directory contents
COPY . /www/var

