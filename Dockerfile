FROM python:3.9-slim

RUN useradd -m -u 1000 appuser && \
    mkdir -p /app && \
    chown -R appuser:appuser /app



RUN pip install --upgrade pipenv

WORKDIR /app
COPY . .
RUN pipenv install --system --deploy

USER appuser

EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]
