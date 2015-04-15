#!/bin/bash

cd /sw

echo "Syncing perforce workspace..."

export P4CONFIG=.p4config

if [ "$1" == "-f" ] || [ "$2" == "-f" ]; then
	FORCE="-f"
else
	FORCE=""
fi
if [ "$2" == "-par"] || [ "$2" == "-par" ]; then
	PARALLEL="&"
else
	PARALLEL=""
fi

p4 sync $FORCE //sw/apps/...		$PARALLEL
p4 sync $FORCE //sw/automation/...	$PARALLEL
p4 sync $FORCE //sw/cg/...		$PARALLEL
p4 sync $FORCE //sw/compiler/...	$PARALLEL
p4 sync $FORCE //sw/dev/...		$PARALLEL
p4 sync $FORCE //sw/devrel/...		$PARALLEL
p4 sync $FORCE //sw/eris/...		$PARALLEL
p4 sync $FORCE //sw/gpgpu/...		$PARALLEL
p4 sync $FORCE //sw/main/...		$PARALLEL
p4 sync $FORCE //sw/misc/...		$PARALLEL
p4 sync $FORCE //sw/mods/...		$PARALLEL
p4 sync $FORCE //sw/pvt/...		$PARALLEL
p4 sync $FORCE //sw/rel/...		$PARALLEL

p4 sync $FORCE //sw/tools/maven/...		$PARALLEL
p4 sync $FORCE //sw/tools/lpng124/...		$PARALLEL
p4 sync $FORCE //sw/tools/libunwind/...		$PARALLEL
p4 sync $FORCE //sw/tools/eclipse/...		$PARALLEL
p4 sync $FORCE //sw/tools/dita/...		$PARALLEL
p4 sync $FORCE //sw/tools/ant/...		$PARALLEL
p4 sync $FORCE //sw/tools/unix/...		$PARALLEL
p4 sync $FORCE //sw/tools/VRL/...		$PARALLEL
p4 sync $FORCE //sw/tools/zlib112/...		$PARALLEL
p4 sync $FORCE //sw/tools/unix/...		$PARALLEL

p4 sync $FORCE //sw/tools/linux/binutils-2.12/...   		$PARALLEL
p4 sync $FORCE //sw/tools/linux/binutils-2.14.90.0.4-37/...	$PARALLEL
p4 sync $FORCE //sw/tools/linux/cmake-2.6.2/...			$PARALLEL
p4 sync $FORCE //sw/tools/linux/doxygen/...			$PARALLEL
p4 sync $FORCE //sw/tools/linux/g95/...				$PARALLEL
p4 sync $FORCE //sw/tools/linux/gcc-2.95.3/...			$PARALLEL
p4 sync $FORCE //sw/tools/linux/gcc-3.2.3-52/...		$PARALLEL
p4 sync $FORCE //sw/tools/linux/glibc-devel-2.3.2-95.33/...	$PARALLEL
p4 sync $FORCE //sw/tools/linux/libstdc++-devel-3.2.3-52/...	$PARALLEL
p4 sync $FORCE //sw/tools/linux/MiscBuildTools/...		$PARALLEL
p4 sync $FORCE //sw/tools/linux/mk1/...				$PARALLEL
p4 sync $FORCE //sw/tools/linux/nv-rh72/...			$PARALLEL
p4 sync $FORCE //sw/tools/linux/nvcc/...			$PARALLEL
p4 sync $FORCE //sw/tools/linux/perl-5.8.1/...			$PARALLEL
p4 sync $FORCE //sw/tools/linux/python/...			$PARALLEL





































echo "done."
