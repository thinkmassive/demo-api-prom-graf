FROM debian:stable-slim

ADD loadgen.sh /usr/local/bin/

RUN apt-get update && apt-get install -y curl && chmod +x /usr/local/bin/loadgen.sh

USER 1000

ENTRYPOINT ["/usr/local/bin/loadgen.sh"]
