FROM python:3.9-alpine3.13
LABEL maintainer="lam0612"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ADD requirements.txt ./tmp/requirements.txt
ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip &&\
    /py/bin/pip install -r /tmp/requirements.txt &&\
    if [ ${DEV}=true ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt;\
    fi && \
    # /py/bin/pip install linux-headers &&\
    rm -rf /tmp/ && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user


ENV PATH="/py/bin:${PATH}"

