FROM node:9.8.0-alpine

EXPOSE 8000

ARG workdir=/usr/local/app

# install dependencies
RUN apk add --no-cache --update --virtual build-dependencies \
  python \
  make \
  g++ \
  gcc \
  git

WORKDIR $workdir

# copy files from project to app directory
COPY package.json package-lock.json ./
RUN npm install

COPY . ./
RUN ./node_modules/.bin/bower --allow-root install \
  && apk del build-dependencies

CMD ["npm", "start"]
