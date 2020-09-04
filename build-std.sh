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

_INPLACE=0
if [ -z "$2" ] ; then
    BRANCH="master"
else
    if [ "xinplace" == "x$2" ] ; then
        _INPLACE=1
    else
        BRANCH=$2
    fi
fi

if [ -z "$3" ] ; then
    REPO="https://github.com/pmix/pmix-standard.git"
else
    REPO=$3
fi

if [ -z "$4" ] ; then
    OUT_FNAME="pmix-standard-"${BRANCH}".pdf"
else
    OUT_FNAME=$4
fi


if [[ $_INPLACE == 0 && -d "pmix-standard" ]] ; then
    echo "--------- Remove old directory"
    rm -rf pmix-standard
fi


if [ $_INPLACE == 0 ] ; then
    if [[ "$REPO" = /* ]] ; then
        echo "--------- Copy working directory ($BRANCH)"
        cp -R $REPO pmix-standard
    else
        echo "--------- Clone the branch ($BRANCH)"
        echo git clone -b $BRANCH $REPO
        git clone -b $BRANCH $REPO
    fi
else
    echo "--------- Building inplace"
fi

echo "--------- Build"
if [ $_INPLACE == 0 ] ; then
    cd pmix-standard
else
    cd $TARGETDIR
fi
make clean
make


if [[ $_INPLACE == 0 && -d "$TARGETDIR" ]] ; then
    echo "--------- Copy out the pdf"
    cp pmix-standard.pdf ${TARGETDIR}/${OUT_FNAME}
fi
