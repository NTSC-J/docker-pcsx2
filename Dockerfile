FROM amd64/ubuntu:latest
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y install software-properties-common
RUN add-apt-repository ppa:gregory-hainaut/pcsx2.official.ppa
RUN apt-get update && apt-get -y install pcsx2
RUN apt-get -y install locales
RUN locale-gen en_US.UTF-8
RUN apt-get -y install alsa-utils pulseaudio pulseaudio-utils
RUN mkdir -p /home/pcsx2 && \
    echo "pcsx2:x:1000:1000:PCSX2,,,:/home/pcsx2:/bin/bash" >> /etc/passwd && \
    echo "pcsx2:x:1000:" >> /etc/group && \
    chown 1000:1000 -R /home/pcsx2 && \
    usermod -aG audio pcsx2 && \
    usermod -aG pulse pcsx2

USER pcsx2
ENV HOME /home/pcsx2
CMD /usr/games/PCSX2

