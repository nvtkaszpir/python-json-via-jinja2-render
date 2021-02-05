FROM python:3.9.1-slim-buster

LABEL "org.opencontainers.image.url"="https://github.com/nvtkaszpir/python-json-via-jinja2-render"
LABEL "org.opencontainers.image.authors"="Michał Sochoń <kaszpir@gmail.com>"

COPY requirements.txt /tmp/
USER 0
RUN python -m pip install --no-cache-dir --upgrade pip==21.0.1 \
  && python -m pip install --no-cache-dir -r /tmp/requirements.txt

USER nobody
WORKDIR /app/
COPY templates/ ./templates/
COPY render.py .

ENTRYPOINT ["python","./render.py"]
CMD ["--help"]
