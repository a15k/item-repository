#!/bin/bash

sha_or_branch=${1:-master}

echo "Checking out $sha_or_branch"
git checkout $sha_or_branch

if [ $? -ne 0 ]; then
  echo "$sha_or_branch is not available, fetching"
  git fetch
  git checkout $sha_or_branch

  if [ $? -ne 0 ]; then
    echo "error: Could not checkout $sha_or_branch"
    exit 1
  fi
fi

# Wrap the remaining calls inside another script so that we get the checkedout
# version of the script.

# TODO only call it if the checkout changed the SHA

./provision_after_checkout.sh
yarn install

