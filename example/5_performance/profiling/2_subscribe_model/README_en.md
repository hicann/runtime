## 2_subscribe_model

## Description
This sample demonstrates how to subscribe to operator information. By calling the message subscription interface, you can write the parsed Profiling data to a pipeline after collection, read it into memory by the user, and then call APIs to retrieve performance data. Currently, you can retrieve performance data of operators in the network model, including operator name, operator type name, operator execution time, and so on.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Atlas A3 Training Series Products/Atlas A3 Inference Series Products | Yes |
| Atlas A2 Training Series Products/Atlas A2 Inference Series Products | Yes |

## Build and Run
For environment installation details and runtime details, see [README](../../../README_en.md) in the example directory.

Follow the steps below to run:

```bash
# Replace ${install_root} with the CANN installation root directory, which is installed in `/usr/local/Ascend` by default
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# The run.sh for Profiling samples also reads ASCEND_HOME_PATH, please set it to the same path
export ASCEND_HOME_PATH=${install_root}/cann

# Build and run
bash run.sh
```
## CANN RUNTIME API

In this sample, the key functional points and their key interfaces are as follows:
- Call the aclprofCreateSubscribeConfig interface to create a model subscription configuration and perform model subscription.
- Call the aclprofModelSubscribe interface to perform model subscription.
- Call the aclprofModelUnSubscribe interface to release the model subscription.
- Call the aclprofDestroySubscribeConfig interface to release the config pointer.

## CANN GE API
In this sample, the key functional points related to models and their key interfaces are as follows:
- Call the aclmdlLoadFromFile interface to load a model.
- Call the aclmdlExecute interface to execute a model.

Please refer to [LINK](https://gitcode.com/cann/ge) for model-related processes.

## Known Issues

   None