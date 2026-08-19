# E40021 Compilation\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: op name, op path, op type.

```text
Failed to compile Op %s. oppath is %s and optype is %s.
```

Error example:

```text
Failed to compile Op QuantBatchMatmulV3. oppath is /usr/local/Ascend/cann/opp and optype is QuantBatchMatmulV3.
```

## Solution

See the host log for details, and then check the Python stack where the error log is reported.
