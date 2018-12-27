FROM postgres:11.1

MAINTAINER Igor Makhlin <igorm@iguazio.com>

ARG UNAME=iguazio
ARG UID=1000
ARG GID=1000

ARG POSTGRES_UNAME=postgres
ARG POSTGRES_UID=2001
ARG POSTGRES_GID=2001

# Update postgres UID
RUN usermod -u $POSTGRES_UID $POSTGRES_UNAME
# Update postgres GID
RUN groupmod -g $POSTGRES_GID $POSTGRES_UNAME

# Create iguazio user/group
RUN groupadd -g $GID $UNAME; \
    useradd -m -u $UID -g $UNAME -d /home/$UNAME -s /bin/bash $UNAME; \
    chown -R $UID:$GID /home/$UNAME

#RUN mkdir -p /var/lib/postgresql/data
RUN chown -R $POSTGRES_UNAME:$POSTGRES_UNAME /var/lib/postgresql

#RUN set -x && mv /usr/lib/postgresql/11/bin/postgres /usr/lib/postgresql/11/bin/postgres.bin
COPY /init_script.sh /usr/lib/postgresql/11/bin/init_script.sh
RUN chmod +x /usr/lib/postgresql/11/bin/init_script.sh

USER $POSTGRES_UNAME

CMD ["/usr/lib/postgresql/11/bin/init_script.sh"]
