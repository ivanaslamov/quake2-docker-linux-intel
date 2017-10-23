FROM ubuntu

RUN apt-get update
RUN apt-get -y install wget pulseaudio xdg-utils libxss1

# audio video related setup
RUN echo enable-shm=no >> /etc/pulse/client.conf
RUN groupadd -f -g 1000 game
RUN adduser --uid 1000 --gid 1000 --disabled-login --gecos 'Game' game

ENV DISPLAY=:0
ENV PULSE_SERVER /run/pulse/native

# game dependencies
RUN apt-get -y install quake2 game-data-packager innoextract

# game setup
RUN /usr/games/game-data-packager quake2 --package quake2-demo-data
RUN dpkg -i quake2*.deb

# store local game data
ADD .yq2 /home/game/.yq2
RUN chown -R game:game /home/game/.yq2

USER game

CMD /usr/games/quake2
