# EE1003 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), parameter value, parameter name, expected value.

```text
%s failed because value %s for parameter %s is invalid. Expected value: %s.
```

Error example:

```text
rtsStreamSetAttribute failed because value -5 for parameter stmAttrId is invalid. Expected value: [0, 5).
```

## Solution

1. Check the input parameter range of the function.
2. Check the function invocation relationship.
