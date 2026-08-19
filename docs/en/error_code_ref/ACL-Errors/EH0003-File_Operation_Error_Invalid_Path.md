# EH0003 File\_Operation\_Error\_Invalid\_Path

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: file path, error cause.

```text
Path %s is invalid. Reason: %s.
```

Error example:

```text
Path /tmp/invalid.json is invalid. Reason: file open failed.
```

## Solution

Please check whether the file exists based on the error message.
