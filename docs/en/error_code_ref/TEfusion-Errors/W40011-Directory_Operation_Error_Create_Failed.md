# W40011 Directory\_Operation\_Error\_Create\_Failed

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: directory, result, error cause.

```text
Failed to create disk cache directory %s. Result: %s. Reason: %s.
```

Error example:

```text
Failed to create disk cache directory /root. Result: unable to copy files to npu path. Reason: path is invalid.
```

## Possible Cause

You do not have the permission for the directory or the directory name is invalid.

## Solution

Modify the permission or directory name and try again.
