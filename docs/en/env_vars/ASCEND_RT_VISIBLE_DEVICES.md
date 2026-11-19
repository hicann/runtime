# ASCEND\_RT\_VISIBLE\_DEVICES

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-22T09:29:33.877Z pushedAt=2026-10-23T08:17:44.185Z -->

## Description

Sets which devices are visible to the current process. One or more device IDs can be specified at a time. This environment variable allows you to adjust the devices in use without modifying the application.

A device ID is the logical ID of an AI processor. For example, if the number of available devices is 8, the device IDs are 0, 1, 2, 3, 4, 5, 6, and 7. The usage scenarios are described as follows:

- If you set "export ASCEND\_RT\_VISIBLE\_DEVICES=1", the current process can use only the device whose ID is 1. The number of obtained devices is 1, and the index value of this device is 0. When specifying a compute device later, use this index value.
- If you set "export ASCEND\_RT\_VISIBLE\_DEVICES=1,2,3", the current process can use only the three devices whose IDs are 1, 2, and 3, respectively. The number of obtained devices is 3, and the index values of these devices are 0, 1, and 2. When specifying compute devices later, use these index values.

    Multiple device IDs are separated by commas (,). No other characters or invalid device IDs are allowed. If other characters or invalid device IDs are included, only the device IDs before the other characters or invalid device IDs are read. For example, if you set "export ASCEND\_RT\_VISIBLE\_DEVICES=1, 2,3", there is a space before 2 in the environment variable setting command, so only the device ID before the space, that is, 1, is read. If you set "export ASCEND\_RT\_VISIBLE\_DEVICES=1,3,8", 8 is an invalid device ID, so only the device IDs before 8, that is, 1 and 3, are read.

>**Caution:**
>
>- This environment variable is a trial environment variable and may change in later versions. It is not supported in production environments.
>- Only device IDs configured in ascending order are supported.
>- This environment variable is not supported when DCMI APIs are used. For details about DCMI APIs, see [DCMI API Reference](https://support.huawei.com/enterprise/en/ascend-computing/ascend-hdk-pid-252764743?category=developer-documents&subcategory=api-reference).
>- This environment variable is not supported when HCCN Tool APIs are used. For details about HCCN Tool APIs, see [HCCN Tool Interface Reference](https://support.huawei.com/enterprise/en/ascend-computing/ascend-hdk-pid-252764743?category=developer-documents&subcategory=interface-reference).
>- This environment variable is not supported when the profiling feature is used.

**Usage scenarios of this environment variable:**

Offline inference program execution scenario.

Scenario where networks of frameworks such as TensorFlow and PyTorch perform training or online inference on the Ascend platform.

## Configuration Example

- Specify a single device ID:

    ```bash
    export ASCEND_RT_VISIBLE_DEVICES=1
    ```

- Specify multiple device IDs:

    ```bash
    export ASCEND_RT_VISIBLE_DEVICES=1,2,3
    ```

## Constraints

For the scenario where a network of a TensorFlow framework performs training or online inference on the Ascend platform, the **ASCEND\_RT\_VISIBLE\_DEVICES** environment variable takes precedence over **ASCEND\_DEVICE\_ID**. If both environment variables are used at the same time, the **ASCEND\_DEVICE\_ID** environment variable can only be set to a device index value in the **ASCEND\_RT\_VISIBLE\_DEVICES** environment variable. Otherwise, the training or inference application may run abnormally.

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
## Supported Models

<!-- npu="950" id2 -->
Ascend 950PR&950DT products
<!-- end id2 -->

<!-- npu="A3" id3 -->
Atlas A3 products
<!-- end id3 -->

<!-- npu="910b" id4 -->
Atlas A2 products
<!-- end id4 -->

<!-- npu="310b" id5 -->
Atlas 200I/500 A2 inference products
<!-- end id5 -->

<!-- npu="310p" id6 -->
Atlas inference products
<!-- end id6 -->

<!-- npu="910" id7 -->
Atlas training products
<!-- end id7 -->
<!-- end id1 -->
