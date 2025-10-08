# Flight Crew POC - Example Scenario

This document walks through a complete example of how the Flight Crew POC system works.

## Scenario: Building a Simple Blog System

Let's say we want to build a blog system with these components:
1. Database schema
2. User authentication
3. Blog post CRUD operations
4. Comment system

We'll create issues with dependencies to demonstrate the workflow.

## Step 1: Create Issues

### Issue #1: Setup Database Schema
```markdown
Title: Setup Database Schema

Description:
Create the database schema for the blog system.

Requirements:
- Create users table (id, username, email, password_hash, created_at)
- Create posts table (id, user_id, title, content, created_at, updated_at)
- Create comments table (id, post_id, user_id, content, created_at)
- Add foreign key constraints
- Create migration files

Status: Label with "ready" immediately (no dependencies)
```

### Issue #2: Implement User Authentication
```markdown
Title: Implement User Authentication

Description:
Implement JWT-based authentication for users.

Requirements:
- POST /api/auth/register endpoint
- POST /api/auth/login endpoint
- JWT token generation
- Password hashing with bcrypt
- Input validation

Depends on #1

Status: Will be labeled "ready" automatically when #1 is completed
```

### Issue #3: Implement Blog Post CRUD
```markdown
Title: Implement Blog Post CRUD Operations

Description:
Create API endpoints for managing blog posts.

Requirements:
- GET /api/posts - List all posts
- GET /api/posts/:id - Get single post
- POST /api/posts - Create post (authenticated)
- PUT /api/posts/:id - Update post (authenticated, owner only)
- DELETE /api/posts/:id - Delete post (authenticated, owner only)

Depends on #1
Depends on #2

Status: Will be labeled "ready" when both #1 and #2 are completed
```

### Issue #4: Implement Comment System
```markdown
Title: Implement Comment System

Description:
Add commenting functionality to blog posts.

Requirements:
- GET /api/posts/:id/comments - Get comments for a post
- POST /api/posts/:id/comments - Add comment (authenticated)
- DELETE /api/comments/:id - Delete comment (authenticated, owner only)

Depends on #3

Status: Will be labeled "ready" when #3 is completed
```

## Step 2: Workflow Execution

### Issue #1: Setup Database Schema

1. **Developer labels #1 as "ready"**
   - Agent 1 workflow triggers
   - Creates branch `copilot/issue-1`
   - Opens PR #10 with title "Fix: Setup Database Schema"
   - Tags @copilot in PR body

2. **Copilot implements the database schema**
   - Creates migration files
   - Adds schema definitions
   - Pushes changes to the branch

3. **Agent 2 reviews PR #10**
   - Workflow triggers on PR update
   - Requests Copilot to review the changes
   - Copilot reviews and approves

4. **PR #10 is merged**
   - Agent 2 merge workflow triggers
   - Issue #1 is closed and labeled "completed"
   - Agent 2 checks dependencies:
     - Issue #2 depends only on #1 → labeled "ready"
     - Issue #3 depends on #1 and #2 → still blocked (waiting for #2)

### Issue #2: Implement User Authentication

1. **Automatically labeled "ready" (triggered by #1 completion)**
   - Agent 1 workflow triggers immediately
   - Creates branch `copilot/issue-2`
   - Opens PR #11

2. **Copilot implements authentication**
   - Adds auth endpoints
   - Implements JWT logic
   - Adds password hashing

3. **Agent 2 reviews PR #11**
   - Requests changes: "Please add input validation for email format"
   - Tags @copilot in review comment

4. **Agent 1 addresses feedback**
   - Workflow triggers on @copilot mention
   - Acknowledges feedback
   - Copilot adds email validation

5. **Agent 2 reviews again**
   - Approves the changes
   - PR #11 is merged

6. **Post-merge actions**
   - Issue #2 is closed and labeled "completed"
   - Agent 2 checks dependencies:
     - Issue #3 depends on #1 (✓ completed) and #2 (✓ completed) → labeled "ready"
     - Issue #4 still depends on #3 → still blocked

### Issue #3: Implement Blog Post CRUD

1. **Automatically labeled "ready" (both dependencies completed)**
   - Agent 1 creates PR #12

2. **Implementation and review cycle**
   - Copilot implements CRUD operations
   - Agent 2 reviews and approves
   - PR #12 is merged

3. **Post-merge actions**
   - Issue #3 is closed and labeled "completed"
   - Issue #4 depends only on #3 → labeled "ready"

### Issue #4: Implement Comment System

1. **Automatically labeled "ready"**
   - Agent 1 creates PR #13

2. **Implementation and review cycle**
   - Copilot implements comment system
   - Agent 2 reviews and approves
   - PR #13 is merged

3. **Post-merge actions**
   - Issue #4 is closed and labeled "completed"
   - All issues complete! 🎉

## Timeline Visualization

```
Day 1:
  09:00 - Developer creates Issues #1, #2, #3, #4
  09:15 - Developer labels Issue #1 as "ready"
  09:16 - Agent 1 creates PR #10 for Issue #1
  09:20 - Copilot implements database schema
  09:30 - Agent 2 reviews and approves
  09:35 - PR #10 merged
  09:36 - Issue #1 completed, Issue #2 labeled "ready"
  09:37 - Agent 1 creates PR #11 for Issue #2
  10:00 - Copilot implements authentication
  10:15 - Agent 2 requests changes
  10:20 - Agent 1 addresses feedback
  10:45 - Copilot adds validation
  11:00 - Agent 2 approves
  11:05 - PR #11 merged
  11:06 - Issue #2 completed, Issue #3 labeled "ready"
  11:07 - Agent 1 creates PR #12 for Issue #3
  
Day 1-2:
  [Continue cycle for Issues #3 and #4...]

Day 2:
  14:00 - All issues completed
  14:00 - Blog system fully implemented through automation!
```

## Key Observations

1. **Zero Manual PR Creation**: Developers only created issues and applied labels
2. **Automatic Sequencing**: Issues were worked on in the correct order based on dependencies
3. **Feedback Loop**: When changes were needed, Agent 1 automatically addressed them
4. **No Blocked Work**: As soon as dependencies were met, work began automatically
5. **Full Audit Trail**: All work is tracked through issues, PRs, and reviews

## Benefits Demonstrated

✅ **Efficiency**: From 4 issues to complete implementation without manual PR management
✅ **Dependency Management**: Automatic unblocking of dependent issues
✅ **Quality**: Every PR reviewed before merging
✅ **Iteration**: Automatic feedback addressing until quality standards met
✅ **Visibility**: Complete history in GitHub's native interface

## What the Developer Did

- Created 4 issues with clear requirements
- Added dependency declarations
- Labeled the first issue as "ready"
- **That's it!** The rest was automated.

## What the Agents Did

- Created 4 PRs at the right time
- Implemented all the code (via Copilot)
- Reviewed all changes
- Requested and addressed feedback
- Merged when approved
- Managed all labels and dependencies
- Maintained the workflow state

This demonstrates the power of the Flight Crew POC system - from issue creation to full implementation with minimal manual intervention!
