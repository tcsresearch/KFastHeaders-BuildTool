#!/bin/env bash
# KFastHeaders-BuildTool-v2.sh - A tool to buld the kernel-fastheaders project w/ functions and echo output.

# Taken From: https://share.google/aimode/f7uslf6jVOkDBry2z

######################################################################################################################
  # DEFINE DISPLAY FUNCTIONS #                                                                                       #
######################################################################################################################
  
function DisplayBanner() {
  echo "$(basename -- "$0") - A tool to buld the kernel-fastheaders project w/ functions and echo output."
  DisplayLine
  echo "Number Of CPU Cores: $(nproc) "
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
    ### TODO: Perform disk space check first!  Minimum 4.9GB as of Oct 09, 2026.  Boost by 500MB to 1GB to ensure future compatibility with larger bundles.
    echo " Ready to download the kernerl history bundle, which requires a minimum of 5GB dis space and can take 30 minutes based on a 300MB internet speed."
    Pause
    echo "Downloading the bulk of the kernel history via fast CDN..." 
    git clone linux-stable.git.bundle fast-headers-linux
    NewLine

  # Initializes your repository locally from the bundle.
    ### TODO: Perform disk space check first!
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
    ### TODO: Perform disk space check first!
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

function InstallRequiredPackages() {
  # Install Tooling
    ### TODO: Optimize for Fedora / Allow external package lists based on distribution (requires DetectOS function!)
    echo "Installing the required compilers and build essentials..."
    sudo apt install build-essential libncurses-dev bison flex libssl-dev libelf-dev
      # Installs the required compilers and build essentials.
    NewLine
}

function GenerateDefConfig() {
  # Configuration
    echo "Generating a standard default kernel configuration file (.config)..."
    make defconfig
      # Generates a standard default kernel configuration file (.config).
    NewLine
}

  # The Benchmark
  function RunBenchmarkedBuild() {
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
GenerateConfig
# RunBenchmarkedBuild
echo "To compile the kernel, source this file and run the RunBenchmarkedBuild() function."
echo " "


