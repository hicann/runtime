# Runtime Development Guidelines and Contribution Guide

This directory collects the software design template, coding guidelines, test case guidelines, and code review rules of the Runtime repository. Developers and contributors in the repository use these documents as a unified reference during design, coding, testing, and review.

## Contents

| Document | Content | Applicable scenario |
|------|------|----------|
| [design_document_template.md](design_document_template.md) | Runtime design document template. The template covers interfaces, architecture, document synchronization, and DT check items | When you produce a design proposal, interface design, or feature design |
| [coding-guidelines.md](coding-guidelines.md) | Unified coding guidelines to follow when you implement Runtime code | During daily development, self-check, `/runtime-code-review`, and PR review |
| [ut-coding-guidelines.md](ut-coding-guidelines.md) | Mandatory guidelines for Runtime UT code. The guidelines supplement the constraints at the test implementation level | When you write, modify, or review UT code |
| [Runtime Error Message Development Guide](error_message_guide/README.md) | Unified guidelines for Runtime/ACL Error Message rectification and review. The guidelines cover error code selection, ErrMsg reporting macro selection, error text, and reporting boundaries | When you add or rectify ErrMsg reporting, select EE/EH error codes, optimize error text, or run an ErrMsg self-check or review |
| [DT Case Development Guide](dt_guide/README.md) | Organization, integration process, and general guidelines of UT/ST cases in the Runtime repository | When you add or modify tests |
| [Pre-commit Usage](pre-commit_guide.md) | Runtime pre-commit configuration and usage instructions. The document covers clang-format formatting and OAT compliance check | When you install and run pre-commit before you commit code |

If you need to supplement the Runtime test guidelines, maintain them in this directory first. Do not scatter the rules across scripts, skills, and temporary documents.
