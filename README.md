# Flight Crew POC

A proof of concept for a GitHub native issue completion agent system that can handle complex projects from issue creation to completion through automated agents.

## Overview

This system implements an automated workflow where GitHub Issues are automatically worked on by AI agents that create PRs, review code, address feedback, and manage dependencies between issues.

## Workflow

The system uses two main agents that work together:

### Agent 1 - Issue Completion Agent
Automatically implements solutions for issues labeled as "ready"

### Agent 2 - PR Review Agent
Reviews PRs, provides feedback, and manages the merge process

## Complete Workflow Example

1. **Issue A labeled "ready"** 
   - Agent 1 creates a branch `copilot/issue-{number}`
   - Agent 1 opens a PR with @copilot mention
   - Copilot implements the changes

2. **Agent 2 reviews the PR**
   - Automatically triggered when PR is opened/updated
   - Requests Copilot to review code quality and correctness

3. **Two possible paths:**

   **Path A - Changes Requested:**
   - Agent 2 comments with specific feedback and tags @copilot
   - Agent 1 workflow triggers to acknowledge feedback
   - Copilot addresses the feedback
   - Process repeats until approved

   **Path B - Approved:**
   - PR is approved and merged
   - Agent 2 closes Issue A
   - Agent 2 adds "completed" label to Issue A
   - Agent 2 removes "ready" label from Issue A
   - Agent 2 checks for dependent issues
   - If Issue B was blocked by Issue A, it gets labeled "ready"
   - Agent 1 automatically starts working on Issue B

## GitHub Actions Workflows

### 1. `agent-1-issue-completion.yml`
**Trigger:** Issue labeled with "ready"

**Actions:**
- Checks if PR already exists for this issue
- Creates a new branch `copilot/issue-{number}`
- Opens a PR with @copilot mention to implement the issue

### 2. `agent-2-pr-review.yml`
**Trigger:** PR opened, updated, or reopened

**Actions:**
- Retrieves PR details and changed files
- If no changes: requests changes
- If changes present: requests Copilot to review the code
- Checks if PR is ready to merge based on approvals

### 3. `agent-1-address-feedback.yml`
**Trigger:** PR review comments mentioning @copilot

**Actions:**
- Detects feedback from Agent 2
- Acknowledges the feedback
- Triggers Copilot to address the requested changes

### 4. `agent-2-pr-merge.yml`
**Trigger:** PR closed (merged)

**Actions:**
- Extracts linked issue number from PR
- Closes the completed issue
- Adds "completed" label
- Removes "ready" label
- Scans all open issues for dependencies
- Unblocks dependent issues by labeling them "ready"

## Issue Dependency Management

Issues can declare dependencies using these patterns in their description:
- `Depends on #123`
- `Blocked by #123`
- `Requires #123`

When an issue is completed:
1. The system finds all issues that depend on it
2. Checks if all dependencies for those issues are now resolved
3. Automatically labels them as "ready" to start the workflow

## Setup Instructions

1. **Labels Required:**
   Create these labels in your repository:
   - `ready` - Issue is ready to be worked on
   - `completed` - Issue has been successfully completed

2. **Permissions:**
   The workflows require these permissions (already configured):
   - `contents: write` - To create branches and commits
   - `issues: write` - To update issue labels and comments
   - `pull-requests: write` - To create and manage PRs

3. **Using the System:**
   - Create an issue describing what needs to be done
   - Add the `ready` label to start the automated workflow
   - The agents will handle the rest!

## Example Issue

```markdown
Title: Add user authentication feature

Description:
Implement user authentication with email and password.

Requirements:
- Add login endpoint
- Add registration endpoint
- Store passwords securely (hashed)
- Add session management

Depends on #5
```

When issue #5 is completed, this issue will automatically be labeled "ready" and worked on.

## Agent Instructions

Detailed instructions for each agent can be found in:
- `.github/agents/agent-1-instructions.md` - Issue Completion Agent
- `.github/agents/agent-2-instructions.md` - PR Review Agent

## Benefits

✅ Automated issue-to-PR workflow
✅ Automatic code review process  
✅ Dependency management between issues
✅ Continuous feedback loop between agents
✅ Reduces manual project management overhead
✅ Ensures consistent review process

## Architecture

```
Issue (ready) 
    ↓
[Agent 1] Creates PR → Copilot implements
    ↓
[Agent 2] Reviews PR
    ↓
Changes needed? → @copilot → [Agent 1] Addresses feedback
    ↓                              ↓
    No                            Yes → Loop back to review
    ↓
[Agent 2] Merges PR
    ↓
Issue labeled "completed"
    ↓
Dependent issues labeled "ready"
    ↓
Cycle continues...
```

## Future Enhancements

- [ ] Add support for multiple reviewers
- [ ] Implement priority queue for issues
- [ ] Add metrics and dashboards
- [ ] Support for sub-tasks within issues
- [ ] Integration with project boards
- [ ] Notification system for stakeholders