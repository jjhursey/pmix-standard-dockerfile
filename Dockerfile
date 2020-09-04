FROM ubuntu:20.04
MAINTAINER jjhursey <jjhursey@open-mpi.org>

ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
        wget git make \
        texlive-base texlive-latex-recommended \
        texlive-latex-extra texlive-lang-greek \
        texlive-science \
        python3-pip \
        python-is-python3 \
 && apt-get clean \
 && pip3 install Pygments

# Add a user, so we don't run as root
RUN groupadd -r pmixer && useradd --no-log-init -r -m -b /home -g pmixer pmixer
USER pmixer
WORKDIR /home/pmixer

RUN mkdir /home/pmixer/bin
COPY build-std.sh build-gov.sh /home/pmixer/bin/
