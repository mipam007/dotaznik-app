FROM docker-registry-default.rocp.vs.csint.cz/rhscl/centos

MAINTAINER Jindřich Káňa <jindrich.kana@gmail.com>
LABEL Vendor="ELOS Technologies, s.r.o."

RUN     yum -y --setopt=tsflags=nodocs update \
        && yum --setopt=tsflags=nodocs -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
        && yum --setopt=tsflags=nodocs -y install \
        gcc \
        gcc-c++ \
        httpd \
        mod_ssl \
        php \
        php-cli \
        php-devel \
        php-mysql \
        php-pdo \
        php-mbstring \
        php-soap \
        php-gd \
        php-xml \
        php-pecl-apcu \
        libXrender fontconfig libXext urw-fonts \
        && yum clean all \
        && rm -rf /var/cache/yum

ADD https://raw.githubusercontent.com/mipam007/dotaznik-app/master/reviews.html /usr/local/html
ADD https://raw.githubusercontent.com/mipam007/dotaznik-app/master/addreview.php /usr/local/html

RUN find /var/www/html/ -type d -exec chmod 755 {} \; \
    && find /var/www/html/ -type f -exec chmod 644 {} \; \
    && sed -i 's/8080/80/g' /etc/httpd/conf/httpd.conf \
    && echo 'extension=mysqli' >> /etc/php.ini \
    && chown -R apache: /run/httpd

EXPOSE 8080

USER apache

ENTRYPOINT ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
