#!/bin/bash

docker kill tfserving_cat_classifier
docker rm tfserving_cat_classifier
docker run -p 8501:8501 -d \
    --name tfserving_cat_classifier \
    --mount type=bind,source=$(pwd)/models/cat_classifier_v0_tobivscatflap/saved_model,target=/models/cat_classifier/1/ \
    --mount type=bind,source=$(pwd)/tf_serving_perf_test_classifier/config,target=/config/ \
    -e MODEL_NAME=cat_classifier \
    -t emacski/tensorflow-serving:2.4.1-linux_arm_armv7-a_neon_vfpv4 \
    --enable_batching \
    --batching_parameters_file=/config/batching_config.txt
