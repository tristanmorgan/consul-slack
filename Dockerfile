FROM golang:alpine AS build

RUN apk add --no-cache git alpine-sdk

WORKDIR $GOPATH/src/github.com/ttys3/consul-slack

COPY . .

RUN go mod tidy

RUN CGO_ENABLED="0" go build -trimpath -ldflags="-s -w" -a -o /consul-slack

FROM scratch

WORKDIR /

COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /consul-slack consul-slack

ENTRYPOINT [ "./consul-slack" ]

