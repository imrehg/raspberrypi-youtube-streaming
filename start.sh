#!/bin/bash
if [ -z "$YOUTUBE_STREAM_KEY" ]; then

    echo "Please set the YOUTUBE_STREAM_KEY environment variable! (find it in stream dashboard / Encoder Setup section)"
    while : ; do
        echo "Idling..."
        sleep 600
    done
else
    echo Live-stream secret: ${YOUTUBE_STREAM_KEY}
fi

raspivid -o - -t 0 -w 1920 -h 1080 -fps 30 -b 8000000 -g 40 ${RASPIVID_EXTRA_FLAGS} | ffmpeg -re -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero -f h264 -i pipe:0 -c:v copy -c:a aac -ab 128k -g 40 -strict experimental -f flv -r 30 "rtmp://a.rtmp.youtube.com/live2/${YOUTUBE_STREAM_KEY}"
