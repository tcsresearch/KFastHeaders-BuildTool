#!/bin/env bash
# KFastHeaders-BuildTool-v2.sh - A tool to buld the kernel-fastheaders project w/ functions and echo output.

# Taken From: https://share.google/aimode/f7uslf6jVOkDBry2z

######################################################################################################################
  # DEFINE FUNCTIONS #                                                                                               #
######################################################################################################################
  
function DisplayBanner() {
  echo "$(basename -- "$0") - A tool to buld the kernel-fastheaders project w/ functions and echo output."
  echo " "
}

function NewLine() {
  echo " "
}

function DisplayLine() {
  echo "--------------------------------------------------------------------------------------------"
}

function NewLineCinema() {
  NewLine
  DisplayLine
  NewLine
}

function Pause() {
  read -rsn1 -p "Press any key to continue..."
echo "" # Adds a newline since the keypress won't create one
}


######################################################################################################################
  # Step 1: Optimized Git Clone via CDN Bundle #                                                                     #
######################################################################################################################

function Run_Step_1() {
  # Downloads the bulk of the kernel history via fast CDN.
    echo "Downloading the bulk of the kernel history via fast CDN..." 
    git clone linux-stable.git.bundle fast-headers-linux
    NewLine

  # Initializes your repository locally from the bundle.
    echo "Initializing your repository locally from the bundle..."
    git clone linux-stable.git.bundle fast-headers-linux
    NewLine

  # Moves into the directory and cleans up the bundle archive.
    echo "Moving into the directory and cleaning up the bundle archive..."
    cd fast-headers-linux && rm ../linux-stable.git.bundle
    NewLine
    
  # Points your main origin to Ingo Molnar’s tip.git tree.
    echo "Pointing your main origin to Ingo Molnar’s tip.git tree..."
    git remote set-url origin git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
    NewLine
    
  # Optional: Adds Linus Torvalds' mainline tree as a reference point.
    echo "Optional: Adding Linus Torvalds' mainline tree as a reference point..."
    git remote add mainline https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    NewLine
    
  # Fetches the specific experimental fast-header branches.
    echo "Fetching the specific experimental fast-header branches..."
    git fetch origin
    NewLine
}

 ######################################################################################################################
  # Step 2: Checkout the Fast-Headers Branch #                                                                        #
#######################################################################################################################

function Run_Step_2() {
  # To see available header branches:
    echo "Displaying available header branches..."
    git branch -r | grep origin/headers
    NewLine
  
  # Track and switch to the primary dependency-cleanup branch (usually headers/deps):
    echo "Tracking and switching to the primary dependency-cleanup branch (usually headers/deps)..."
    git checkout -b my-fast-headers origin/headers/deps
    NewLine
}

#######################################################################################################################
  # Step 3: Configure and Baseline Test #                                                                             #
#######################################################################################################################
  # To truly test "Fast Headers," you want to compare compilation times against standard kernel headers.

function Run_Step_3() {
  # Install Tooling
    echo "Installing the required compilers and build essentials..."
    sudo apt install build-essential libncurses-dev bison flex libssl-dev libelf-dev
      # Installs the required compilers and build essentials.
    NewLine

  # Configuration
    echo "Generating a standard default kernel configuration file (.config)..."
    make defconfig
      # Generates a standard default kernel configuration file (.config).
    NewLine

  # The Benchmark
    echo "Compiles the kernel using all available CPU threads (-j) while tracking execution time..."
    time make -j"$(nproc)"
      # Compiles the kernel using all available CPU threads (-j) while tracking execution time.
    NewLine
}


#######################################################################################################################
  # MAIN PROGRAM #                                                                                                    #
#######################################################################################################################    

DisplayBanner
Pause

NewLineCinema
Run_Step_1
Pause

NewLineCinema
Run_Step_2
Pause

NewLineCinema
Run_Step_3


