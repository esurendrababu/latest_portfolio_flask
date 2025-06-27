# Use official Python base image
FROM python:3.9-slim

# Set working directory to the Flask app folder
WORKDIR /app/project

# Copy all files from host into the container
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r ../requirements.txt

# Expose the port expected by Cloud Run
ENV PORT=8080
EXPOSE 8080

# Run the app
CMD ["python", "app.py"]
