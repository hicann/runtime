# EE1022 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), parameter value, parameter name, error cause.

```text
%s failed. Values %s for parameters %s are invalid. Reason: %s.
```

Error example:

```text
MemGetAddressRange failed. Values nullptr and nullptr for parameters pbase and psize are invalid. Reason: Parameters pbase and psize cannot both be nullptr.
```

## Solution

1. Check the input parameter value ranges of the function.

2. Check the function invocation relationship.
