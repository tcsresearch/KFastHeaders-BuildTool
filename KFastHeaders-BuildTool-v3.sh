#!/bin/env bash
# KFastHeaders-BuildTool-v3.sh - A tool to buld the kernel-fastheaders project w/ functions and echo output.

# Taken From: https://share.google/aimode/f7uslf6jVOkDBry2z

######################################################################################################################
  # DEFINE FUNCTIONS AND CONFIGS #                                                                                   #
######################################################################################################################

CONF_DIR="$(pwd)/config"
FUNC_DIR="$(pwd)/functions"

function Source_Colors_Config() {
  if [ -f "$CONF_DIR"/Colors2.conf ]; then
      source "$CONF_DIR"/Colors2.conf
      echo "Success: $CONF_DIR/Colors2.conf has been found and sourced."
  else
      echo "ERROR: $CONF_DIR/Colors2.conf not found." >&2
  fi
}

function Source_Main_Functions() {
  if [ -f "$FUNC_DIR"/KFastHeaders-BuildTool.bfunc ]; then
      source "$FUNC_DIR"/KFastHeaders-BuildTool.bfunc
      echo "Success: $FUNC_DIR/KFastHeaders-BuildTool.bfunc has been found and sourced."
  else
      echo "ERROR: $FUNC_DIR/KFastHeaders-BuildTool.bfunc not found." >&2
  fi
}

function Source_DiskSpace_SanityChecker_Function() {
  if [ -f "$FUNC_DIR"/CheckDiskSpaceFree.bfunc ]; then
      source "$FUNC_DIR"/CheckDiskSpaceFree.bfunc
      echo "Success: $FUNC_DIR/CheckDiskSpaceFree.bfunc has been found and sourced."
  else
      echo "ERROR: $FUNC_DIR/CheckDiskSpaceFree.bfunc not found." >&2
  fi
}



#######################################################################################################################
  # MAIN PROGRAM #                                                                                                    #
#######################################################################################################################    

Source_Colors_Config
Source_Main_Functions
Source_DiskSpace_SanityChecker_Function

DisplayBanner
Pause

### Step 1 ###
NewLineCinema
Run_Step_1
Pause

### Step 2 ###
NewLineCinema
Run_Step_2
Pause

### Step 3 ###
NewLineCinema
# InstallRequiredPackages
GenerateDefConfig
# RunBenchmarkedBuild
echo "To compile the kernel, source this file and run the RunBenchmarkedBuild() function."
echo " "
