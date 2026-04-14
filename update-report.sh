#!/bin/bash
# Ensure the script stops if any command fails
set -e

# Define paths (adjust these paths as needed)
REPO_DIR="/home/aburtolab/R/revillagigedo-dashboard"
FETCH_SCRIPT="$REPO_DIR/fetch-report.js"

# Change to your repository directory
cd "$REPO_DIR" || { echo "Repository directory not found"; exit 1; }

# Run the fetch-report script to update the HTML file
echo "Running fetch-report.js..."
nodejs "$FETCH_SCRIPT"

# Check for any changes in the repository
if git diff-index --quiet HEAD --; then
  echo "No changes detected. Nothing to commit."
else
  echo "Changes detected. Committing and pushing updates..."
  
  # Stage all changes (or specify the file(s) you want to commit)
  git add .
  
  # Commit with a timestamp in the message
  git commit -m "Automated update of report on $(date '+%Y-%m-%d %H:%M:%S')"
  
  # Push to the default remote branch (adjust 'main' if needed)
  git push origin main
fi

echo "Script completed successfully."