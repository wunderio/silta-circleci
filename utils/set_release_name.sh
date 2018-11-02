#!/bin/bash

# Custom release naming convention for SILTA
# Set the release name in circleci for later reuse.

# Release name length is 37 chars long, which leaves max 16 chars for kubernetes resource name.
# Release name is prefixed with w because  it _HAS_ to start with alphabetic character. w 4 wunder.

LOWERCASE_BRANCH=${CIRCLE_BRANCH,,}
REPONAME_HASH=$(echo ${CIRCLE_PROJECT_REPONAME,,} | shasum -a 256 | cut -c 1-8 )
BRANCHNAME_HASH=$(echo $LOWERCASE_BRANCH | shasum -a 256 | cut -c 1-8 )
BRANCHNAME_TRUNCATED=$(echo ${LOWERCASE_BRANCH//[^[:alnum:]]/-} | cut -c 1-20 | sed 's/^\(.*\)-$/\1/' )
RELEASE_NAME="w$REPONAME_HASH-$BRANCHNAME_HASH-$BRANCHNAME_TRUNCATED"
echo "export RELEASE_NAME='$RELEASE_NAME'" >> $BASH_ENV
echo "Release name set to: $RELEASE_NAME"
