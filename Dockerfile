# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  cmake \
  libopenblas-dev \
  libjpeg-dev \
  libpng-dev \
  libtiff-dev \
  libavformat-dev \
  libswscale-dev \
  libv4l-dev \
  libxvidcore-dev \
  libx264-dev \
  libgtk-3-dev \
  libatlas-base-dev \
  gfortran \
  build-essential \
  python3-dev \
  && rm -rf /var/lib/apt/lists/*

# Install dlib and face_recognition
RUN pip install dlib==19.24.0 face_recognition==1.3.0

# Set the working directory in the container
WORKDIR /code

# Copy the requirements file into the container
COPY requirements.txt /code/

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Django project into the container
COPY . /code/

# Expose the port django is running on
EXPOSE 9000

# Run the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:9000"]
