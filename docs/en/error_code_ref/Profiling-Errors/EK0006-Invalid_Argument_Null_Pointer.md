# EK0006 Invalid\_Argument\_Null\_Pointer

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: API name, parameter name.

```text
%s failed because parameter %s cannot be a null pointer.
```

Error example:

```text
aclprofDestroyConfig failed because parameter profilerConfig cannot be a null pointer.
```

## Solution

The parameter value is a null pointer. Please modify the corresponding parameter value as prompted in the error message.
