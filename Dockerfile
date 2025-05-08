#build stage
FROM golang:1.24-alpine AS builder
RUN apk add --no-cache git
WORKDIR /go/src/app
COPY . .
RUN go mod download
RUN go build -o /go/bin/app -v ./...

#final stage
FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /go/bin/app /app
ENTRYPOINT ["/app"]
