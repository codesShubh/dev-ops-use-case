FROM node:18

# Create the directory if it doesn't exist
RUN mkdir -p /workspace

# Set the working directory inside the container
WORKDIR /workspace

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install the application's dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Set a health check for the application
HEALTHCHECK --interval=5s --timeout=5s CMD curl -f http://127.0.0.1:8000 || exit 1

# Expose port 8000 for the application
EXPOSE 8000

# Start the application
CMD ["npm", "start"]
