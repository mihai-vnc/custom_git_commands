#!/bin/bash

# Usage: git-compare-file <branch-name> <file-path>

branch_name="$1"
file_path="$2"

if [[ -z "$branch_name" || -z "$file_path" ]]; then
    echo "Usage: git-compare-file <branch-name> <file-path>"
    exit 1
fi

# Get the current branch name
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Check if the branch exists
if ! git rev-parse --verify "$branch_name" &>/dev/null; then
    echo "Error: Branch '$branch_name' does not exist."
    exit 1
fi

# Check if the file exists in the current branch
if ! git show "$current_branch":"$file_path" &>/dev/null; then
    echo "Error: File '$file_path' does not exist in the current branch ('$current_branch')."
    exit 1
fi

# Check if the file exists in the specified branch
if ! git show "$branch_name":"$file_path" &>/dev/null; then
    echo "Error: File '$file_path' does not exist in branch '$branch_name'."
    exit 1
fi

# Perform the file comparison
git difftool "$current_branch":"$file_path" "$branch_name":"$file_path"
