clear
while true; do
	echo -e "command options\n a -> add new track\n p -> play track\n d -> delete track\n c -> convert(to mp3)\n q -> quit"
	read com
	clear
	case $com in
		p)
			ls ytmusic | sed 's/\(.*\)\..*/\1/' | sort | nl -s'. ' | column
			echo -e " \n \n		   (enter track name)"
			read track
			if [[ ! "$track" == *.mp3 ]]; then
        			track="$track.mp3"
    			fi
			paplay $HOME/ytmusic/$track
			echo "music is playing...... enjoy !! :D" 
			;;
		c)
			ls ytmusic
			echo "which file do you want to convert"
			read file
			outputfile="${file%.*}.mp3"
			ffmpeg -i "$HOME/ytmusic/$file" -acodec libmp3lame -ab 192k "$HOME/ytmusic/$outputfile"
			if [ $? -eq 0 ]; then
            			rm "$HOME/ytmusic/$file"
            			echo "it worked! your file $output_file has been created!"
        		else
            			echo "file didnt convert its over :("
        		fi	
			;;
		a)
			python3 ~/Downloads/yturldownload.py
			musicdir="ytmusic"
 			for file in "$musicdir"/*.webm; do
 			       	if [ -f "$file" ]; then
  			          	outputfile="$musicdir/$(basename "$file" .webm).mp3"
    			        	echo "Converting $file to $outputfile..."
    			        	ffmpeg -i "$file" -ar 44100 -ac 2 -ab 192k "$outputfile"
    			        	if [ $? -eq 0 ]; then
						rm "$file"
    			            		echo "Conversion successful: $outputfile"
   			        	else
     			            		echo "Conversion failed for $file"
    			        	fi
     			 	else
            				echo "No .webm files found in $musicdir."
        			fi
    			done
			;;
		d)
			ls ytmusic | sed 's/\(.*\)\..*/\1/' | sort | nl -s'. ' | column
			echo "which track do you want to delete?"
			read track
			if [[ ! -f "$HOME/ytmusic/$track.mp3" ]]; then
				echo "$track does not exist"
			else
				rm "$HOME/ytmusic/$track.mp3"
				clear
				if [ $? -eq 0 ]; then
					echo "deleted successfully!"
				else
					echo "deletion failed please try again :("
				fi
			fi
			;;
		q)
			echo "goodbye :D"
			break
			;;
		*)	
			echo "this either doesnt work yet or u made a typo"
			''
	esac
done
