# Contributing to Flight Crew POC

Thank you for your interest in contributing to the Flight Crew POC! This guide will help you understand how to work with our automated agent system.

## How It Works

This repository uses an automated workflow where AI agents handle the development process from issue to completion.

### The Agent System

1. **Agent 1 (Issue Assignment)** - Assigns GitHub Copilot to ready issues
2. **Agent 2 (PR Monitoring)** - Monitors PRs and manages the merge process

### Workflow Overview

```
1. Create issue → 2. Label "ready" → 3. Agent 1 assigns @copilot → 
4. GitHub Copilot Workspace creates PR and implements → 5. Agent 2 monitors → 
6. Review and iterate → 7. Merge → 8. Issue closed → 9. Dependent issues unblocked
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

### Step 3: Label as "Ready"

When the issue is ready to be worked on, add the `ready` label. This triggers Agent 1 to:
1. Assign @copilot to the issue
2. GitHub Copilot Workspace creates PR and implements changes automatically

## Issue Dependencies

You can create dependencies between issues by adding phrases like:
- `Depends on #123`
- `Blocked by #456`
- `Requires #789`

When the blocking issue is completed and merged, your issue will automatically be labeled "ready" and worked on.

## Working with the Agents

### Agent 1 - Issue Assignment

Agent 1 will:
- Automatically assign @copilot to your issue
- Comment to confirm assignment
- GitHub Copilot Workspace handles PR creation and implementation

### Agent 2 - PR Monitoring

Agent 2 will:
- Monitor the PR created by GitHub Copilot
- Comment on PR status
- Manage issue labels when PR is merged
- Unblock dependent issues

## The Review Process

1. GitHub Copilot Workspace creates and implements the PR
2. Agent 2 monitors the PR status
3. Reviewers provide feedback directly on the PR
4. GitHub Copilot automatically addresses feedback
5. Process repeats until approved
6. When approved:
   - PR is merged
   - Issue is closed and labeled "completed"
   - Dependent issues are unblocked

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
- Skip the ready label (agents won't start)

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

**Remember**: The agents are here to help! Label your issue as `ready` and let the automation handle the rest.
