#!/bin/bash

# Function to check if the current directory is a Git repository
is_git_repository() {
  git rev-parse --is-inside-work-tree &>/dev/null
}

# Check if the current directory is a Git repository
if ! is_git_repository; then
  echo "Error: Not a Git repository. Please run this command in a Git repository." >&2
  exit 1
fi

# Attempt a 'git pull' to fetch the latest changes from the remote repository
git pull

# Check if the 'git pull' failed
if [ $? -ne 0 ]; then
  # Check if there are conflicts after the failed 'git pull'
  conflicted_files=$(git diff --name-only --diff-filter=U)
  if [ -n "$conflicted_files" ]; then
    echo "Error: Conflicts exist in the following files. Please resolve conflicts manually before proceeding:"
    echo "$conflicted_files"
    exit 1
  else
    echo "Error: Failed to pull changes from the remote repository." >&2
    exit 1
  fi
fi

# Check if there are any conflicts after the 'git pull'
conflicted_files=$(git diff --name-only --diff-filter=U)
if [ -n "$conflicted_files" ]; then
  echo "Error: Conflicts exist in the following files. Please resolve conflicts manually before proceeding:"
  echo "$conflicted_files"
  exit 1
fi

# Check if there are any staged changes to commit
if ! git diff --cached --quiet; then
  # Ask the user for commit message
  read -p "Enter commit message: " commit_message

  # Perform a 'git commit' with the provided message
  git commit -m "$commit_message"

  # Check if the 'git commit' was successful
  if [ $? -ne 0 ]; then
    echo "Error: Failed to commit changes." >&2
    exit 1
  fi

  # Perform a 'git push' to push changes to the remote repository
  git push

  # Check if the 'git push' was successful
  if [ $? -ne 0 ]; then
    echo "Error: Failed to push changes to the remote repository." >&2
    exit 1
  fi

  echo "Successfully pulled changes, committed with message '$commit_message', and pushed changes."
else
  echo "No staged changes to commit. Exiting."
  exit 1
fi
