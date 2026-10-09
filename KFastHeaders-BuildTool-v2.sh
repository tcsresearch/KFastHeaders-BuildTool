#!/bin/env bash
# KFastHeaders-BuildTool-v2.sh - A tool to buld the kernel-fastheaders project w/ functions and echo output.

# Taken From: https://share.google/aimode/f7uslf6jVOkDBry2z

######################################################################################################################
  # DEFINE FUNCTIONS #                                                                                               #
######################################################################################################################
  
function Pause() {
  read -rsn1 -p "Press any key to continue..."
echo "" # Adds a newline since the keypress won't create one
}


######################################################################################################################
  # Step 1: Optimized Git Clone via CDN Bundle #                                                                     #
######################################################################################################################

function Run_Step_1() {
  # Downloads the bulk of the kernel history via fast CDN.
    git clone linux-stable.git.bundle fast-headers-linux

  # Initializes your repository locally from the bundle.
    git clone linux-stable.git.bundle fast-headers-linux

  # Moves into the directory and cleans up the bundle archive.
    cd fast-headers-linux && rm ../linux-stable.git.bundle

  # Points your main origin to Ingo Molnar’s tip.git tree.
    git remote set-url origin git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git

  # Optional: Adds Linus Torvalds' mainline tree as a reference point.
    git remote add mainline https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

  # Fetches the specific experimental fast-header branches.
    git fetch origin
}

 ######################################################################################################################
  # Step 2: Checkout the Fast-Headers Branch #                                                                        #
#######################################################################################################################

function Run_Step_2() {
  # To see available header branches:
    git branch -r | grep origin/headers

  # Track and switch to the primary dependency-cleanup branch (usually headers/deps):
    git checkout -b my-fast-headers origin/headers/deps
}

#######################################################################################################################
  # Step 3: Configure and Baseline Test #                                                                             #
#######################################################################################################################
  # To truly test "Fast Headers," you want to compare compilation times against standard kernel headers.

function Run_Step_3() {
  # Install Tooling
    sudo apt install build-essential libncurses-dev bison flex libssl-dev libelf-dev
      # Installs the required compilers and build essentials.

  # Configuration
    make defconfig
      # Generates a standard default kernel configuration file (.config).

  # The Benchmark
    time make -j"$(nproc)"
      # Compiles the kernel using all available CPU threads (-j) while tracking execution time.
}


#######################################################################################################################
  # How to Structure Your Test A/B Comparison #                                                                       #
#######################################################################################################################    

  # 1. Clean state: Always run make mrproper or make clean before changing branches to ensure zero caching interference.
  # 2. Test A (Baseline): Checkout a standard mainline branch (e.g., git checkout mainline/master), run make defconfig, and time the build: time make -j$(nproc).
  # 3. Test B (Fast Headers): Switch back to your my-fast-headers branch, apply the exact same config, and run time make -j$(nproc).
  # Expectation: On a clean build using a heavy configuration, you should see a significant drop in total execution CPU time, as individual .c source files no longer cross-reference tens of thousands of unused legacy lines of code.
