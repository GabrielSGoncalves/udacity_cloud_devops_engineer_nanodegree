FROM python:3.10-slim-buster

WORKDIR /src

COPY ./app/requirements.txt requirements.txt

RUN pip install -r requirements.txt -y

COPY ./app .

CMD python app.py