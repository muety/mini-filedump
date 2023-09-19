FROM golang:alpine

RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
RUN xcaddy build --with github.com/ggicci/caddy-jwt --with github.com/git001/caddyv2-upload


FROM alpine

RUN mkdir -p /app/uploads

WORKDIR /app

COPY --from=0 /go/caddy .
COPY Caddyfile .
COPY response.json .

ENV FILE_TYPE_REGEX=".+\.(jpg|jpeg|png|webp|pdf|txt)"
ENV AUTH_ISSUERS=""
ENV AUTH_AUDIENCES=""
ENV AUTH_SIGN_KEY=""

VOLUME /app/uploads
EXPOSE 8000

CMD [ "./caddy", "run", "--config", "Caddyfile" ]