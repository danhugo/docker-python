FROM nvidia/cuda:11.8.0-base-ubuntu22.04

ARG USER=hicehehe
ARG PASSWORD=1

# Install ubuntu packages
RUN apt-get update -y --quiet && \
    # noninteractive mode: prevent tzdata from asking for geographic area and time zone
    DEBIAN_FRONTEND=noninteractive apt-get install -y --quiet --no-install-recommends \
    build-essential \
    git curl wget ca-certificates \
    openssh-server vim && \
    # Remove the effect of `apt-get update`
    rm -rf /var/lib/apt/lists/*


# Create an user for the app.
RUN useradd --create-home --shell /bin/bash --groups sudo ${USER}
RUN echo ${USER}:${PASSWORD} | chpasswd
USER ${USER}
ENV HOME /home/${USER}
WORKDIR $HOME

# ANACONDA
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    chmod +x miniconda.sh && \  
    # -p: installation path
    ./miniconda.sh -b -p conda && \
    rm miniconda.sh

# add conda to PATH
ENV PATH $HOME/conda/bin:$PATH
RUN touch $HOME/.bashrc && \
    echo "export PATH=$HOME/conda/bin:$PATH" >> $HOME/.bashrc

RUN conda init && \
    conda create --name env python=3.10

# Expose port 8888 for JupyterLab
EXPOSE 22 8888

# Start openssh server
USER root
RUN mkdir /run/sshd
CMD ["/usr/sbin/sshd","-D"]