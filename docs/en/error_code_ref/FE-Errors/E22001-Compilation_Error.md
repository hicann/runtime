# E22001 Compilation\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: op name, op type.

```text
Compilation result for operator %s not found. Optype is %s.
```

Error example:

```text
Compilation result for operator QuantBatchMatmulV3 not found. Optype is QuantBatchMatmulV3.
```

## Possible Cause

A segmentation fault occurred in the compilation thread or the main process.

## Solution

Check the process cause of the segmentation fault.
