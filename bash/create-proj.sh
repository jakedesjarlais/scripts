#!/bin/bash

# Creates a new project folder
#   writes a Generic Makefike\$
#   makes an src, inc, lib, and bin directories
#   writes a generic main.cpp (or .c) under the src dorectory

# TODO: makefile doesnt work for c code of c/c++ code

HELP_MESSAGE="The create-proj creates a c/c++ project skeleton including\n
     - generic Makefile                                                 \n
     - src, bin, inc, and lib folders                                   \n
     - main.cpp file with a basic main function                         \n
                                                                        \n
     create-proj [PROJECT NAME] [-OPTIONS...]                           \n
                                                                        \n
     OPTIONS                                                            \n
        -h To display this message                                      \n
        -d Followed by a directory to specify a directory to            \n 
           create the project under. If left unspecified, the           \n 
           default is the current directory                             \n
        -c Creates a C specific project. The default is C++             \n
           note that C++ project Makefile is compatible with            \n
           C files                                                      \n"

# Display help message
if [ "$1" == -h ] || [ "$1" == --h ] || [ "$1" == -help ] || [ "$1" == --help ]; then
  echo $HELP_MESSAGE
fi
  
# Variable declarations 
PROJ_NAME="$1"
PROJ_DIR=.
Cplusplus=yes

MAKEFILE="##### PROJECT SETTINGS #####
NVCC := nvcc
GCC := g++

CC_FLAGS := -Wall
NVCC_FLAGS := -Wall

PROGRAM := $PROJ_NAME

SRC_DIR := ./src
BIN_DIR := ./bin
INC_DIR := ./inc
LIB_DIR := ./lib
##### PROJECT SETTINGS #####



CC_FLAGS += -I\$(INC_DIR)
NVCC_FLAGS += -I\$(INC_DIR)

EXEC := \$(BIN_DIR)/\$(PROGRAM)
CPP_SRCS := \$(wildcard \$(SRC_DIR)/*.cpp)
CPP_OBJS := \$(patsubst ./src%%, ./bin%%, \$(CPP_SRCS:.cpp=.o))
CPP_INC := \$(wildcard \$(INC_DIR)/*.h)

CU_SRCS := \$(wildcard \$(SRC_DIR)/*.cu)
CU_OBJS := \$(patsubst ./src%%, ./bin%%, \$(CU_SRCS:.cu=.o))
CU_INC := \$(wildcard \$(INC_DIR)/*.cuh)



all: \$(EXEC)

\$(EXEC): \$(CPP_OBJS)
	\$(GCC) \$^ -o \$@

\$(BIN_DIR)/%%.o:\$(SRC_DIR)/%%.cpp \$(CPP_INC) \$(CU_INC)
	\$(GCC) \$(CC_FLAGS) -c \$< -o \$@

\$(BIN_DIR)\%%.o:\$(SRC_DIR)/%%.cu \$(CPP_INC) \$(CU_INC)
	\$(NVCC) \$(NVCC_FLAGS) -c \$< -o \$@



.PHONY: cuda
cuda: \$(CPP_OBJS) \$(CU_OBJS)
	\$(NVCC) -c \$^ -o \$(EXEC)

.PHONY: clean
clean:
	rm -rf \$(EXEC) \$(CPP_OBJS) \$(CU_OBJS)

.PHONY: spotless
spotless: clean
	spotless -r

.PHONY: test
test: all
	\$(EXEC)

#TODO: get working for cuda
.PHONY: gdb
gdb: CC_FLAGS += -g
gdb: NVCC_FLAGS += -g
gdb: all
	gdb \$(EXEC)
"

MAIN_C="
#include <stdio.h>
#include <stdlib.h>

int main(void) {
  pritnf(\"HELLO WORlD!!!\");
  return 0;
}
"

MAIN_CPP="
#include <iostream>
#include <stdlib.h>

int main(void) {
  std::cout << \"HELLO WORLD\" << std::endl;
  return 0;
}
"

# Specify a directory to create the project under
if [ "$2" == -d ]; then
    PROJ_DIR=$3
elif [ "$3" == -d ]; then
    PROJ_DIR=$4
fi

if [ "$2" == -c ]; then
    Cplusplus=no
elif [ "$3" == -c ]; then
    Cplusplus=no
fi

# Create folders for project
mkdir $PROJ_DIR/$PROJ_NAME $PROJ_DIR/$PROJ_NAME/src $PROJ_DIR/$PROJ_NAME/bin $PROJ_DIR/$PROJ_NAME/lib $PROJ_DIR/$PROJ_NAME/inc

# Create and write Makefile and main.cpp
printf "$MAKEFILE" >> $PROJ_DIR/$PROJ_NAME/Makefile
if [ "$Cplusplus" == yes ]; then
    printf "$MAIN_CPP" >> $PROJ_DIR/$PROJ_NAME/src/main.cpp
else
    printf "$MAIN_C" >> $PROJ_DIR/$PROJ_NAME/src/main.c
fi 
