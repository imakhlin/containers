FROM bde2020/hive

MAINTAINER Igor Makhlin <igorm@iguazio.com>

ARG UNAME=iguazio
ARG UID=1000
ARG GID=1000

ARG HIVE_UNAME=hive
ARG HIVE_UID=2003
ARG HIVE_GID=2003

# Add hive group&user
RUN groupadd -g $HIVE_GID $HIVE_UNAME; \
    useradd -m -u $HIVE_UID -g $HIVE_UNAME -d /home/$HIVE_UNAME -s /bin/bash $HIVE_UNAME; \
    chown -R $HIVE_UID:$HIVE_GID /home/$HIVE_UNAME

# Create iguazio user/group
RUN groupadd -g $GID $UNAME; \
    useradd -m -u $UID -g $UNAME -d /home/$UNAME -s /bin/bash $UNAME; \
    chown -R $UID:$GID /home/$UNAME

USER $HIVE_UNAME

#CMD ["you can overwrite command here if needed"]
