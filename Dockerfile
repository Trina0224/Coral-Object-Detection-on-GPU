# Copyright 2018 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# #==========================================================================
#
# Modified from 
# http://storage.googleapis.com/cloud-iot-edge-pretrained-models/docker/obj_det_docker
#

FROM nvcr.io/nvidia/tensorflow:19.07-py3

# Get the tensorflow models research directory, and move it into tensorflow
# source folder to match recommendation of installation
RUN git clone https://github.com/tensorflow/models.git && \
    mv models  /usr/local/lib/python3.6/dist-packages/tensorflow/models

# Install the Tensorflow Object Detection API from here
# https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md

# Install object detection api dependencies
RUN pip install Cython && \
    pip install contextlib2 && \
    pip install pillow && \
    pip install lxml && \
    pip install jupyter && \
    pip install matplotlib
#RUN apt-get update && \
  #  apt-get install -y python python3-tk


# Install pycocoapi
RUN git clone --depth 1 https://github.com/cocodataset/cocoapi.git && \
    cd cocoapi/PythonAPI && \
    make -j8 && \
    cp -r pycocotools /usr/local/lib/python3.6/dist-packages/tensorflow/models/research && \
    cd ../../ && \
    rm -rf cocoapi

# Run protoc on the object detection repo
RUN cd /usr/local/lib/python3.6/dist-packages/tensorflow/models/research && \
    protoc object_detection/protos/*.proto --python_out=.

# Set the PYTHONPATH to finish installing the API
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python3.6/dist-packages/tensorflow/models/research:/usr/local/lib/python3.6/dist-packages/tensorflow/models/research/slim

# Install wget (to make life easier below) and editors (to allow people to edit
# the files inside the container)
RUN apt-get update && \
    apt-get install -y wget vim emacs nano

ARG work_dir=/usr/local/lib/python3.6/dist-packages/tensorflow/models/research
# Get object detection transfer learning scripts.
ARG scripts_link="http://storage.googleapis.com/cloud-iot-edge-pretrained-models/docker/obj_det_scripts.tgz"
RUN cd ${work_dir} && \
    wget -O obj_det_scripts.tgz ${scripts_link} && \
    tar zxvf obj_det_scripts.tgz

WORKDIR ${work_dir}


