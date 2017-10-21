FROM ubuntu

RUN apt-get update
RUN apt-get -y install quake2 game-data-packager innoextract

RUN mkdir -p /root/q2/baseq2
RUN /usr/games/game-data-packager quake2 --package quake2-demo-data
RUN dpkg -i quake2*.deb

RUN useradd -ms /bin/bash newuser
USER newuser

ENV DISPLAY=:0
CMD /usr/games/quake2

