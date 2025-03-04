# Stage 1: Build the Angular application in production mode
FROM node:14.20.1 AS production

WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install --save --legacy-peer-deps

# Install the specific @types/ws package version
RUN npm install @types/ws@8.5.4

# Copy the rest of the application source code
COPY . .

# Build the Angular application with the production configuration
RUN npm run build:prod

# Stage 2: Create a production image
FROM nginx:alpine AS final

# Copy the built Angular app from the production stage to the final image
COPY --from=production /app/dist /usr/share/nginx/html

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