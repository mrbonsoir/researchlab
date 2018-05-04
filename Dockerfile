FROM ubuntu:18.04

# Upgrading distro base
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y dist-upgrade

# Installing additional packages
RUN apt-get update && apt-get install -y build-essential python-pip

# Python package installation
RUN pip install --upgrade pip jupyter numpy matplotlib scipy scikit-learn scikit-image pandas

# Mounting notebooks volume and using it as working directory for jupyter
VOLUME /researchlab
WORKDIR /researchlab

# Jupyter will be available on e.g. 172.17.0.2:8888 from the host
EXPOSE 8888

# Declare USER variable for build scripts
ENV USER=researchlab

# Start jupyter notebook server inside /notebooks folder using volume user ID
ENTRYPOINT /researchlab/jupyter.sh
