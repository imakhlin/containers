FROM mariadb:10.4

MAINTAINER Igor Makhlin <igorm@iguazio.com>

ARG UNAME=iguazio
ARG UID=1000
ARG GID=1000

ARG MYSQL_UNAME=mysql
ARG MYSQL_UID=2002
ARG MYSQL_GID=2002

# Update mysql UID
RUN usermod -u $MYSQL_UID $MYSQL_UNAME
# Update mysql GID
RUN groupmod -g $MYSQL_GID $MYSQL_UNAME

# Create iguazio user/group
RUN groupadd -g $GID $UNAME; \
    useradd -m -u $UID -g $UNAME -d /home/$UNAME -s /bin/bash $UNAME; \
    chown -R $UID:$GID /home/$UNAME

USER $MYSQL_UNAME

#CMD ["you can overwrite command here if needed"]
