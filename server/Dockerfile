FROM node:alpine
WORKDIR /app
COPY package*.json ./

COPY ./ ./

RUN npm install

USER node

EXPOSE 3000

CMD ["npm", "run", "start"]