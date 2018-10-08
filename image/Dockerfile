FROM ubuntu:16.04

COPY . /bd_build

RUN ls -halt /bd_build/ && /bd_build/prepare.sh && \
	/bd_build/system_services.sh && \
	/bd_build/utilities.sh && \
	/bd_build/cleanup.sh

ENV DEBIAN_FRONTEND="teletype" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

#CMD ["/sbin/my_init"]
#ENTRYPOINT ["/sbin/init_start"]

