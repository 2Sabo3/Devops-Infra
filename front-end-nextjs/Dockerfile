FROM alpine:latest

WORKDIR /front-end-nextjs

COPY ./front-end-nextjs/package.json ./front-end-nextjs/package-lock.json ./
#COPY . . 
RUN apk add --no-cache nodejs npm

RUN npm install

COPY ./front-end-nextjs .


RUN npm run build

CMD ["sh","-c","npm start"]

EXPOSE 3000



