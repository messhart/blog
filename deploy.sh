#!/bin/sh

# set -e # If a command fails then the deploy stops

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

rm -rf public

hugo -t archie # Build a site to the ./public directory
cd public
git add -A # Add all changes to git

# Commit changes
msg="Rebuild site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"


# Push source and build repos
git push origin master

# Commit all changes of project files and push
cd ..
git add -A
git commit -m "Update blog files"
git push origin master
printf "\033[0;32mFinished!\033[0m\n"