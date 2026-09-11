# fault_tolerant_exec

This directory focuses on failure diagnosis, recovery, and degradation handling in fault-tolerant execution scenarios.

## Sample List

- [0_model_task_fallback](./0_model_task_fallback/README_en.md): Identifies model tasks, switches the main task to backup input, disables optional post-processing, and verifies the fallback output.

## Key Points

- Recovery process after failure detection.
- Scenario-based usage linked with reliability topics.
- Combination of exception callbacks, state detection, and recovery strategies.

## Prerequisites

- [../../4_reliability/README_en.md](../../4_reliability/README_en.md)
- [../../2_advanced_features/callback/2_callback_exception/README_en.md](../../2_advanced_features/callback/2_callback_exception/README_en.md)
- [../../0_quickstart/1_error_handling/README_en.md](../../0_quickstart/1_error_handling/README_en.md)
