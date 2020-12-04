FROM gitpod/workspace-full

RUN sudo apt-get install npm -y
# Install nvm using curl
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

# or if you do not have curl try
# installing using wget command
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

# check if nvm is installed
RUN nvm -v

# let's install different versions of node
RUN nvm install v8.9.1
RUN nvm install v9.2.0

# check the default 
# version of node
RUN node -v

# switch to another 
# node version
RUN nvm use 9.2.0

# make node version to default
RUN nvm alias default v8.9.1
