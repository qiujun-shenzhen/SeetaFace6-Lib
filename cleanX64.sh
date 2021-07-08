#!/bin/bash

#前3为必须模块
dirs="OpenRoleZoo/craft SeetaAuthorize/craft TenniS/craft "
dirs+="FaceAntiSpoofingX6/craft FaceBoxes/craft "
dirs+="FaceRecognizer6/craft FaceTracker6/craft "
dirs+="Landmarker/craft PoseEstimator6/craft "
dirs+="QualityAssessor3/craft SeetaAgePredictor/craft "
dirs+="SeetaEyeStateDetector/craft SeetaGenderPredictor/craft "
dirs+="SeetaMaskDetector/craft "

for dir in $dirs
do 
	if test -d $dir
	then
		echo "$dir"
		cd $dir && rm build.linux.x64 -r && cd ../../
	fi
done
