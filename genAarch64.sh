#!/bin/bash

dirs="OpenRoleZoo/craft SeetaAuthorize/craft TenniS/craft "
dirs+="FaceAntiSpoofingX6/craft FaceBoxes/craft "
dirs+="FaceRecognizer6/craft FaceTracker6/craft "
dirs+="Landmarker/craft PoseEstimator6/craft "
dirs+="QualityAssessor3/craft SeetaAgePredictor/craft "
dirs+="SeetaEyeStateDetector/craft SeetaGenderPredictor/craft "
dirs+="SeetaMaskDetector/craft "

for dir in $dirs
do 
	echo "$dir"
	cd $dir 
	cp ./build.linux.x64.sh ./build.linux.aarch64.sh
	sed -i "s/x64/aarch64/" ./build.linux.aarch64.sh
	cd ../../
done
