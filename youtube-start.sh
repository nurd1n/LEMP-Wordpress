while read f1; do

	# download video
	echo "echo \"youtube-dl -f 22 \$(sed -n '$f1' < data/url) -o delete.mp4\"" | bash - | bash -

	# upload video
	echo "echo \"youtube-upload --title=\\\"\$(sed -n '$f1' < data/title)\\\" --description=\\\"\\\$(cat data/description/$f1)\\\" --tags=\\\"\$(sed -n '$f1' < data/tags)\\\" --privacy \\\"\$(sed -n '$f1' < data/privacy)\\\" --category=\\\"Film & Animation\\\" --default-language=\\\"ja\\\" --default-audio-language=\\\"ja\\\" --recording-date=\\\"\$(date +\"%Y-%m-%d\")T\$(date +\"%T\").0Z\\\" --location=\\\"latitude=35.709698,longitude=139.720728\\\" --playlist \\\"\$(sed -n '$f1' < data/playlist)\\\" --thumbnail \\\"data/thumbnail/$f1.jpg\\\" --client-secrets=secret/client.json --credentials-file=secret/channel.json delete.mp4\"" | bash - | bash - > report.txt

	rm -f delete*

done < "start.txt"
