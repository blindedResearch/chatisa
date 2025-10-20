FROM rockylinux/rockylinux:8

ARG OPENAI_API_KEY

RUN dnf update -y && dnf clean all && rm -rf /var/cache/dnf/*
RUN dnf install -y \
        python3.11 python3.11-pip

COPY . /app

RUN cd app; pip3 install -r requirements.txt
RUN cd app; echo "OPENAI_API_KEY=$OPENAI_API_KEY" > /app/.env

WORKDIR /app

ENV STREAMLIT_SERVER_PORT=8080
ENV STREAMLIT_SERVER_HEADLESS=true
ENV STREAMLIT_SERVER_ENABLECORS=false
ENV STREAMLIT_BROWSER_GATHER_USAGE_STATS=false

ENTRYPOINT streamlit run chatgpt.py
