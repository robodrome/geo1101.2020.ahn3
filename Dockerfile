FROM condaforge/mambaforge:22.9.0-2

LABEL "maintainer"="david@robodrome.nl"

ENV MYUSER geo1101

RUN useradd -m $MYUSER
USER $MYUSER
WORKDIR /home/$MYUSER

# Switch shell sh (default in Linux) to bash
SHELL ["/bin/bash", "-c"]

# Copy applications files
COPY --chown=$MYUSER:$MYUSER ./src ./src
COPY --chown=$MYUSER:$MYUSER environment.yml .

RUN mamba env create -f environment.yml

COPY --chown=$MYUSER:$MYUSER config.ini .

RUN echo "source activate geo1101ahn3" >> ~/.bashrc && \
    eval "$(conda shell.bash hook)" && \
    source /home/$MYUSER/.bashrc

#RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc

#    source "$HOME/.cargo/env"