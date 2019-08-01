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

  $nvidia-docker run --name detect-tutorial-GPU --rm -it --privileged -p 6006:6006 --mount type=bind,src=/home/trina,dst=/mnt detect-tutorial-GPU
  
Step.4.
From the Docker .../tensorflow/models/research/ directory
#./prepare_checkpoint_and_dataset.sh --network_type mobilenet_v2_ssd --train_whole_model false
It could help to you pull datasets and build records file for TensorFlow training. It's a Pascal Vod annotation like datasets. This script also help you download trained model for transfer training. If you would like to train your owen dataset, you could skip this step.

Step.5.
Take 500 training steps and 100 evaluation steps for example:
From the Docker .../tensorflow/models/research/ directory
#./retrain_detection_model.sh --num_training_steps 500 --num_eval_steps 100

You could check training status via open a shared container to use Tensorboard.

$sudo nvidia-docker exec -it edgetpu-detect /bin/bash

After get into the container:

#tensorboard --logdir=./learn_pet/train/

For all the time, nvidia-smi is a good tool to help you check your GPUs status.
