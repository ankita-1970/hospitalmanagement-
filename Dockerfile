FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    libfreetype6 \
    libcairo2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

RUN python manage.py collectstatic --noinput

EXPOSE 8000
CMD gunicorn hospitalmanagement.wsgi --bind 0.0.0.0:$PORT --log-file -