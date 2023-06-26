# Define the base image
FROM python:3.9

# Create a non-root user
RUN useradd -ms /bin/bash myuser

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements files (if any) to the working directory
COPY src/requirements.txt .

# Install project dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the contents of the current directory to the working directory in the container
COPY src/ .

RUN chown myuser /app/app.py
RUN chmod u+x /app/app.py

# Switch to the non-root user
USER myuser

# Expose  port
EXPOSE 5001

# Execute the Python service backend
CMD ["/app/app.py"]

