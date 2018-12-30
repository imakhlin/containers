FROM mariadb:10.4

MAINTAINER Igor Makhlin <igorm@iguazio.com>

ARG UNAME=iguazio
ARG UID=1000
ARG GID=1000

ARG MYSQL_UNAME=mysql
ARG MYSQL_UID=2002
ARG MYSQL_GID=2002

# Update postgres UID
RUN usermod -u $MYSQL_UID $MYSQL_UNAME
# Update postgres GID
RUN groupmod -g $MYSQL_GID $MYSQL_UNAME

# Create iguazio user/group
RUN groupadd -g $GID $UNAME; \
    useradd -m -u $UID -g $UNAME -d /home/$UNAME -s /bin/bash $UNAME; \
    chown -R $UID:$GID /home/$UNAME

#RUN chown -R $MYSQL_UNAME:$MYSQL_UNAME /var/lib/mysql

#COPY /init_script.sh /usr/lib/mysql/10/bin/init_script.sh
#RUN chmod +x /usr/lib/mysql/10/bin/init_script.sh

USER $MYSQL_UNAME

#CMD ["/usr/lib/postgresql/11/bin/init_script.sh"]
