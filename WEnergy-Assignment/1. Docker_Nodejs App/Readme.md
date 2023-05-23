#### 1. Application setup steps

This simple nodejs app starts on port 3000 and logs some info on startup.

###### to prepare the app for startup, installing all the dependencies 
    
    npm install

###### to start the application

    npm start or node app/server.js

###### to build the image from Dockerfile

    docker build -t my-app:1.0 .

###### to start the built docker image

    docker run -d --name wnergy_app --cpuset-cpus "0-1" --restart always my-app:2.0

###### to build an archive file

    npm pack


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Assignment Questions

# You should be able to find what system packages are needed by looking through the app
To identify the system packages that are needed by a Node.js app, you can analyse the dependencies and requirements specified within the app's code and configuration files i.e. 'package.json' file. 

# You should not need to change the app code in any way
For this I'm installing a library "express: 4.17.1"

# The app should be running as a non-privileged user
Within the Dockerfile, I have added the steps to 
- Create a non-root user
- Set ownership of the application directory to the non-root user
- Switch to the non-root user

# The app should be automatically restarted if crashes or is killed
You can configure Docker restart policy to always to automatically restarted if crashes or is killed
the command is: "docker run --restart always my-app:1.0"

# The app should maximize all the available CPUs
When running the Docker container, you can allocate the necessary resources and enable CPU sharing across all the available cores.
the updated command is "docker run -d --name wnergy_app --cpuset-cpus "0-3" --restart always my-app:1.0"

# Time zone should be in CST.
In the Dockerfile, I have added a step "ENV TZ=America/Chicago" to set the time zone to CST.

# Follow best practices when writing a docker file.
The following best practices are implemented:
- Using a slim version of the base image to reduce the image size.
- Copying the package.json and package-lock.json files and running npm install before copying the rest of the app code to take advantage of Docker's layer caching mechanism.
- Using --only=production flag with npm install to only install production dependencies and to reduce the image size.
- Exposing the port on which the app will run to make it clear to the user which port to connect to.
- Using CMD instead of ENTRYPOINT to allow the command to be overridden if necessary.


