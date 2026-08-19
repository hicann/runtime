# EE1023 Resource\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), error cause.

```text
%s failed. Reason: %s.
```

Error example:

```text
Expanding the capacity failed. Reason: The number of asynchronous copy tasks in the ACL graph is too large. 1. If the value of numBatches transferred by aclrtMemcpyBatchAsync in the ACL Graph is too large, reduce the value of numBatches. 2. If the height transferred by aclrtMemcpy2dAsync in the ACL graph is too large, reduce the height.
```

## Solution

For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
