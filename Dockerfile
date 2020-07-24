FROM golang:1.14 AS builder
ENV CGO_ENABLED=0
ARG TARGETOS
ARG TARGETARCH
WORKDIR /src
COPY . .
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /out/drone-github-comment .
FROM alpine
RUN apk add --no-cache ca-certificates
COPY --from=builder /out/drone-github-comment /bin/drone-github-comment
ENTRYPOINT ["/bin/drone-github-comment"]