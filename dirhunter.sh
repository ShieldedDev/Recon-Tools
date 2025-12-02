url="$1"
wlist="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"

function mkd() {
	mkdir -p dirhunter
}

if [ -d "dirhunter" ]; then 
	echo "dirhunter already exists."
else
	mkd
fi 


while IFS= read -r directory; do
    list="${url}${directory}"
    # echo $list
    # curl -o /dev/null --silent -Iw "%{http_code}" $list
    response_code=$(curl -o /dev/null --silent -Iw "%{http_code}" "$list")
    echo "URL: $list - HTTP Code: $response_code" 
	
	echo "$list - HTTP Code: $response_code" >> dirhunter/result.txt

    
done < "$wlist"
