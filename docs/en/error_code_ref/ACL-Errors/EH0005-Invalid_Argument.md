# EH0005 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: parameter name, error cause.

```text
AIPP argument %s is invalid. Reason: %s.
```

Error example:

```text
AIPP argument batch_index is invalid. Reason: batch_index 3 is greater than or equal to batch_number 2.
```

## Solution

Please adjust the parameter value based on the prompts in the error message.
