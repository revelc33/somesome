# Define the base image
FROM python:3.9

# Create a non-root user
RUN useradd -ms /bin/bash myuser

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements files (if any) to the working directory
COPY /src/index.html /app/index.html
COPY /src/startserver.sh /app/startserver.sh

# Copy the contents of the current directory to the working directory in the container
COPY /src/* .

RUN chown myuser -R /app
RUN chmod u+x /app/startserver.sh

# Switch to the non-root user
USER myuser

# Expose  port
EXPOSE 8000

# Execute the Python script
CMD ["/app/startserver.sh"]

