# EE1024 Execution\_Error\_Stream\_Synchronize\_Timeout

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage, device ID, OOM detection window.

```text
%s failed. Reason: AI CPU operator execution timed out on device %s. In addition, an OOM event occurred on the device within %s seconds.
```

Error example:

```text
Stream synchronize failed. Reason: AI CPU operator execution timed out on device 0. In addition, an OOM event occurred on the device within 10 seconds.
```

## Possible Cause

1. The AI CPU operator may be stuck or fail to respond due to OOM.
2. For a GetNext operator, its preprocessing time may be too long.
3. For a custom operator, it contains an ultra-large loop in the implementation logic or its input and output shapes are too large.
4. The input and output shapes of a built-in operator are too large.

## Solution

1. Check the device memory usage, and reduce the memory occupied by the operator or free unused memory.
2. For a GetNext operator, check its preprocessing or use the aclrtSetOpExecuteTimeOut interface to adjust the timeout.
3. For a custom operator, ensure that the logic design is proper or modify the shape.
4. If the input and output shapes are too large, modify the shape or use the aclrtSetOpExecuteTimeOut interface to adjust the timeout.
