FROM ubuntu:18.04
MAINTAINER jjhursey <jjhursey@open-mpi.org>

ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y wget git make
RUN apt-get install -y texlive-base texlive-latex-recommended texlive-latex-extra texlive-lang-greek
RUN apt-get clean

# Add a user, so we don't run as root
RUN groupadd -r pmixer && useradd --no-log-init -r -m -b /home -g pmixer pmixer
USER pmixer
WORKDIR /home/pmixer
