FROM docker-registry-default.rocp.vs.csint.cz/rhscl/centos

## OpenShift hack ##
# oc create serviceaccount sa-apache
# oc edit scc anyuid
# - system:serviceaccount:<project_name>:sa-apache
# oc edit dc/<dc_name>
# serviceAccount: sa-apache
# serviceAccountName: sa-apache

LABEL Maintainer="Jindřich Káňa <jindrich.kana@gmail.com>"
LABEL Vendor="ELOS Technologies, s.r.o."

RUN     yum -y --setopt=tsflags=nodocs update \
        && yum --setopt=tsflags=nodocs -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
        && yum --setopt=tsflags=nodocs -y install \
        gcc \
        gcc-c++ \
        httpd \
        mod_ssl \
	mariadb \
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

ADD https://raw.githubusercontent.com/mipam007/dotaznik-app/master/reviews.html /var/www/html
ADD https://raw.githubusercontent.com/mipam007/dotaznik-app/master/addreview.php /var/www/html
ADD https://raw.githubusercontent.com/mipam007/dotaznik-app/master/info.php /var/www/html

RUN find /var/www/html/ -type d -exec chmod 755 {} \; \
    && find /var/www/html/ -type f -exec chmod 644 {} \; \
    && sed -i 's/80/8080/g' /etc/httpd/conf/httpd.conf \
    && sed -i 'DirectoryIndex index.html/DirectoryIndex index.html index.php/g' \
    && echo "ServerName $(hostname -f)" >> /etc/httpd/conf/httpd.conf \
    && echo 'extension=mysqli.so' >> /etc/php.ini \
    && rm -rf /etc/httpd/conf.d/* \
    && chown -R apache: /var/log/httpd /run/httpd \
    && ln -sf /dev/stdout /var/log/httpd/access_log \
    && ln -sf /dev/stderr /var/log/httpd/error_log 

EXPOSE 8080

USER apache

CMD ["/usr/sbin/httpd",  "-D", "FOREGROUND"]
