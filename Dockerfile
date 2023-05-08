FROM ubuntu:latest

# Instalar paquetes
RUN apt-get update && \
    apt-get install -y nginx \
                       bind9 \
                       openssl \
                       vsftpd \
                       openssh-server \
                       postfix \
                       supervisor \
                       mysql-server \
                       php \
                       php-mysql \
                       php-fpm \
                       php-mbstring \
                       php-xml \
                       php-gd \
                       php-zip \
                       php-curl \
                       php-json \
                       phpmyadmin

# Configuración DNS
COPY named.conf.local /etc/bind/
COPY db.example.com /etc/bind/

# Configuración HTTPS y TLS
RUN openssl req -x509 -newkey rsa:4096 -keyout /etc/nginx/cert.key -out /etc/nginx/cert.crt -days 365 -nodes -subj "/CN=localhost"
COPY nginx.conf /etc/nginx/

# Configuración FTP
RUN mkdir /ftp
RUN chown nobody:nogroup /ftp
COPY vsftpd.conf /etc/

# Configuración SSH
RUN mkdir /var/run/sshd
COPY sshd_config /etc/ssh/
RUN useradd -m user
RUN echo 'user:password' | chpasswd

# Configuración de correo
RUN postconf -e 'mydestination = localhost.localdomain, localhost'
RUN postconf -e 'mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128'
RUN postconf -e 'smtpd_banner = $myhostname ESMTP $mail_name (Ubuntu)'

# Configuración de supervisord
COPY supervisord.conf /etc/supervisord/conf.d

# Configuración de phpMyAdmin
COPY config.inc.php /etc/phpmyadmin/

# Configuración de la base de datos
RUN service mysql start && \
    mysql -u root -e "CREATE DATABASE wordpress;" && \
    mysql -u root -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'wppass';" && \
    mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';" && \
    mysql -u root -e "FLUSH PRIVILEGES;"

# Copiar los archivos de configuración
COPY wp-config.php /var/www/html/
COPY index.php /var/www/html/

# Exponer los puertos
EXPOSE 53 80 443 21 22 25 3306 9000

# Comando de inicio
CMD ["/usr/bin/supervisord"]
