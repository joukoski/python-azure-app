FROM python:3.10-slim
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=delicias_fabi.settings

WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

CMD sh -c "python manage.py migrate --noinput && python manage.py collectstatic --noinput && gunicorn delicias_fabi.wsgi:application --bind 0.0.0.0:${PORT:-8080} --workers 2 --threads 4 --timeout 120"