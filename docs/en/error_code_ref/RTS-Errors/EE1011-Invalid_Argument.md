# EE1011 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), parameter value, parameter name, expected value.

```text
%s failed. Value %s for parameter %s is invalid. Reason: %s.
```

Error example:

```text
StreamSwitchN failed. Value 0 for parameter stm->modelNum is invalid. Reason: The stream is not bound to a model.
```

## Solution

1. Check the input parameter range of the function.
2. Check the function invocation relationship.
