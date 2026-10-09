# KFastHeaders-BuildTool
Tool to download and setup kernel-fastheaders


<hr>
  <h4> How to Structure Your Test A/B Comparison </h4>
  <ul>
    <li> <b> 1. Clean state: </b> Always run make mrproper or make clean before changing branches to ensure zero caching interference. </li>
    <li> <b> 2. Test A (Baseline): </b> Checkout a standard mainline branch (e.g., git checkout mainline/master), run make defconfig, and time the build: time make -j$(nproc). </li>
    <li> <b> 3. Test B (Fast Headers): </b> Switch back to your my-fast-headers branch, apply the exact same config, and run time make -j$(nproc). </li>
  </ul>
  <b> Expectation: </b> On a clean build using a heavy configuration, you should see a significant drop in total execution CPU time, as individual .c source files no longer cross-reference tens of thousands of unused legacy lines of code.
