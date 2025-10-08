# Flight Crew Quick Start - Adding to Existing Project

This guide helps you add Flight Crew to your existing project in 5 minutes.

## What is Flight Crew?

Flight Crew is a GitHub native issue completion agent system that automates your development workflow using GitHub Copilot. When you label an issue as "ready", the system automatically:
- Assigns @copilot to the issue
- Creates a pull request with the implementation
- Handles code reviews and feedback
- Merges approved changes
- Manages issue dependencies

## Prerequisites

- A GitHub repository with Actions enabled
- Admin access to the repository
- Git installed locally

## Installation

Flight Crew has been installed in this project. The following files were added:

```
your-project/
├── .github/
│   ├── workflows/          # Automation workflows
│   ├── agents/            # Agent instruction files for Copilot
│   └── ISSUE_TEMPLATE/    # Issue templates
├── .flight-crew.yml       # Configuration file
└── flight-crew/           # Documentation and scripts
    ├── QUICKSTART.md      # This file
    └── eject.sh          # Script to remove Flight Crew
```

## Setup Steps

### 1. Create Required Labels

Create these labels in your repository:

1. Go to **Issues** → **Labels** → **New label**

2. Create the `ready` label:
   - Name: `ready`
   - Description: Issue is ready to be worked on by GitHub Copilot
   - Color: `#0e8a16` (green)

3. Create the `completed` label:
   - Name: `completed`
   - Description: Issue has been successfully completed
   - Color: `#1d76db` (blue)

### 2. Configure Target Branch (Optional)

Edit `.flight-crew.yml` if needed:

```yaml
labels:
  ready: ready
  completed: completed
```

**Note**: Branch configuration is no longer needed as GitHub Copilot Workspace handles PR creation automatically.

### 3. Commit and Push

```bash
git add .github/ .flight-crew.yml flight-crew/
git commit -m "Add Flight Crew agent system"
git push
```

## Usage

### Create Your First Issue

1. Go to **Issues** → **New issue**

2. Fill in the details:
   ```markdown
   Title: Add hello world endpoint
   
   Description:
   Create a simple hello world API endpoint.
   
   Requirements:
   - Create GET /api/hello endpoint
   - Return JSON: {"message": "Hello, World!"}
   - Add appropriate HTTP status code
   ```

3. Click **Submit new issue**

### Start the Automation

1. On your new issue, click **Labels** → Select **ready**

2. Click **Assignees** → Type `copilot` → Select **@copilot**

3. Watch the magic happen! 🎉
   - GitHub Copilot Workspace creates a PR
   - Copilot implements the code
   - Agent 2 reviews the PR and provides feedback if needed
   - Agent 2 merges the PR to develop when ready
   - Issue is closed and marked as completed

4. **Review the PR:**
   - Check the PR created by GitHub Copilot
   - Review the code changes
   - Agent 2 will handle the merge when everything looks good

## Working with Dependencies

Create issues with dependencies:

```markdown
Title: Add goodbye endpoint

Description:
Create a goodbye API endpoint that depends on the hello endpoint.

Requirements:
- Create GET /api/goodbye endpoint
- Return JSON: {"message": "Goodbye!"}
- Follow the same pattern as the hello endpoint

Depends on #1
```

**Don't label it as ready yet!** When issue #1 is completed, issue #2 will automatically be labeled `ready` and worked on.

## Tips for Success

### ✅ Do This

- **Be specific** in issue descriptions
- **List clear requirements** 
- **Use dependencies** for ordered work
- **One concern per issue** - break down complex features

### ❌ Avoid This

- Vague requirements like "make it better"
- Bundling multiple unrelated changes
- Forgetting to add the `ready` label
- Creating circular dependencies

## Monitoring Progress

### GitHub Actions Tab

Visit **Actions** to see:
- Workflow runs in progress
- Success/failure status
- Execution logs

### Pull Request View

Check the PR to see:
- Code changes
- Status updates from Agent 2
- Status checks

### Issue View

Check the issue to see:
- Comments from agents
- Copilot assignment
- Label changes
- Link to the PR

## Troubleshooting

### "Nothing is happening"

1. Check that the `ready` label is applied
2. Verify @copilot was assigned to the issue
3. Go to Actions tab and check for workflow runs
4. Check if there are any failed workflows

### "No PR created yet"

GitHub Copilot Workspace may take a few moments to analyze the issue and create the PR. Be patient and check back in a few minutes.

### "Issue not unblocking"

Check that:
- All dependencies use correct format: `Depends on #123`
- All dependency issues are actually closed
- The dependency issue has the `completed` label

## Removing Flight Crew

If you decide Flight Crew isn't right for your project, run:

```bash
./flight-crew/eject.sh
```

This will remove all Flight Crew files from your project.

## Getting Help

- **Agent Instructions**: Check `.github/agents/` for agent behavior
- **Workflow Logs**: Actions tab shows execution details
- **Documentation**: Visit https://github.com/look-itsaxiom/flight-crew
- **Issues**: Report bugs or request features in the Flight Crew repository

---

**Ready to try it?** Create your first issue and label it `ready`! 🚀
