FROM python:3.10-slim
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=delicias_fabi.settings

WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

CMD sh -c "echo 'Starting...' && python manage.py migrate --noinput 2>&1 && echo 'Migrate OK' && python manage.py collectstatic --noinput 2>&1 && echo 'Static OK' && gunicorn delicias_fabi.wsgi:application --bind 0.0.0.0:${PORT:-8080} --workers 1 --timeout 120 --log-level debug 2>&1"