# E20007 Compilation\_Error\_Execute\_Fusion\_Pass

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: fusion pass name, fusion pass type.

```text
Graph fusion pass %s failed. The pass type is %s.
```

Error example:

```text
Graph fusion pass UserSemanticInferencePass failed. The pass type is built-in-before-transnode-insertion-graph-pass.
```

## Possible Cause

The current scenario is beyond the processing scope of the pass.

## Solution

1. If the pass code is custom, check the implementation logic of the pass.
2. If the pass code is not custom, obtain the host log and contact technical support at https://www.hiascend.com/support.
