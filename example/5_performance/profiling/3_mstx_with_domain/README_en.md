# 3_mstx_with_domain

## Description

This sample demonstrates how to use mstx interfaces to mark events in the default domain and a custom domain. It also shows how to control the collected domains with the `--mstx-domain-include` and `--mstx-domain-exclude` options of msprof. The sample source file is `mstx_with_domain.cpp` in the current directory, and `run.sh` builds and runs the sample.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

For environment setup and general instructions for running samples, see the [README](../../../README_en.md) in the example directory.

1. Download the sample code to the environment where CANN software is installed. Switch to the sample directory.
```bash
cd ${git_clone_path}/example/5_performance/profiling/3_mstx_with_domain
```

2. Set environment variables.
```bash
# Replace ${install_root} with the CANN installation root. The default installation directory is `/usr/local/Ascend`.
source ${install_root}/cann/set_env.sh
```

3. Verify the msTX dependency.

This sample depends on the MindStudio Tools Extension Library (msTX) component provided with CANN Toolkit. Run the following command to check whether the msTX header required by this sample is available:

```bash
ls -l "${ASCEND_HOME_PATH}/include/mstx/ms_tools_ext.h"
```

If the command displays the file information, the required msTX header is available. If the file does not exist:

- Make sure that `ASCEND_HOME_PATH` points to the actual CANN Toolkit installation directory.
- If msTX is not installed, install a version compatible with the installed CANN version. For download and installation options, see the [MindStudio download page](https://www.hiascend.com/en/developer/software/mindstudio/download).
- To upgrade msTX, see [Upgrade](https://gitcode.com/Ascend/mstx/blob/master/docs/en/install_guide/mstx_install_guide.md#4-upgrade).

After installing or upgrading msTX, run `source ${install_root}/cann/set_env.sh` again to reload the CANN environment variables. Then repeat the check and confirm that `${ASCEND_HOME_PATH}/include/mstx/ms_tools_ext.h` is accessible.

4. Run the following command to execute the sample.
```bash
bash run.sh
```

## msprof Collection

To collect mstx marking data with msprof, run one of the following commands:

```bash
# Collect all marking data, including the default domain and the custom domain.
msprof --msproftx=on bash run.sh

# Collect marking data only from the default domain.
msprof --msproftx=on --mstx-domain-include="default" bash run.sh

# Collect marking data except for the default domain.
msprof --msproftx=on --mstx-domain-exclude="default" bash run.sh
```

The `--mstx-domain-include` and `--mstx-domain-exclude` options are mutually exclusive and cannot be configured together. To specify multiple domains, separate them with commas.

## CANN RUNTIME API

The following key functions and APIs are used in this sample:

- Default domain marking
    - Call `mstxMarkA` to record an instant event in the default domain.
    - Call `mstxRangeStartA` and `mstxRangeEnd` to record a range event in the default domain.
- Custom domain management and marking
    - Call `mstxDomainCreateA` to create a custom domain.
    - Call `mstxDomainMarkA` to record an instant event in the custom domain.
    - Call `mstxDomainRangeStartA` and `mstxDomainRangeEnd` to record a range event in the custom domain.
    - Call `mstxDomainDestroy` to destroy the custom domain.

## Sample Output

```text
[INFO]: AscendHome is set to ...
...
result[0] is: 1.200000
result[1] is: 2.200000
result[2] is: 3.200000
result[3] is: 5.400000
result[4] is: 6.400000
result[5] is: 7.400000
result[6] is: 9.600000
result[7] is: 10.600000
```
