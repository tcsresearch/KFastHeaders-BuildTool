## KFastHeaders-BuildTool - Tool to download and setup kernel-fastheaders

<hr>
  <h3> How to Structure Your Test A/B Comparison </h3>
  <ul>
    <li> <b> 1. Clean state: </b> Always run make mrproper or make clean before changing branches to ensure zero caching interference. </li>
    <li> <b> 2. Test A (Baseline): </b> Checkout a standard mainline branch (e.g., git checkout mainline/master), run make defconfig, and time the build: time make -j$(nproc). </li>
    <li> <b> 3. Test B (Fast Headers): </b> Switch back to your my-fast-headers branch, apply the exact same config, and run time make -j$(nproc). </li>
  </ul>
  <b> Expectation: </b> On a clean build using a heavy configuration, you should see a significant drop in total execution CPU time, as individual .c source files no longer cross-reference tens of thousands of unused legacy lines of code.

<hr>
  <h3> CheckDiskSpaceFree.bfunc: How To Use </h3>

1. Paste the function directly into your terminal, or add it to your ~/.bashrc file for permanent use.
2. Run the function by passing the directory and the minimum required GB:
bash
#### Check if the /var directory has at least 10 GB free
  ```CheckDiskSpaceFree /var 10```

#### Check if the current directory has at least 50 GB free
  ```CheckDiskSpaceFree . 50```

