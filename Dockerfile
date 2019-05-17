# Dockerfile for building image with deepchem (cpu) installed
# https://towardsdatascience.com/docker-for-data-science-9c0ce73e8263
# To build from scratch: docker build --no-cache -t docker-solubility-v1 .

#Download conda
FROM continuumio/miniconda3:4.6.14

#Update conda
#RUN conda update conda
#RUN conda update --all

#Create environment in 3.6.6 (same as my ubuntu)
RUN yes "yes" | conda create -n env --no-deps python=3.6.6

#Set docker to ope nvironment each time
#see https://medium.com/@chadlagore/conda-environments-with-docker-82cdc9d25754
RUN echo "source activate env" > ~/.bashrc

#Specify environment installation and install deepchem (and dependencies)
RUN yes "yes" | conda install -n env -c deepchem -c rdkit -c conda-forge -c omnia deepchem=2.1.0

#Clean conda after installation
RUN yes "yes" | conda clean --all

# Labels.
#https://medium.com/@chamilad/lets-make-your-docker-image-better-than-90-of-existing-ones-8b1e5de950d
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date="May 17 2019"
LABEL org.label-schema.name="rodrigozepeda/deepchem-docker"
LABEL org.label-schema.description="Docker implementation of deepchem package without GPU support."
LABEL org.label-schema.url="https://github.com/RodrigoZepeda/deepchem-docker"
LABEL org.label-schema.version="2.1.0"
LABEL org.label-schema.docker.cmd="docker run -it rodrigozepeda/deepchem-docker /bin/bash"

# Set environment variables
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV PATH /opt/conda/envs/env/bin:$PATH
