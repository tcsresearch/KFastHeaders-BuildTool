#!/bin/env bash
# KFastHeaders-BuildTool-v3.sh - A tool to buld the kernel-fastheaders project w/ functions and echo output.

# Taken From: https://share.google/aimode/f7uslf6jVOkDBry2z

######################################################################################################################
  # DEFINE FUNCTIONS AND CONFIGS #                                                                                   #
######################################################################################################################

function Source_Colors_Config() {
  if [ -f "./Colors2.conf" ]; then
      source "./Colors2.conf"
      echo "Success: Colors2.conf has been found and sourced."
  else
      echo "Error: Colors2.conf not found." >&2
  fi
}

function Source_Main_Functions() {
  if [ -f "./KFastHeaders-BuildTool.bfunc" ]; then
      source "./KFastHeaders-BuildTool.bfunc"
      echo "Success: KFastHeaders-BuildTool.bfunc has been found and sourced."
  else
      echo "Error: KFastHeaders-BuildTool.bfunc not found." >&2
  fi
}

function Source_DiskSpace_SanityChecker_Function() {
  if [ -f "./CheckDiskSpaceFree.bfunc" ]; then
      source "./CheckDiskSpaceFree.bfunc"
      echo "Success: CheckDiskSpaceFree.bfunc has been found and sourced."
  else
      echo "Error: CheckDiskSpaceFree.bfunc not found." >&2
  fi
}



#######################################################################################################################
  # MAIN PROGRAM #                                                                                                    #
#######################################################################################################################    

DisplayBanner
Source_Colors_Config
Source_Main_Functions
Source_DiskSpace_SanityChecker_Function
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
