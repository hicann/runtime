# EH0006 Not\_Supported

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: feature name or API name, error cause.

```text
%s is not supported. Reason: %s.
```

Error example:

```text
acltdtAddDataItem is not supported. Reason: item cannot be added because internal item already exists.
```

## Solution

Please adjust the code logic according to the prompts in the Reason.
