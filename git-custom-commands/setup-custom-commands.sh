#!/bin/bash

# Set the scritpts directory path
SCRIPTS_DIR="/path/to/directory/containing/scripts"

# Make the scripts executable
chmod +x "$SCRIPTS_DIR/git-easy-push.sh"

# Add the customs commands to the user's Git configuration
git config --global alias.easy-push "$SCRIPTS_DIR/git-easy-push.sh"

echo "Git custom commands and executable permission set up successfully."
