# Contributing to Flight Crew POC

Thank you for your interest in contributing to the Flight Crew POC! This guide will help you understand how to work with our automated agent system.

## How It Works

This repository uses an automated workflow where AI agents handle the development process from issue to completion.

### The Agent System

1. **Agent 1 (Issue Assignment)** - Assigns GitHub Copilot to dependent issues when their dependencies are completed
2. **Agent 2 (PR Review and Merge)** - Reviews PRs, provides feedback when needed, and manages the merge process

### Workflow Overview

```
1. Create issue → 2. Label "ready" and assign to @copilot → 
3. GitHub Copilot Workspace creates PR and implements → 4. Agent 2 reviews and provides feedback if needed → 
5. Iterate if needed → 6. Agent 2 merges → 7. Issue closed → 8. Dependent issues unblocked and assigned
```

## Creating Issues

### Step 1: Choose a Template

We provide two issue templates:
- **Feature Request** - For new features
- **Bug Fix** - For bug reports

### Step 2: Fill in Details

Provide clear, specific information:
- **Description**: What needs to be done?
- **Requirements**: Specific requirements or acceptance criteria
- **Dependencies**: Other issues that must be completed first (optional)

### Step 3: Label and Assign

When the issue is ready to be worked on:
1. Add the `ready` label
2. Manually assign **@copilot** to the issue (click Assignees → type "copilot")
3. GitHub Copilot Workspace creates PR and implements changes automatically

> **Note:** For the first issue in a dependency chain, you must manually assign @copilot. Dependent issues will be automatically assigned when their dependencies are completed.

## Issue Dependencies

You can create dependencies between issues by adding phrases like:
- `Depends on #123`
- `Blocked by #456`
- `Requires #789`

When the blocking issue is completed and merged, your issue will automatically be labeled "ready" and assigned to @copilot.

## Working with the Agents

### Agent 1 - Issue Assignment

Agent 1 will:
- Automatically assign @copilot to dependent issues when their dependencies are completed
- Comment to confirm assignment
- GitHub Copilot Workspace handles PR creation and implementation

### Agent 2 - PR Review and Merge

Agent 2 will:
- Review the PR created by GitHub Copilot
- Provide feedback by tagging @copilot if improvements are needed
- Merge the PR to develop when everything looks good
- Manage issue labels when PR is merged
- Unblock dependent issues by labeling them "ready" and assigning @copilot

## The Review Process

1. GitHub Copilot Workspace creates and implements the PR
2. Agent 2 reviews the PR and provides feedback if improvements are needed
3. If feedback is provided, GitHub Copilot automatically addresses it
4. Process repeats until everything looks good
5. When ready:
   - Agent 2 merges the PR to develop
   - Issue is closed and labeled "completed"
   - Dependent issues are unblocked and assigned to @copilot

## Best Practices

### Writing Good Issues

✅ **DO:**
- Be specific and clear about requirements
- Break down complex features into smaller issues
- Use dependencies to manage order of work
- Include examples or references when helpful

❌ **DON'T:**
- Create vague or ambiguous issues
- Bundle multiple unrelated changes in one issue
- Skip the ready label or @copilot assignment (agents won't start)

### Example Good Issue

```markdown
Title: Add user authentication API

Description:
Implement JWT-based authentication API endpoints for user login and registration.

Requirements:
- POST /api/auth/register - Create new user account
- POST /api/auth/login - Authenticate and return JWT token
- POST /api/auth/refresh - Refresh expired tokens
- Use bcrypt for password hashing
- Return 401 for invalid credentials

Depends on #42

Additional Context:
Follow the authentication pattern established in PR #38.
```

## Monitoring Progress

You can track progress by:
1. Watching the PR comments from agents
2. Checking the issue comments for status updates
3. Viewing the Actions tab for workflow runs
4. Looking at PR reviews from Agent 2

## Manual Intervention

While the system is automated, you can still:
- Comment on PRs to provide additional context
- Review the code yourself
- Approve or request changes manually
- Add labels or update issue status

The agents will respect manual actions and adjust accordingly.

## Troubleshooting

### Issue Not Being Worked On

Check:
- Is the `ready` label applied?
- Is @copilot assigned to the issue?
- Are all dependencies completed?
- Check the Actions tab for workflow errors

### PR Not Being Reviewed

Check:
- Did the PR creation workflow complete successfully?
- Are there any merge conflicts?
- Check the Actions tab for the review workflow

### Changes Not Being Addressed

Check:
- Was @copilot mentioned in the review comment?
- Check the Actions tab for the feedback workflow
- Verify the PR is still open

## Getting Help

If you encounter issues:
1. Check the [README](README.md) for documentation
2. Review the [GitHub Discussions](https://github.com/look-itsaxiom/flight-crew-poc/discussions)
3. Check workflow runs in the Actions tab
4. Create a new issue describing the problem

## Repository Structure

```
.github/
├── workflows/
│   ├── agent-1-issue-completion.yml    # Creates PRs for ready issues
│   ├── agent-1-address-feedback.yml    # Handles review feedback
│   ├── agent-2-pr-review.yml           # Reviews PRs
│   └── agent-2-pr-merge.yml            # Manages merges and dependencies
├── agents/
│   ├── agent-1-instructions.md         # Agent 1 guidelines
│   └── agent-2-instructions.md         # Agent 2 guidelines
└── ISSUE_TEMPLATE/
    ├── feature_request.yml             # Feature issue template
    ├── bug_fix.yml                     # Bug issue template
    └── config.yml                      # Template configuration
```

## Future Improvements

We're continuously improving the system. If you have ideas for enhancements, please create a feature request issue!

---

**Remember**: Label your issue as `ready`, assign it to @copilot, and let the automation handle the rest!
