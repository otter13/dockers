# This docker file was referenced from the official docker image of cypress
# cypress/browsers:node16.5.0-chrome94-ff93
# The original image is set to run cypress while in our case we want to let it wait at shell
#
# build this image with command with os arch type parameter if needed:  --platform=linux/arm64 
# otherwise docker will use the same type as the host. 
#   docker build .  -t limosmiley/node-16.19.0-cypress-9.4.1 
#
FROM node:16.19.0

# Update the dependencies to get the latest and greatest (and safest!) packages.
RUN apt update && apt upgrade -y
RUN apt-get install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb
# avoid too many progress messages
# https://github.com/cypress-io/cypress/issues/1243
ENV CI=1

# disable shared memory X11 affecting Cypress v4 and Chrome
# https://github.com/cypress-io/cypress-docker-images/issues/270
ENV QT_X11_NO_MITSHM=1
ENV _X11_NO_MITSHM=1
ENV _MITSHM=0

# should be root user
RUN echo "whoami: $(whoami)"
RUN npm config -g set user $(whoami)

# command "id" should print:
# uid=0(root) gid=0(root) groups=0(root)
# which means the current user is root
RUN id

# point Cypress at the /root/cache no matter what user account is used
# see https://on.cypress.io/caching
ENV CYPRESS_CACHE_FOLDER=/root/.cache/Cypress
RUN npm install -g "cypress@9.4.1"
# RUN cypress verify


# Cypress cache and installed version
# should be in the root user's home folder
# RUN cypress cache path
# RUN cypress cache list
# RUN cypress info
# RUN cypress version

# give every user read access to the "/root" folder where the binary is cached
# we really only need to worry about the top folder, fortunately
RUN ls -la /root
RUN chmod 755 /root
RUN chmod -R 777 /root

RUN apt-get install -y p7zip-full
RUN echo "Manually install cypress 9.4.1"
RUN mkdir -p /root/.cache/Cypress-arm
RUN mkdir -p /root/.cache/Cypress-arm/9.4.1
COPY cypress-9.4.1-m1-arm64.7z ./
RUN 7z x ./cypress-9.4.1-m1-arm64.7z -y -o/root/.cache/Cypress-arm/9.4.1
RUN chmod 755 /root/.cache/Cypress-arm/9.4.1/Cypress/Cypress

# always grab the latest Yarn
# otherwise the base image might have old versions
# NPM does not need to be installed as it is already included with Node.
# RUN npm i -g yarn@latest

# Show where Node loads required modules from
# RUN node -p 'module.paths'

# should print Cypress version
# plus Electron and bundled Node versions
# RUN cypress version
# RUN echo  " node version:    $(node -v) \n" \
#   "npm version:     $(npm -v) \n" \
#   "yarn version:    $(yarn -v) \n" \
#   "debian version:  $(cat /etc/debian_version) \n" \
#   "user:            $(whoami) \n" \
#   "chrome:          $(google-chrome --version || true) \n" \
#   "firefox:         $(firefox --version || true) \n"

ENTRYPOINT ["docker-entrypoint.sh"]