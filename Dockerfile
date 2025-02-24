FROM golang:1-alpine AS builder

RUN mkdir /transmission-exporter
WORKDIR /transmission-exporter

COPY . .
RUN go build -v ./cmd/transmission-exporter

FROM alpine:latest
RUN apk add --update ca-certificates

COPY --from=builder /transmission-exporter/transmission-exporter /usr/bin/
EXPOSE 19091
USER nobody
ENTRYPOINT ["/usr/bin/transmission-exporter"]

