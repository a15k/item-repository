#!/bin/bash

sha_or_branch=${1}

if [ -z "$sha_or_branch" ]; then
  echo "No SHA or branch provided, so nothing to do; exiting."
  exit 0
fi

original_sha=$(git rev-parse HEAD)

if [[ $original_sha = *"$sha_or_branch"* ]]; then
  echo "Code is already up-to-date; exiting."
  exit 0
fi

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

checked_out_sha=$(git rev-parse HEAD)

if [ $checked_out_sha != *"$sha_or_branch"* ]; then
  # $sha_or_branch is a branch
  latest_branch_sha=$(git rev-parse origin/$sha_or_branch)

  if [ "$latest_branch_sha" -ne "$checked_out_sha" ]; then
    echo "Switching to latest commit on branch $sha_or_branch"
    git fetch
    git checkout $latest_branch_sha
    checked_out_sha=$(git rev-parse HEAD)
  fi
fi

if [ "$original_sha" -ne "$checked_out_sha" ]; then
  echo "Started on $original_sha but now at $checked_out_sha so updating installation"

  # Wrap the remaining calls in another script so that we run the script code
  # in the "checked out SHA"; if we had the remaining calls inline in this
  # script, they'd be from the original SHA.

  ./provision_after_checkout.sh
fi



