# Use an official Python runtime as the base image
FROM python:3.8

# Set the working directory in the container to /app
WORKDIR /app

# Copy the requirements.txt file into the container at /app
COPY requirements.txt ./

RUN ls

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Bundle app source inside the Docker image
COPY . .

# Make port 80 available to the outside
EXPOSE 80

# Define the command to run the application
CMD [ "python", "./app.py" ]