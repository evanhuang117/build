FROM ubuntu:latest
SHELL ["/bin/bash", "-c", "-l"]
ENV DEBIAN_FRONTEND noninteractive
ENV JFLEX_DIR /root/jflex-1.7.0
ENV CUP_DIR /root
RUN apt-get update &&  apt-get install -y \
     wget \
     curl \
     build-essential \
     vim \
     tmux \
     git \
     make \
     default-jdk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* 
# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
# default.
WORKDIR /root
RUN wget -c http://www2.cs.tum.edu/projects/cup/releases/java-cup-bin-11b-20160615.tar.gz -O - | tar -xz
RUN wget -c https://jflex.de/release/jflex-1.7.0.tar.gz -O - | tar -xz

COPY dot-files/* /root/
WORKDIR /code
CMD /bin/bash
