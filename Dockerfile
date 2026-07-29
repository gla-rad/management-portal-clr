# Stage 1: Initialise a container with pnpm
FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
RUN corepack prepare pnpm@10.0.0 --activate
COPY . /app
WORKDIR /app

# Stage 2: Check the dependences
FROM base AS prod-deps
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile

# Stage 3: Now build for production
FROM base AS build

# The WASM module is compiled during the build (see the prebuild/build:go npm
# scripts), so the go toolchain is required here. It is lifted off the official
# image, as Debian's own golang package is too old for go/go.mod, along with
# the CA bundle that node:20-slim omits, since unlike node, go verifies the
# module proxy against the system trust store.
COPY --from=golang:1.26-bookworm /usr/local/go /usr/local/go
COPY --from=golang:1.26-bookworm /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENV PATH="/usr/local/go/bin:$PATH"
ENV GOPATH="/go"

RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm run build

# Stage 4: Create a production image
FROM nginx:mainline-alpine AS final

# Copy the dependency and build files
COPY --from=prod-deps /app/node_modules /usr/share/nginx/html/node_modules
COPY --from=build /app/dist/management-portal-clr /usr/share/nginx/html

# Overwrite the default docker conf in the docker file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 4200 for serving the Angular app
EXPOSE 4200

# Start the NGINX server
# Replace the environment variables with the onces provided in docker before
# moving on to start the nginx web-server
CMD ["/bin/sh", "-c", \
    "export APP_BASE_HREF_DEFAULT=\"${APP_BASE_HREF:-/}\" \
    && sed -i \"s|<base href=\\\"/\\\">|<base href=\\\"${APP_BASE_HREF_DEFAULT}\\\">|g\" /usr/share/nginx/html/index.html \
    && envsubst < /usr/share/nginx/html/assets/env.template.js > /usr/share/nginx/html/assets/env.js \
    && exec nginx -g 'daemon off;'"]