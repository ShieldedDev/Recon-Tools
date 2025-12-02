#!/bin/bash

url="$1"
wlist="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"

# Ensure output dir exists
mkdir -p dirhunter

# Output file
outfile="dirhunter/result.txt"
echo "" > "$outfile"   # clear file

# Safe URL normalization (remove trailing slash)
base="${url%/}"

while IFS= read -r directory; do

    # Skip empty lines & comments
    [[ -z "$directory" || "$directory" =~ ^# ]] && continue

    # Build URL
    list="${base}/${directory}"

    # Fetch response code
    response_code=$(curl -o /dev/null --silent -Iw "%{http_code}" "$list")

    echo "URL: $list - HTTP Code: $response_code"
    echo "$list - HTTP Code: $response_code" >> "$outfile"

done < "$wlist"
