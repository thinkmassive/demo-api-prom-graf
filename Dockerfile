FROM python:3.9.5-slim

RUN python3 -m pip install flask

ADD api.py /
WORKDIR /

CMD ["python3","api.py"]
