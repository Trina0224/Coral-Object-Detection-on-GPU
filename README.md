## Coral-Object-Detection-on-GPU
# Do transfer learning with Tensorflow for Google Coral TPU on Nvidia GPUs

Contributions:
https://coral.withgoogle.com/docs/edgetpu/retrain-detection/

Prerequirements:
nvidia-docker

# Steps for Usage:
You could follow original document provided by Google and use this Dockerfile to replace the original one.
Or Follow below steps:

Step.1. Install Nvidia-docker

Step.2.  
  $sudo docker build - < Dockerfile --tag detect-tutorial-GPU

Step.3.

  $DETECT_DIR=${HOME}/edgetpu/detection && mkdir -p $DETECT_DIR
  
  $nvidia-docker run --name detect-tutorial-GPU --rm -it -privileged -p 6006:6006 --mount type=bind,src=${DETECT_DIR},dst=/usr/local/lib/python3.6/dist-packages/tensorflow/models/research/learn_pet detect-tutorial-GPU
  $nvidia-docker run --name test1 --rm -it --privileged -p 6006:6006 --mount type=bind,src=/home/trina,dst=/mnt test1
  
Step.4.
From the Docker .../tensorflow/models/research/ directory
#./prepare_checkpoint_and_dataset.sh --network_type mobilenet_v2_ssd --train_whole_model false

Step.5.
Take 500 training steps and 100 evaluation steps for example:
From the Docker .../tensorflow/models/research/ directory
#./retrain_detection_model.sh --num_training_steps 500 --num_eval_steps 100

You could check training status via open a shared container to use Tensorboard or wait a while
