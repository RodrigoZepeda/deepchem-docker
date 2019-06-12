# Dockerfile for building image with deepchem (cpu) installed
# https://towardsdatascience.com/docker-for-data-science-9c0ce73e8263
# To build from scratch: docker build --no-cache -t deepchem-docker .

#Download conda
FROM continuumio/miniconda3:4.6.14

#Create environment in 3.6.6 (same as my ubuntu)
RUN yes "yes" | conda create -n env --no-deps python=3.6.6  && \
    echo "source activate env" > ~/.bashrc && \
    yes "yes" | conda install -n env -c deepchem -c rdkit -c conda-forge -c omnia deepchem=2.1.0 && \
    yes "yes" | conda clean --all

# Labels.
#https://medium.com/@chamilad/lets-make-your-docker-image-better-than-90-of-existing-ones-8b1e5de950d
LABEL org.label-schema.schema-version="1.2" \
      org.label-schema.build-date="May 17 2019" \
      org.label-schema.name="rodrigozepeda/deepchem-docker" \
      org.label-schema.description="Docker implementation of deepchem package without GPU support." \
      org.label-schema.url="https://github.com/RodrigoZepeda/deepchem-docker" \
      org.label-schema.version="2.1.0" \
      org.label-schema.docker.cmd="docker run -it rodrigozepeda/deepchem-docker /bin/bash"

# Set environment variables
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    PATH=/opt/conda/envs/env/bin:$PATH
