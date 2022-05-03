FROM ubuntu:focal

LABEL maintainer "VCityTeam"
LABEL source.repo "https://github.com/VCityTeam/UD-Demo-Anthropocene-GratteCiel-"

RUN apt-get update

# Node version 14 is required. For its installation (on focal) refer to e.g.
#  https://computingforgeeks.com/install-node-js-14-on-ubuntu-debian-linux/
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
RUN node --version
RUN npm --version
RUN apt-get install -y git
RUN git --version

######### Install UD-Viz
RUN git clone https://github.com/VCityTeam/UD-Demo-Anthropocene-GratteCiel-
WORKDIR UD-Demo-Anthropocene-GratteCiel-
RUN npm install
RUN npm run build

######### Install the ExpressJS server
WORKDIR /
RUN git clone https://github.com/VCityTeam/UD-SimpleServer.git
WORKDIR UD-SimpleServer
RUN npm install


EXPOSE 80
CMD [ "node", "./index.js", "../UD-Demo-Anthropocene-GratteCiel-", "80" ]