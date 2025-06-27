# Use official Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy all files into container
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port for Cloud Run
ENV PORT=8080
EXPOSE 8080

# Run app with gunicorn, pointing to project/app.py
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "project.app:app"]
