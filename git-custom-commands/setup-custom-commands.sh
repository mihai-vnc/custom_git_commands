#!/bin/bash

# Set the scripts directory path
SCRIPTS_DIR="/path/to/directory/containing/scripts"

# Make the scripts executable
chmod +x "$SCRIPTS_DIR/git-easy-push.sh"
chmod +x "$SCRIPTS_DIR/git-compare-file.sh"

# Add the custom commands to the user's Git configuration
git config --global alias.easy-push "!$SCRIPTS_DIR/git-easy-push.sh"
git config --global alias.compare-file "!$SCRIPTS_DIR/git-compare-file.sh"

echo "Git custom commands and executable permission set up successfully."
