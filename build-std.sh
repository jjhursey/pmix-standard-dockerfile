#!/bin/bash -e

#
# Argument parsing
# ./build-std.sh [Output Dir] [Branch] [Repo]
#
if [ -z "$1" ] ; then
    TARGETDIR=${HOME}/doc/
else
    TARGETDIR=$1
fi

if [ -z "$2" ] ; then
    BRANCH="master"
else
    BRANCH=$2
fi

if [ -z "$3" ] ; then
    REPO="https://github.com/pmix/pmix-standard.git"
else
    REPO=$3
fi


if [ -d "pmix-standard" ] ; then
    echo "--------- Remove old directory"
    rm -rf pmix-standard
fi


if [[ "$REPO" = /* ]] ; then
    echo "--------- Copy working directory ($BRANCH)"
    cp -R $REPO pmix-standard
else
    echo "--------- Clone the branch ($BRANCH)"
    echo git clone -b $BRANCH $REPO
    git clone -b $BRANCH $REPO
fi

echo "--------- Build"
cd pmix-standard
make clean
make


if [ -d "$TARGETDIR" ] ; then
    echo "--------- Copy out the pdf"
    cp pmix-standard.pdf ${TARGETDIR}/pmix-standard-$BRANCH.pdf
fi
