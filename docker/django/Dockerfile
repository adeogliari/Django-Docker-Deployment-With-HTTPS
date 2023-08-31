FROM python:3.11.4-alpine3.18

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./app /app

WORKDIR /app

RUN python -m venv /py && \ 
	 	/py/bin/pip install --upgrade pip && \
	 	apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
      build-base postgresql-dev musl-dev linux-headers && \
    /py/bin/pip install -r /requirements.txt && \
	 	apk del .tmp-deps && \
	 	adduser --disabled-password --no-create-home django && \
	 	mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R django:django /vol && \
    chmod -R 755 /vol && \

ENV PATH="/scripts:/py/bin:$PATH"

USER django