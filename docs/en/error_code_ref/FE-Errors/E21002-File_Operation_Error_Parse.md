# E21002 File\_Operation\_Error\_Parse

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: file name, error cause.

```text
Failed to parse file %s. Reason: %s.
```

Error example:

```text
Failed to parse file /home/pb/support_errmsg_check.pb. Reason: The configuration file is not in JSON format or its content is invalid.
```

## Possible Cause

File configuration path does not exist.

## Solution

Configure the file path correctly.
