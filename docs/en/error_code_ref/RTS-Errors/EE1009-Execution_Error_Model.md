# EE1009 Execution\_Error\_Model

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: model id, error cause.

```text
Failed to execute model (model_id=%s). Reason: %s.
```

Error example:

```text
Failed to execute model (model_id=63). Reason: The current aclgraph model running instance neither contains any executable task nor contains any executable stream.
```

## Solution

Please adjust the code logic according to the prompts in the Reason.
