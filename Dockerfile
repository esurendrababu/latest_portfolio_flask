# Use official Python base image
FROM python:3.9-slim

# Set working directory inside container
WORKDIR /app

# Copy all files into container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Cloud Run will connect to
ENV PORT=8080
EXPOSE 8080

# Start the app
CMD ["python", "project/app.py"]
