#!/bin/bash

# This code is called during building an AMI and when an AMI is
# launched.  Its job is to get the code that has already been
# cloned to the given SHA or latest commit on a given branch.
# If this code results in a change to the checked-out commit,
# the script will run the commands to install the code.  This
# installation step can also be forced by adding a second
# `force_install` option.

sha_or_branch=${1}
force_install=${2:-""}

update_code() {
  if [ -z "$sha_or_branch" ]; then
    echo "No SHA or branch provided, so will not update code."
    return
  fi

  if [[ $original_sha = *"$sha_or_branch"* ]]; then
    echo "Code is already up-to-date."
    return
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

  if [[ $checked_out_sha != *"$sha_or_branch"* ]]; then
    # $sha_or_branch is a branch
    latest_branch_sha=$(git rev-parse origin/$sha_or_branch)

    if [ "$latest_branch_sha" -ne "$checked_out_sha" ]; then
      echo "Switching to latest commit on branch $sha_or_branch"
      git fetch
      git checkout $latest_branch_sha
      checked_out_sha=$(git rev-parse HEAD)
    fi
  fi
}

echo "Starting provision.sh"

original_sha=$(git rev-parse HEAD)
checked_out_sha="$original_sha"

update_code

# Wrap the remaining calls in another script so that we run the script code
# in the "checked out SHA"; if we had the remaining calls inline in this
# script, they'd be from the original SHA.

if [ "$force_install" == "force_install" ]; then
  echo "Forcing code install"
  ./provision_after_checkout.sh
elif [ "$original_sha" != "$checked_out_sha" ]; then
  echo "Started on $original_sha but now at $checked_out_sha so running code install"
  ./provision_after_checkout.sh
else
  echo "Not running code install"
fi
