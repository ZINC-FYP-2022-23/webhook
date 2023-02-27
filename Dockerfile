# Base image for compiling the TypeScript code
FROM node:lts-alpine as builder
WORKDIR /usr/src/app
COPY . .
RUN yarn install --frozen-lockfile
RUN yarn build

# Final production image
FROM node:lts-alpine
ENV PORT=80
RUN set -ex && \
    apk add --no-cache --virtual unrar curl unzip git
WORKDIR /usr/src/app
# Copy the compiled code from the builder image. This way we don't need to install TypeScript (and other dev dependencies)
# in the final image, which reduces the image size.
COPY --from=builder /usr/src/app/dist ./dist
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production && \ 
    yarn cache clean
CMD ["yarn", "start"]
