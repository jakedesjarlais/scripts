#!/bin/bash


#


if [ "$1" == "h" ] || [ "$1" == "-h" ]; then
	echo "	cuda_a   builds CUDA-A Branch"
	echo "		   -db to specify debug build (default)"
	echo "		   -rel to specifiy release build (default)"
	echo ""	
	echo "	cudart   builds CUDA runtime"
	echo "		   -all to build CUDA runtime, libraries and apps"
	echo "		   -apps to build CUDA apps"
	echo "			   <appName>[.debug|.release|.clean] to build a specific app"
	echo "		   -rt to build CUDA runtime (deault)"
	echo ""	
	echo "	thrust   builds thrust"
	echo "		   -all to build all of thrust"
	echo "		   -unittest to build only the unittests"
	echo "		   -examples to build only the examples"
	echo ""	



elif [ "$1" == "cuda_a" ]; then
	cd /sw/dev/gpu_drv/cuda_a/drivers/gpgpu
	if [ "$#" == "1" ] || [ "$2" == "db" ] || [ "$2" == "-db" ]; then
		echo "Building debug version of CUDA-A branch GPGPU driver..."
		unix-build --tools /sw/tools nvmake linux amd64 debug PAR=12 -j12
		echo "done."
	elif [ "$2" == "rel" ] || [ "$2" == "-rel" ]; then
		echo "Building release version of CUDA-A branch GPGPU driver..."
		unix-build --tools /sw/tools nvmake linux amd64 release PAR=12 -j12	
		echo "done."
	else
		echo "Invalid arguement. -h for help."
	fi 



elif [ "$1" == "cudart" ]; then
	if [ "$#" == "1" ] || [ "$2" == "rt" ] || [ "$2" == "-rt" ]; then
		cd /sw/gpgpu/cuda
		echo "Building CUDA runtime..."
		./../build/make-3.81 -j12 PAR=12
		echo done.
	elif [ "$2" == "all" ] || [ "$2" == "-all" ]; then
		echo "Building CUDA runtime, libraries and apps"
		cd sw/gpgpu
		build/make-3.81 -j12 PAR=12
		echo "done."
	elif [ "$2" == "apps" ] || [ "$2" == "-apps" ]; then
		cd /sw/gpgpu/cuda/apps
		if [ "$#" == "2" ] || [ "$3" == "all" ] || [ "$3" == "-all" ]; then
			echo "Building CUDA apps..."
			./../../build/make-3.81 -j12 PAR=12
		else
			echo "Building app - $3..."
			./../../build/make-3.81 $3 -j12 PAR=12
		fi
		echo "done."
	elif [ "$2" == "clean" ] || [ "$2" == "-clean" ]; then
		cd /sw/gpgpu
		echo "Cleaning CUDA runtime binaries..."
		# TODO: clean runtime binaries from other /sw/gpgpu directories
		rm -r bin
	else 
		echo "Invalid arguement. -h for help."
	fi


elif [ "$1" == "thrust" ]; then
	if [ "$#" == "1" ] || [ "$2" == "all" ] || [ "$2" == "-all" ]; then
		echo "Not yet implemented..."
	elif [ "$2" == "unittest" ] || [ "$2" == "-unittest" ]; then
		echo "Not yet implemented..."
	elif [ "$2" == "ex" ] || [ "$2" == "-ex" ]; then
		cd /sw/gpgpu/thrust
		echo "Building thrust examples..."
		# it highly recomended not to exceed 4 for the -j flag as building thrust uses a lot of ram
		# TODO: will need to change in the future to account for the added examples flag
		make -j4 RELEASE=1 GPGPU_COMPILER_EXPORT=/sw/gpgpu/cudaqa/export/x86_64_Linux_release
		echo "done."
	else 
		echo "Invalid arguement. -h for help."
	fi

else
	echo "Invalid command. -h for help."
fi


