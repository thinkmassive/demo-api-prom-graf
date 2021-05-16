FROM python:3.9.5-slim

RUN apt update && apt install -y curl
RUN python3 -m pip install flask

ADD api.py /
WORKDIR /

HEALTHCHECK --interval=10s --timeout=5s CMD ["curl","-s","127.0.0.1:5000/health"]

CMD ["python3","api.py"]
