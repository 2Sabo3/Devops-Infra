FROM alpine:latest

WORKDIR /api

#ARG AWS_ACCESS_KEY
#ARG AWS_SECRET_KEY
#ENV ${AWS_ACCESS_KEY}=AWS_ACCESS_KEY
#ENV ${AWS_SECRET_KEY}=AWS_SECRET_KEY

COPY ./api .

#COPY . .

RUN apk update

RUN apk add --no-cache python3 py3-pip && python3 -m venv .venv 

RUN chmod +x .venv/bin/activate 
RUN source .venv/bin/activate && pip install -r requirements.txt

CMD [".venv/bin/uvicorn","main:app","--host","0.0.0.0","--port","8080"]


EXPOSE 8080

