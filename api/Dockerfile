FROM node:12

WORKDIR /usr/src/app

ENV PORT=3000

COPY package*.json ./

RUN npm install

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "node", "server.js" ]
