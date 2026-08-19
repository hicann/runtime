# E20001 Compilation\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: op name, op type.

```text
Operator %s compilation failed. Optype is %s.
```

Error example:

```text
Operator QuantBatchMatmulV3 compilation failed. Optype is QuantBatchMatmulV3.
```

## Possible Cause

1. The operator has an invalid argument.
2. The operator implementation logic is abnormal.

## Solution

For a custom operator, check the operator implementation and arguments based on the error log. For a Huawei built-in operator, obtain the host log and contact technical support at https://www.hiascend.com/support.
