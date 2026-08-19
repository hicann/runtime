# EH0004 File\_Operation\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: file path, error cause.

```text
File %s is invalid. Reason: %s.
```

Error example:

```text
File /home/acl.json is invalid. Reason: config content differs from the first aclInit config file path: /etc/acl.json.
```

## Solution

Please check whether the file content is correct based on the error message.
