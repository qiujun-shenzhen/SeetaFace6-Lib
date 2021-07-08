#!/bin/bash

export CC=aarch64-linux-gnu-gcc 
export CXX=aarch64-linux-gnu-g++ 

sudo chmod 777 $(find . -name build.linux.aarch64.sh) -R

#前3为必须模块
dirs="OpenRoleZoo/craft SeetaAuthorize/craft TenniS/craft "
dirs+="FaceAntiSpoofingX6/craft FaceBoxes/craft "
dirs+="FaceRecognizer6/craft FaceTracker6/craft "
dirs+="Landmarker/craft PoseEstimator6/craft "
dirs+="SeetaAgePredictor/craft QualityAssessor3/craft "
dirs+="SeetaEyeStateDetector/craft SeetaGenderPredictor/craft "
dirs+="SeetaMaskDetector/craft "

for dir in $dirs
do 
	if test -d $dir
	then
		echo "$dir"
		cd $dir && ./build.linux.aarch64.sh && cd ../../
	fi
done
