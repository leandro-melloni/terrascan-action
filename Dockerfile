# Dependency Image
FROM tenable/terrascan:1.18.1 as terrascan

# Base Image
FROM alpine:3.18

RUN apk update && \
    apk add --no-cache git openssh

# Install Terrascan
COPY --from=terrascan /go/bin/terrascan /usr/bin/
RUN terrascan init

# Handles entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
