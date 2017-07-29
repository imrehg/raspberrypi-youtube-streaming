# raspberrypi-youtube-streaming
Stream straight to YouTube from your Raspberry Pi with Docker.

This fork: can be deployed on [resin.io](https://resin.io) devices. It uses
[Dockerfile Templates](https://docs.resin.io/deployment/docker-templates/) to
enable deploying from this single codebase to Raspberry Pi Zero/1/2/3.

## Settings

*   `YOUTUBE_STREAM_KEY`: your stream's key, get it from your
    [Youtube Live dashboard](https://www.youtube.com/live_dashboard), encoder
    settings section.
*   `RASPIVID_EXTRA_FLAGS`: extra flags to pass to `raspivid`, for example you can
    add `-rot 180` to flip the image upside down.
