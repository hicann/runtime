# EH0014 Invalid\_Argument\_Null\_Pointer

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: API name, parameter name.

```text
%s failed because %s cannot be NULL pointers at the same time.
```

Error example:

```text
aclrtFunctionGetParamInfo failed because paramOffset and paramSize cannot be NULL pointers at the same time.
```

## Solution

Try again with correct pointer arguments.
