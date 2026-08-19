# EH0007 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), parameter value, parameter name, expected value.

```text
%s failed because value %s for parameter %s is invalid. Expected value: %s.
```

Error example:

```text
aclrtMemcpyKindTranslate failed because value ACL_MEMCPY_INNER_DEVICE_TO_DEVICE for parameter kind is invalid. Expected value: ACL_MEMCPY_HOST_TO_DEVICE
```

## Solution

1. Check the input parameter range of the function.
2. Check the function invocation relationship.
