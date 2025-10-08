# Flight Crew Template Setup Guide

This guide explains how to use Flight Crew POC in your projects, either as a template for new projects or by installing it into existing projects.

## Table of Contents

- [Using as a GitHub Template (New Projects)](#using-as-a-github-template-new-projects)
- [Installing into Existing Projects](#installing-into-existing-projects)
- [Configuration](#configuration)
- [Ejecting from Flight Crew](#ejecting-from-flight-crew)

---

## Using as a GitHub Template (New Projects)

If you're starting a new project, the easiest way is to use this repository as a template.

### Step 1: Create Repository from Template

1. Go to https://github.com/look-itsaxiom/flight-crew-poc
2. Click the green **"Use this template"** button
3. Select **"Create a new repository"**
4. Fill in your repository details:
   - Owner: Your username or organization
   - Repository name: Your project name
   - Description: Your project description
   - Choose Public or Private
5. Click **"Create repository"**

### Step 2: Configure Your Project

1. Clone your new repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
   cd YOUR_REPO
   ```

2. Review and customize `.flight-crew.yml`:
   ```yaml
   # Flight Crew Configuration
   target_branch: develop  # Change if needed
   labels:
     ready: ready
     completed: completed
   branch_prefix: copilot/issue-
   ```

3. Create the target branch (if it doesn't exist):
   ```bash
   git checkout -b develop
   git push -u origin develop
   git checkout main
   ```

4. Create required labels in GitHub:
   - Go to `Issues` → `Labels` → `New label`
   - Create `ready` label (green #0e8a16)
   - Create `completed` label (blue #1d76db)

### Step 3: Start Using Flight Crew

Your repository is now ready! To work on your first issue:
1. Create an issue and label it `ready`
2. Manually assign **@copilot** to the issue (click Assignees → type "copilot")
3. GitHub Copilot Workspace will create a PR and implement the changes
4. Agent 2 will review and merge when ready

---

## Installing into Existing Projects

If you have an existing project, you can add Flight Crew using the installation script.

### Option A: Quick Install (Recommended)

```bash
# Run from your project root
curl -fsSL https://raw.githubusercontent.com/look-itsaxiom/flight-crew-poc/main/install.sh | bash
```

### Option B: Manual Installation

1. **Download the installation script:**
   ```bash
   curl -fsSL https://raw.githubusercontent.com/look-itsaxiom/flight-crew-poc/main/install.sh -o install.sh
   chmod +x install.sh
   ```

2. **Run the installer:**
   ```bash
   ./install.sh
   ```

3. **Follow the post-installation steps** displayed by the script.

### Option C: Local Installation (If you have this repo cloned)

```bash
# From this repository
cd /path/to/flight-crew-poc
export FLIGHT_CREW_SOURCE=$(pwd)

# Navigate to your project
cd /path/to/your-project

# Run the installer
/path/to/flight-crew-poc/install.sh
```

### What Gets Installed

The installation script adds:

```
your-project/
├── .github/
│   ├── workflows/
│   │   ├── agent-1-issue-completion.yml
│   │   ├── agent-1-address-feedback.yml
│   │   ├── agent-2-pr-review.yml
│   │   └── agent-2-pr-merge.yml
│   ├── agents/
│   │   ├── agent-1-instructions.md
│   │   └── agent-2-instructions.md
│   └── ISSUE_TEMPLATE/
│       ├── feature_request.yml
│       ├── bug_fix.yml
│       └── config.yml
├── .flight-crew.yml
└── flight-crew/
    ├── QUICKSTART.md         # Quick start guide
    └── eject.sh             # Script to remove Flight Crew
```

### Post-Installation Steps

After installation:

1. **Configure target branch** in `.flight-crew.yml`
2. **Create required labels** (`ready` and `completed`)
3. **Create a staging branch** if you don't have one:
   ```bash
   git checkout -b develop
   git push -u origin develop
   git checkout main
   ```
4. **Commit the changes:**
   ```bash
   git add .github/ .flight-crew.yml flight-crew/
   git commit -m "Add Flight Crew agent system"
   git push
   ```

5. **Read the quick start guide:**
   ```bash
   cat flight-crew/QUICKSTART.md
   ```

---

## Configuration

### Configuration File: `.flight-crew.yml`

```yaml
# Target branch for agent PRs
# Agents will create PRs targeting this branch instead of main
# A human should review and merge from this branch to main
target_branch: develop

# Labels used by the system
labels:
  ready: ready
  completed: completed

# Branch prefix for agent work
branch_prefix: copilot/issue-
```

### Customizing the Target Branch

**Why use a target branch?**
- Agent PRs merge to `develop` (or your staging branch)
- A human reviews the accumulated changes
- Human merges `develop` → `main` when ready
- This adds a human approval gate before production

**Common configurations:**

**Using 'develop' branch (recommended):**
```yaml
target_branch: develop
```

**Using 'staging' branch:**
```yaml
target_branch: staging
```

**Direct to 'main' (not recommended):**
```yaml
target_branch: main
```
⚠️ This bypasses human review - use with caution!

### Changing Branch Prefix

If `copilot/issue-` conflicts with your workflow:

```yaml
branch_prefix: agent/task-
```

This changes branch names from `copilot/issue-123` to `agent/task-123`.

### Customizing Labels

If you already have labels you want to use:

```yaml
labels:
  ready: work-ready      # Use your existing label
  completed: done        # Use your existing label
```

---

## Ejecting from Flight Crew

If you decide Flight Crew isn't right for your project, you can completely remove it.

### Option A: Quick Eject (via curl)

```bash
# Run from your project root
curl -fsSL https://raw.githubusercontent.com/look-itsaxiom/flight-crew-poc/main/eject.sh | bash
```

### Option B: Use Installed Eject Script

If you've already installed Flight Crew, use the eject script that came with it:

```bash
# Run from your project root
./flight-crew/eject.sh
```

### Option C: Manual Download and Run

1. **Download the eject script:**
   ```bash
   curl -fsSL https://raw.githubusercontent.com/look-itsaxiom/flight-crew-poc/main/eject.sh -o eject.sh
   chmod +x eject.sh
   ```

2. **Run the ejector:**
   ```bash
   ./eject.sh
   ```

3. **Follow the prompts** to confirm removal.

### What Gets Removed

The eject script removes:

- All 4 workflow files
- Agent instruction files
- Configuration file (`.flight-crew.yml`)
- flight-crew/ directory (documentation and eject script)
- Issue templates (optional - you choose)
- Empty directories

The script will:
- ✅ Ask for confirmation before removing
- ✅ Show you what will be removed
- ✅ Clean up empty directories
- ✅ Preserve your custom files
- ❌ Not commit changes (you do this)

### Post-Eject Steps

After ejecting:

1. **Review the changes:**
   ```bash
   git status
   git diff
   ```

2. **Commit the removal:**
   ```bash
   git add -A
   git commit -m "Remove Flight Crew agent system"
   git push
   ```

3. **(Optional) Remove labels** from GitHub:
   - Go to `Issues` → `Labels`
   - Delete `ready` and `completed` labels if not used elsewhere

---

## Integration with Existing CI/CD

Flight Crew works alongside your existing CI/CD pipelines:

### Compatibility

✅ **Works with:**
- GitHub Actions workflows
- Jenkins
- CircleCI
- Travis CI
- GitLab CI/CD (if mirrored)
- Any external CI system

### How It Integrates

1. **Flight Crew creates PRs** targeting your staging branch
2. **Your CI/CD runs** on the PR (tests, builds, etc.)
3. **Copilot implements** based on the issue
4. **Agent 2 reviews** the implementation
5. **Your CI must pass** before merge
6. **PR merges to staging** after approval
7. **Human reviews staging** before merging to main

### Example Integration

**With existing test workflows:**

```yaml
# Your existing .github/workflows/test.yml
name: Run Tests
on:
  pull_request:
    branches: [main, develop]  # Add develop to trigger on agent PRs

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: npm test
```

Flight Crew PRs will trigger your existing tests automatically!

### Branch Protection Rules

Recommended settings for `develop` branch:

1. Go to `Settings` → `Branches` → `Branch protection rules`
2. Add rule for `develop`:
   - ✅ Require status checks to pass
   - ✅ Require branches to be up to date
   - ✅ Add your CI checks as required
   - ❌ Don't require pull request reviews (agents can merge)

Recommended settings for `main` branch:

1. Add rule for `main`:
   - ✅ Require pull request reviews (1+ approvals)
   - ✅ Require status checks to pass
   - ✅ Require branches to be up to date
   - ✅ Include administrators

This ensures:
- Agents can merge to `develop` when tests pass
- Humans must approve merges to `main`

---

## Troubleshooting

### "Target branch doesn't exist"

Create the branch:
```bash
git checkout -b develop
git push -u origin develop
```

### "Workflow not triggering"

1. Check that workflows are in `.github/workflows/`
2. Verify label name matches config (default: `ready`)
3. Check Actions tab for error messages
4. Ensure GitHub Actions are enabled in repo settings

### "Permission denied" errors

Ensure the repository has:
1. Actions enabled: `Settings` → `Actions` → `General`
2. Workflow permissions: Allow read and write
3. Correct branch protection rules

### "Cannot find module 'js-yaml'"

The workflow uses Node.js built-in modules. If you see this error:
1. This is rare and usually means GitHub Actions environment issue
2. Try re-running the workflow
3. If persistent, check GitHub Actions status

---

## Next Steps

- **New projects**: Create your first issue and label it `ready`!
- **Existing projects**: Test with a simple issue first
- **Learn more**: Check out [EXAMPLE.md](EXAMPLE.md) for a complete walkthrough
- **Get help**: See [CONTRIBUTING.md](CONTRIBUTING.md) for best practices

## Quick Reference

| Action | Command |
|--------|---------|
| Install | `curl -fsSL https://raw.githubusercontent.com/look-itsaxiom/flight-crew-poc/main/install.sh \| bash` |
| Eject | `curl -fsSL https://raw.githubusercontent.com/look-itsaxiom/flight-crew-poc/main/eject.sh \| bash` |
| Configure | Edit `.flight-crew.yml` |
| Start using | Create issue → Label `ready` |

---

**Need help?** Check the [main README](README.md) or create an issue!
