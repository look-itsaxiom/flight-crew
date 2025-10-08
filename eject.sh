#!/bin/bash
# Flight Crew Eject Script
# This script completely removes the Flight Crew agent system from your project

set -e

echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║                Flight Crew POC - Eject Script                                 ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo ""

# Check if git is available
if ! command -v git &> /dev/null; then
    echo "❌ Error: git is not installed"
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

echo "⚠️  WARNING: This will remove all Flight Crew files from your project."
echo ""
echo "The following files will be deleted:"
echo "  - .github/workflows/agent-1-issue-completion.yml"
echo "  - .github/workflows/agent-1-address-feedback.yml"
echo "  - .github/workflows/agent-2-pr-review.yml"
echo "  - .github/workflows/agent-2-pr-merge.yml"
echo "  - .github/agents/agent-1-instructions.md"
echo "  - .github/agents/agent-2-instructions.md"
echo "  - .github/ISSUE_TEMPLATE/feature_request.yml (optional)"
echo "  - .github/ISSUE_TEMPLATE/bug_fix.yml (optional)"
echo "  - .flight-crew.yml"
echo "  - flight-crew/ directory (documentation and scripts)"
echo ""

read -p "Are you sure you want to continue? (yes/no): " confirm

if [[ "$confirm" != "yes" ]]; then
    echo "❌ Eject cancelled"
    exit 0
fi

# Get the root directory of the git repository
REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

echo ""
echo "🗑️  Removing Flight Crew files..."
echo ""

# Remove workflow files
files_removed=0
files_not_found=0

remove_file() {
    local file=$1
    if [[ -f "$file" ]]; then
        rm "$file"
        echo "  ✓ Removed $file"
        files_removed=$((files_removed + 1))
    else
        echo "  ⊘ Not found: $file"
        files_not_found=$((files_not_found + 1))
    fi
}

# Remove workflows
remove_file ".github/workflows/agent-1-issue-completion.yml"
remove_file ".github/workflows/agent-1-address-feedback.yml"
remove_file ".github/workflows/agent-2-pr-review.yml"
remove_file ".github/workflows/agent-2-pr-merge.yml"

# Remove agent instructions
remove_file ".github/agents/agent-1-instructions.md"
remove_file ".github/agents/agent-2-instructions.md"

# Remove configuration
remove_file ".flight-crew.yml"

# Remove flight-crew directory
echo ""
echo "🗑️  Removing flight-crew directory..."
if [[ -d "flight-crew" ]]; then
    rm -rf "flight-crew"
    echo "  ✓ Removed flight-crew directory"
else
    echo "  ⊘ Not found: flight-crew directory"
fi

# Ask about issue templates
echo ""
read -p "Remove Flight Crew issue templates? (yes/no): " remove_templates

if [[ "$remove_templates" == "yes" ]]; then
    remove_file ".github/ISSUE_TEMPLATE/feature_request.yml"
    remove_file ".github/ISSUE_TEMPLATE/bug_fix.yml"
    
    # Only remove config.yml if it was created by Flight Crew
    if [[ -f ".github/ISSUE_TEMPLATE/config.yml" ]]; then
        if grep -q "flight-crew-poc" ".github/ISSUE_TEMPLATE/config.yml" 2>/dev/null; then
            remove_file ".github/ISSUE_TEMPLATE/config.yml"
        else
            echo "  ⊘ Keeping custom config.yml"
        fi
    fi
fi

# Remove empty directories
echo ""
echo "🧹 Cleaning up empty directories..."

if [[ -d ".github/agents" ]] && [[ -z "$(ls -A .github/agents)" ]]; then
    rmdir ".github/agents"
    echo "  ✓ Removed empty .github/agents directory"
fi

if [[ -d ".github/ISSUE_TEMPLATE" ]] && [[ -z "$(ls -A .github/ISSUE_TEMPLATE)" ]]; then
    rmdir ".github/ISSUE_TEMPLATE"
    echo "  ✓ Removed empty .github/ISSUE_TEMPLATE directory"
fi

if [[ -d ".github/workflows" ]] && [[ -z "$(ls -A .github/workflows)" ]]; then
    rmdir ".github/workflows"
    echo "  ✓ Removed empty .github/workflows directory"
fi

if [[ -d ".github" ]] && [[ -z "$(ls -A .github)" ]]; then
    rmdir ".github"
    echo "  ✓ Removed empty .github directory"
fi

echo ""
echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║                    Eject Complete! ✅                                        ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo ""
echo "📊 Summary:"
echo "  Files removed: $files_removed"
echo "  Files not found: $files_not_found"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Review the changes:"
echo "   git status"
echo ""
echo "2. Commit the changes:"
echo "   git add -A"
echo "   git commit -m 'Remove Flight Crew agent system'"
echo ""
echo "3. Push to your repository:"
echo "   git push"
echo ""
echo "Note: This does not remove the 'ready' and 'completed' labels."
echo "Remove them manually from your repository settings if desired."
echo ""
