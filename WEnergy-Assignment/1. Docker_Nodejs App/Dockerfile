# Set the base image to Node.js 14
FROM node:14-slim

RUN mkdir -p /usr/app

# Copy the package.json and package-lock.json files
COPY package*.json /usr/app/
COPY app/* /usr/app/

# set default dir so that next commands executes in /usr/app dir
WORKDIR /usr/app

# Install dependencies
RUN npm install --only=production
ENV TZ=America/Chicago

# Create a non-root user
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Set ownership of the application directory to the non-root user
RUN chown -R appuser:appgroup /usr/app

# Switch to the non-root user
USER appuser

# Expose the port on which the app will run
EXPOSE 8080

# Set the command to run the app
CMD ["node", "/usr/app/server.js"]
