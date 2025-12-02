#!/bin/bash

url=""
wlist="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"

# Function to display usage
usage() {
    echo "Usage: $0 -u <url> [-w <wordlist>]"
    exit 1
}

# Parse command line options
while getopts ":u:w:" option; do
    case $option in
        u) url="$OPTARG" ;;   # Set URL
        w) wlist="$OPTARG" ;;  # Set custom wordlist
        *) usage ;;            # Invalid option
    esac
done

# Check if URL is provided
if [ -z "$url" ]; then
    usage
fi

# Read the contents of the wordlist into an array
mapfile -t directories < "$wlist"

# Iterate over the array using a for loop
for directory in "${directories[@]}"; do
    list="${url}${directory}"
    # Use quotes around variables
    response_code=$(curl -o /dev/null --silent -Iw "%{http_code}" "$list")
    echo "URL: $list - HTTP Code: $response_code"
done

# 
# 
# url="$1"
# wlist="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
# 
# function mkd() {
#     mkdir -p dirhunter  # Use -p to avoid errors if the directory already exists
# }
# 
# # Check if the 'dirhunter' directory exists
# if [ -d "dirhunter" ]; then 
#     echo "dirhunter already exists."
# else
#     mkd
# fi 
# 
# # Process each directory from the wordlist
# while IFS= read -r directory; do
#     list="${url}${directory}"
#     response_code=$(curl -o /dev/null --silent -Iw "%{http_code}" "$list")
#     echo "URL: $list - HTTP Code: $response_code"
#     
#     # Append the response code to result.txt
#     echo "$list - HTTP Code: $response_code" >> dirhunter/result.txt
# 
# done < "$wlist"
