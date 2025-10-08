# Quick Start Guide

Get started with Flight Crew POC in 5 minutes!

## Prerequisites

- A GitHub repository with Actions enabled
- Admin access to the repository (to create labels)

## Step 1: Setup Labels (One-time)

Create these labels in your repository:

1. Go to `Issues` → `Labels` → `New label`

2. Create the `ready` label:
   - Name: `ready`
   - Description: Issue is ready to be worked on by agents
   - Color: `#0e8a16` (green)

3. Create the `completed` label:
   - Name: `completed`
   - Description: Issue has been successfully completed
   - Color: `#1d76db` (blue)

## Step 2: Create Your First Issue

1. Click `Issues` → `New issue`

2. Choose the **Feature Request** template

3. Fill in the details:
   ```markdown
   Title: Add hello world endpoint
   
   Description:
   Create a simple hello world API endpoint.
   
   Requirements:
   - Create GET /api/hello endpoint
   - Return JSON: {"message": "Hello, World!"}
   - Add appropriate HTTP status code
   ```

4. Click `Submit new issue`

## Step 3: Start the Automation

1. On your new issue, click `Labels` → Select `ready`

2. Watch the magic happen! 🎉
   - Within seconds, Agent 1 will create a PR
   - Copilot will implement the code
   - Agent 2 will review the PR
   - If approved, it will be merged automatically
   - Your issue will be closed and marked as completed

## Step 4: Create a Dependent Issue

1. Create another issue:
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

2. **Don't label it as ready yet!**

3. When issue #1 is completed, issue #2 will automatically be labeled `ready` and worked on.

## What to Expect

### Timeline for a Simple Issue

```
T+0:00  - Label issue as "ready"
T+0:05  - Agent 1 creates PR
T+0:10  - Copilot starts implementation
T+1:00  - Copilot completes implementation (varies by complexity)
T+1:05  - Agent 2 reviews PR
T+1:10  - If approved: PR merged, issue completed
        - If changes needed: Feedback loop begins
```

### The Feedback Loop

If Agent 2 requests changes:

```
T+0:00  - Agent 2 comments with feedback, mentions @copilot
T+0:05  - Agent 1 acknowledges feedback
T+0:10  - Copilot addresses feedback
T+0:30  - Agent 2 reviews again
T+0:35  - Loop repeats until approved
```

## Monitoring Progress

### GitHub Actions Tab

Visit `Actions` to see:
- Workflow runs in progress
- Success/failure status
- Execution logs

### PR View

Check the PR to see:
- Code changes
- Review comments from Agent 2
- Status checks

### Issue View

Check the issue to see:
- Comments from agents
- Label changes
- Link to the PR

## Common Workflows

### Single Issue
```
Create Issue → Label "ready" → Wait for completion
```

### Sequential Issues (with dependencies)
```
Create Issue A → Label "ready" → 
Create Issue B (depends on A) → 
Wait for A to complete → 
B automatically starts
```

### Parallel Issues (no dependencies)
```
Create Issue A → Label "ready"
Create Issue B → Label "ready"
Create Issue C → Label "ready"
(All work on simultaneously)
```

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

## Example Issue Templates

### Simple Feature
```markdown
Title: Add user profile endpoint

Description: Create an API endpoint to get user profile information.

Requirements:
- GET /api/users/:id endpoint
- Return user object with id, name, email
- Return 404 if user not found
- Return 200 with user data if found
```

### Bug Fix
```markdown
Title: Fix login validation bug

Description: Login endpoint accepts invalid email formats.

Steps to Reproduce:
1. POST /api/auth/login with email "notanemail"
2. System accepts it

Expected: Should return 400 for invalid email format

Requirements:
- Add email format validation
- Return 400 with clear error message
- Add test case for invalid email
```

### Feature with Dependency
```markdown
Title: Add user avatar upload

Description: Allow users to upload profile avatars.

Requirements:
- POST /api/users/:id/avatar endpoint
- Accept image file (jpg, png)
- Resize to 200x200
- Store in cloud storage
- Update user profile with avatar URL

Depends on #45
```

## Troubleshooting

### "Nothing is happening"

1. Check that the `ready` label is applied
2. Go to Actions tab and check for workflow runs
3. Check if there are any failed workflows

### "PR was created but no code changes"

This is normal! The PR is created first, then Copilot implements the changes. Wait a few minutes and refresh the PR.

### "Agent 2 keeps requesting changes"

This means the implementation doesn't meet the requirements yet. Review the feedback comments to understand what needs improvement.

### "Issue not unblocking"

Check that:
- All dependencies use correct format: `Depends on #123`
- All dependency issues are actually closed
- The dependency issue has the `completed` label

## Next Steps

Once you're comfortable with the basics:

1. Read the full [README.md](README.md) for detailed documentation
2. Check out [EXAMPLE.md](EXAMPLE.md) for a complete scenario
3. Review [CONTRIBUTING.md](CONTRIBUTING.md) for best practices
4. Explore the workflow files in `.github/workflows/`

## Getting Help

- **Documentation**: Check README.md, EXAMPLE.md, CONTRIBUTING.md
- **Workflow Logs**: Actions tab shows execution details
- **Discussions**: Use GitHub Discussions for questions
- **Issues**: Report bugs or request features

---

**Ready to try it?** Create your first issue and label it `ready`! 🚀
