#!/bin/bash -x

git remote set-url --push origin `git config remote.origin.url | sed -e 's/^git:/https:/'`


if ! [ -d build/asciidoc ]; then
    echo "No new sources, so not syncing"
    exit 0
fi

# double check there were git changes
###################################################################
git diff-index --quiet HEAD
dirty=$?
if [ "$dirty" != "0" ]; then
git checkout master
git add -A index.html
git add -A images
git commit -a -m "Changes in table"
git push

# Create a tag
tagName=$(date +%s)
git tag $tagName
git push origin $tagName
fi

exit 0