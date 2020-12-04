FROM node:fermium-alpine as base

WORKDIR /usr/src/app

RUN apk add --no-cache \
      ca-certificates

FROM base as build

ARG NPM_TOKEN

COPY package.json yarn.lock ./
RUN yarn install
RUN rm -f .npmrc
COPY . ./
RUN yarn run build \
 && yarn pack \
 && tar -xzf *.tgz

FROM base as install

ARG NPM_TOKEN

COPY --from=build /usr/src/app/package/package.json ./usr/src/app/package/yarn.lock ./
RUN yarn install --production
RUN rm -f .npmrc
COPY --from=build /usr/src/app/package .

FROM base

COPY --from=install /usr/src/app .

ENV NODE_ENV=production \
    PORT=8080

EXPOSE 8080

ENTRYPOINT ["node"]

CMD ["server.js"]

USER node
