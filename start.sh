#!/bin/bash
if [ -z "$YOUTUBE_STREAM_KEY" ]; then

    echo "Please set the YOUTUBE_STREAM_KEY environment variable! (find it in stream dashboard / Encoder Setup section)"
    while : ; do
        echo "Idling..."
        sleep 600
    done
else
    echo Youtube live stream key: ${YOUTUBE_STREAM_KEY}
fi

raspivid -o - -t 0 -w 1920 -h 1080 -fps 25 -b ${RASPIVID_BITRATE=800000} -g 160 -if both ${RASPIVID_EXTRA_FLAGS} | \
  ffmpeg -re -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero -thread_queue_size 512 -f h264 -i pipe:0 -c:v copy  -c:a aac -ab 32k -g 160 -strict experimental -f flv -r 25 \
  "rtmp://a.rtmp.youtube.com/live2/${YOUTUBE_STREAM_KEY}"
