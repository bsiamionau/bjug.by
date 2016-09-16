#!/bin/bash
set -e # exit with nonzero exit code if anything fails

# check current branch
if [ 'master' != $TRAVIS_BRANCH ]; then
    echo "Deploy only on master branch. Current branch: '$branch'.";
    exit 0;
fi

# run our compile script
git submodule init
git submodule update
hugo

# sync with remote folder
rsync -r --delete-after --quiet $TRAVIS_BUILD_DIR/public/ deploy@bjug.by:~/files/bjug.by
