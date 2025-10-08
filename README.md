# Flight Crew POC

A proof of concept for a GitHub native issue completion agent system that can handle complex projects from issue creation to completion through automated agents.

> **🚀 New here?** Check out the [Quick Start Guide](QUICKSTART.md) to get up and running in 5 minutes!
> 
> **📦 Starting a new project?** Use this repository as a [GitHub template](#using-as-a-template)!
> 
> **🔧 Existing project?** [Install Flight Crew](#installing-into-existing-projects) with one command!

## Table of Contents

- [Overview](#overview)
- [Using as a Template](#using-as-a-template)
- [Installing into Existing Projects](#installing-into-existing-projects)
- [Workflow](#workflow)
- [GitHub Actions Workflows](#github-actions-workflows)
- [Issue Dependency Management](#issue-dependency-management)
- [Setup Instructions](#setup-instructions)
- [Configuration](#configuration)
- [Example Issue](#example-issue)
- [Agent Instructions](#agent-instructions)
- [Benefits](#benefits)
- [Architecture](#architecture)
- [Documentation](#documentation)

## Overview

This system implements an automated workflow where GitHub Issues are automatically worked on by AI agents that create PRs, review code, address feedback, and manage dependencies between issues.

## Using as a Template

**For new projects**, use this repository as a GitHub template:

1. Click the **"Use this template"** button at the top of this repository
2. Create your new repository
3. Configure `.flight-crew.yml` with your target branch (default: `develop`)
4. Create the `ready` and `completed` labels
5. Create your target branch (`develop` or `staging`)
6. Start creating issues!

See [TEMPLATE_SETUP.md](TEMPLATE_SETUP.md) for detailed instructions.

## Installing into Existing Projects

**For existing projects**, install Flight Crew with one command:

```bash
curl -fsSL https://raw.githubusercontent.com/look-itsaxiom/flight-crew-poc/main/install.sh | bash
```

This will:
- ✅ Add all workflow files
- ✅ Add agent instructions
- ✅ Add issue templates
- ✅ Add configuration file
- ✅ Preserve your existing files

After installation:
1. Edit `.flight-crew.yml` to set your target branch
2. Create required labels
3. Commit and push the changes

See [TEMPLATE_SETUP.md](TEMPLATE_SETUP.md) for detailed installation instructions and troubleshooting.

### Ejecting from Flight Crew

Changed your mind? Remove Flight Crew completely:

```bash
curl -fsSL https://raw.githubusercontent.com/look-itsaxiom/flight-crew-poc/main/eject.sh | bash
```

See [TEMPLATE_SETUP.md](TEMPLATE_SETUP.md) for details.

## Workflow

The system uses two main agents that work together:

### Agent 1 - Issue Assignment Agent
Assigns GitHub Copilot to issues labeled as "ready"

### Agent 2 - PR Monitoring Agent
Monitors PRs created by GitHub Copilot and provides status updates

## Complete Workflow Example

1. **Issue A labeled "ready"** 
   - Agent 1 assigns @copilot to the issue
   - GitHub Copilot Workspace automatically creates a PR and implements the changes

2. **Agent 2 monitors the PR**
   - Automatically triggered when PR is opened/updated
   - Comments on PR status (changes detected or waiting for changes)
   - GitHub Copilot handles its own review and iteration

3. **Two possible paths:**

   **Path A - Changes Requested:**
   - Reviewers comment with specific feedback
   - GitHub Copilot automatically addresses the feedback
   - Process repeats until approved

   **Path B - Approved:**
   - PR is approved and merged
   - Agent 2 closes Issue A
   - Agent 2 adds "completed" label to Issue A
   - Agent 2 removes "ready" label from Issue A
   - Agent 2 checks for dependent issues
   - If Issue B was blocked by Issue A, it gets labeled "ready"
   - Agent 1 automatically assigns Copilot to Issue B

## GitHub Actions Workflows

### 1. `agent-1-issue-completion.yml`
**Trigger:** Issue labeled with "ready"

**Actions:**
- Assigns @copilot to the issue
- GitHub Copilot Workspace handles PR creation and implementation automatically

### 2. `agent-2-pr-review.yml`
**Trigger:** PR opened, updated, or reopened

**Actions:**
- Retrieves PR details and changed files
- Comments on PR status (changes detected or waiting)
- GitHub Copilot handles its own reviews and iterations

### 3. `agent-1-address-feedback.yml`
**Trigger:** PR review comments mentioning @copilot

**Actions:**
- Acknowledges feedback received
- GitHub Copilot automatically addresses feedback through Workspace

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
   - `issues: write` - To update issue labels, assignments, and comments
   - `pull-requests: write` - To manage PRs
   - `contents: read` - To read repository content

3. **Target Branch:**
   GitHub Copilot Workspace will determine the target branch automatically based on your repository configuration.
   You may want to configure branch protection rules:
   ```bash
   # Optional: Create a develop branch for staging
   git checkout -b develop
   git push -u origin develop
   ```

4. **Using the System:**
   - Create an issue describing what needs to be done
   - Add the `ready` label to start the automated workflow
   - The agents will handle the rest!

## Configuration

Flight Crew is configured via `.flight-crew.yml` in your repository root:

```yaml
# Labels used by the system
labels:
  ready: ready
  completed: completed
```

### Configuration Notes

**Simplified Configuration**: With GitHub Copilot Workspace handling PR creation, the system no longer requires branch prefix or target branch configuration. GitHub Copilot will automatically determine the appropriate branch based on your repository setup.

**Branch Protection (Recommended)**:
- Configure branch protection rules in your repository settings
- Require reviews for merges to `main` branch
- Consider using a `develop` or staging branch for testing

See [TEMPLATE_SETUP.md](TEMPLATE_SETUP.md) for detailed configuration options.

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
[Agent 1] Assigns @copilot to issue
    ↓
GitHub Copilot Workspace creates PR and implements
    ↓
[Agent 2] Monitors PR status
    ↓
Changes needed? → Reviewers comment → Copilot addresses feedback
    ↓                                          ↓
    No                                        Yes → Loop back
    ↓
PR approved and merged
    ↓
[Agent 2] Closes issue and labels "completed"
    ↓
Dependent issues labeled "ready"
    ↓
Cycle continues...
```

## Documentation

- **[QUICKSTART.md](QUICKSTART.md)** - Get started in 5 minutes
- **[TEMPLATE_SETUP.md](TEMPLATE_SETUP.md)** - Using as template or installing into existing projects
- **[EXAMPLE.md](EXAMPLE.md)** - Complete walkthrough of a multi-issue project
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - How to work with the agent system
- **[LICENSE](LICENSE)** - MIT License
- **Scripts:**
  - [install.sh](install.sh) - Install into existing projects
  - [eject.sh](eject.sh) - Remove Flight Crew from your project
- **Agent Instructions:**
  - [Agent 1 Instructions](.github/agents/agent-1-instructions.md)
  - [Agent 2 Instructions](.github/agents/agent-2-instructions.md)

## Future Enhancements

- [ ] Add support for multiple reviewers
- [ ] Implement priority queue for issues
- [ ] Add metrics and dashboards
- [ ] Support for sub-tasks within issues
- [ ] Integration with project boards
- [ ] Notification system for stakeholders