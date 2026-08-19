# E40023 File\_Operation\_Error\_Invalid\_Path

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: file path, parameter name, result, error cause.

```text
Path %s for %s is invalid. Result: %s. Reason: %s.
```

Error example:

```text
Path /aaa/bbb for --debug_dir is invalid. Result: real path get failed. Reason: the path does not exist or its access permission is denied.
```

## Solution

Please configure the correct path as prompted in the error message.
