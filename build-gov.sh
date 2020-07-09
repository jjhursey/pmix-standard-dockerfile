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
    REPO="https://github.com/pmix/governance.git"
else
    REPO=$3
fi

if [ -z "$4" ] ; then
    OUT_FNAME="pmix_governance-"${BRANCH}"-"`date +"%F"`".pdf"
else
    OUT_FNAME=$4
fi


if [ -d "governance" ] ; then
    echo "--------- Remove old directory"
    rm -rf governance
fi


if [[ "$REPO" = /* ]] ; then
    echo "--------- Copy working directory ($BRANCH)"
    cp -R $REPO governance
else
    echo "--------- Clone the branch ($BRANCH)"
    echo git clone -b $BRANCH $REPO
    git clone -b $BRANCH $REPO
fi

echo "--------- Build"
cd governance
make clean
make


if [ -d "$TARGETDIR" ] ; then
    echo "--------- Copy out the pdf"
    cp pmix_governance.pdf ${TARGETDIR}/${OUT_FNAME}
fi
