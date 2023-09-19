# mini-filedump

A minimalistic file server for JWT-authorized uploads and serving to be used by any web app. Built solely with Caddy plugins.

## To Do
* [ ] Requires https://github.com/git001/caddyv2-upload/pull/15 to be merged
* [ ] Test with reverse proxy

## Build
```bash
xcaddy build --with github.com/ggicci/caddy-jwt --with github.com/git001/caddyv2-upload
```

## Configure
The following environment variables are required (can be set using `export`):
* **`FILE_TYPE_REGEX`**     - A regex for the file server to match against, e.g. `.+\.(png|jpg|webp|pdf)$`
* **`AUTH_SIGN_KEY`**       - The base64-encoded, 32-bytes JWT signing secret
* **`AUTH_ISSUERS`**        - An optional list of allowed issuers (JWT's `iss` claim)
* **`AUTH_AUDIENCES`**      - An optional list of allowed audiences (JWT's `aud` claim)

## Run
```bash
./caddy run --config Caddyfile
```

## Run with Docker
```bash
docker build . -t ghcr.io/muety/mini-filedump
docker run -d \
    -p 8000 \
    -v /var/data/filedump:/app/uploads \
    -e AUTH_SIGN_KEY=dGs4R2tITnZkUUxhY1l4VkJpcFhKUnQ4WHhWdG5rTnAK \
    ghcr.io/muety/mini-filedump
```

## Use
```bash
curl -XPOST --form @file=some_file.pdf http://localhost:8000

# Response:
# {
#     "url": "http://localhost:8000/0d2d7bde-4bd6-442d-b39e-c75bd8065cb2/some_file.pdf
# }
```
