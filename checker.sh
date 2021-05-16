#!/bin/bash
while true; do
	A=$(cat cc)
	if [[ "$A" = "false" ]]; then
		sleep 1
		continue
	fi
	CSRF_TOKEN="YOUR_CSRF_TOKEN_HERE"
	SESSION_ID="YOUR_SESSION_ID_HERE"
	curl 'https://www.diderot.one/dosts/load_dosts_to_po/?course_pk=2&search_query=&name=poll&page=1&order_by=date' -X POST -H "Cookie: csrftoken=$CSRF_TOKEN; sessionid=$SESSION_ID" -H 'Origin: https://www.diderot.one' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36' -H 'Accept: */*' -H 'Referer: https://www.diderot.one/dosts/?course_pk=2&name=poll&page=1&view_style=&order_by=&search_query=' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' -H 'Content-Length: 0' -H "X-CSRFToken: $CSRF_TOKEN" --compressed > poll_data
	PREV=$(cat poll_amount)
	echo $(grep -o '\\\"Poll\\\"' poll_data | wc -l) > poll_amount
	NOW=$(cat poll_amount)
	if [[ "$A" = "start" ]]; then
		PREV=$NOW
		echo active > cc
		echo Starting...
	fi
	if [[ "$PREV" != "$NOW" ]]; then
		echo NOW > poll_status
		echo false > cc
		echo New Poll!
		echo Stopping...
	fi
done

