#!/bin/bash

#前3为必须模块
dirs0="OpenRoleZoo SeetaAuthorize TenniS "

dirs="FaceAntiSpoofingX6/FaceAntiSpoofingX FaceBoxes/FaceDetector "
dirs+="FaceRecognizer6/FaceRecognizer FaceTracker6/FaceTracking "
dirs+="Landmarker/Landmarker PoseEstimator6/PoseEstimation "
dirs+="QualityAssessor3/QualityAssessor SeetaAgePredictor/AgePredictor "
dirs+="SeetaEyeStateDetector/EyeStateDetector SeetaGenderPredictor/GenderPredictor "
dirs+="SeetaMaskDetector/MaskDetector "

for dir in $dirs0
do 
	if test -d $dir
	then
		echo "$dir"
		cd $dir/android/jni && ndk-build -j8 && cd ../../../
	fi
done

for dir in $dirs
do 
	if test -d $dir
	then
		echo "$dir"
		cd $dir/android/jni && ndk-build -j8 && cd ../../../../
	fi
done
