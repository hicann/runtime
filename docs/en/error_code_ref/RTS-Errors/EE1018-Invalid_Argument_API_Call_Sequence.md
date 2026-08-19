# EE1018 Invalid\_Argument\_API\_Call\_Sequence

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), error cause.

```text
%s failed. Reason: %s.
```

Error example:

```text
rtsLabelSet failed. Reason: The label cannot be set repeatedly.
```

## Solution

Please locate the issue based on the prompts in the error message.
