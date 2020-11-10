FROM node:12

WORKDIR /usr/src/app

ENV PORT=$PORT

COPY package*.json ./

RUN npm install \
    && apt-get update && apt-get install -y --no-install-recommends postgresql-client


# Bundle app source
COPY . .

CMD [ "node", "server.js" ]
