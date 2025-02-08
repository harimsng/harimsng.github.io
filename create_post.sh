TITLE=""
read -p "Enter the title of a post: " TITLE
FILENAME="$(date +"%F")-$(echo $TITLE | sed 's/ /_/g').md"
echo "filename: ${FILENAME}"
echo "content:"
echo "\
---
layout: post
title: \"${TITLE}\"
date: $(date +"%F %R:%S %z")
categories:
---
" > ${FILENAME}
cat ${FILENAME}
