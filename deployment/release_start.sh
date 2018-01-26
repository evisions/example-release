#!/bin/sh

if [ ! -d "./.git" ];then cd $(git rev-parse --show-cdup); fi;
VERSION=$1
if [ -z $1 ]
then
  echo "A version must be given"
  exit 1
fi

#Initialize gitflow
git flow init -f -d

# ensure you are on latest develop  & master
git checkout develop
git pull origin develop
git checkout -

git checkout master
git pull origin master
git checkout develop

git flow release start $VERSION

GITBRANCHFULL=`git rev-parse --abbrev-ref HEAD`

# bump released version to server
git push --set-upstream origin $GITBRANCHFULL

git checkout develop
