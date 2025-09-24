# bootdev

Docker development environment for working through Boot.dev exercises with Go, Node.js, and the Boot.dev CLI preinstalled.

## Prerequisites
- Docker and Docker Compose (v2+)

## Build the image
```bash
docker compose build
```

## Start a shell in the container
```bash
docker compose run --rm bootdev
```
The command above drops you into a Bash shell inside the container. The shared project files live in the `code/` directory on the host and are mounted at `/workspace` in the container. Create exercise folders inside `/workspace` (or `code/` from the host) before running the Boot.dev CLI.

## Available tooling
- Go `1.22.5` (official tarball) with `GOROOT=/usr/local/go` and `GOPATH=/workspace/go`
- nvm with:
  - Node.js `21.7.0` available via `nvm use 21.7.0`
  - Node.js `22.20.0` (LTS) set as the default `node`, `npm`, and `npx`
- Boot.dev CLI installed via `go install github.com/bootdotdev/bootdev@latest`

## Typical workflow
1. Build (or rebuild) the image: `docker compose build`
2. Launch an interactive shell: `docker compose run --rm bootdev`
3. Inside the container, move into `/workspace`, create a directory for the exercise, and write code.
4. Run `bootdev submit <exercise>` (or other Boot.dev CLI commands) from within the container.
5. Exit the shell when finished; the `code/` directory keeps your changes on the host.



Run the docker by:
docker compose run --rm bootdev