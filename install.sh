#!/bin/bash
# Flight Crew Installation Script
# This script installs the Flight Crew agent system into an existing project

set -e

echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║               Flight Crew POC - Installation Script                          ║"
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

echo "📦 Installing Flight Crew agent system..."
echo ""

# Get the root directory of the git repository
REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

# Create .github directories if they don't exist
mkdir -p .github/workflows
mkdir -p .github/agents
mkdir -p .github/ISSUE_TEMPLATE

echo "✓ Created .github directories"

# Download or copy workflow files
FLIGHT_CREW_SOURCE="${FLIGHT_CREW_SOURCE:-https://raw.githubusercontent.com/look-itsaxiom/flight-crew-poc/main}"

echo "📥 Downloading workflow files..."

# Function to download or copy a file
download_file() {
    local source_path=$1
    local dest_path=$2
    
    if [[ "$FLIGHT_CREW_SOURCE" == "https://"* ]]; then
        # Download from URL
        if command -v curl &> /dev/null; then
            curl -fsSL "$FLIGHT_CREW_SOURCE/$source_path" -o "$dest_path"
        elif command -v wget &> /dev/null; then
            wget -q "$FLIGHT_CREW_SOURCE/$source_path" -O "$dest_path"
        else
            echo "❌ Error: Neither curl nor wget is available"
            exit 1
        fi
    else
        # Copy from local directory
        cp "$FLIGHT_CREW_SOURCE/$source_path" "$dest_path"
    fi
}

# Download workflow files
download_file ".github/workflows/agent-1-issue-completion.yml" ".github/workflows/agent-1-issue-completion.yml"
download_file ".github/workflows/agent-1-address-feedback.yml" ".github/workflows/agent-1-address-feedback.yml"
download_file ".github/workflows/agent-2-pr-review.yml" ".github/workflows/agent-2-pr-review.yml"
download_file ".github/workflows/agent-2-pr-merge.yml" ".github/workflows/agent-2-pr-merge.yml"
echo "✓ Downloaded workflow files"

# Download agent instructions
download_file ".github/agents/agent-1-instructions.md" ".github/agents/agent-1-instructions.md"
download_file ".github/agents/agent-2-instructions.md" ".github/agents/agent-2-instructions.md"
echo "✓ Downloaded agent instructions"

# Download issue templates
download_file ".github/ISSUE_TEMPLATE/feature_request.yml" ".github/ISSUE_TEMPLATE/feature_request.yml"
download_file ".github/ISSUE_TEMPLATE/bug_fix.yml" ".github/ISSUE_TEMPLATE/bug_fix.yml"
download_file ".github/ISSUE_TEMPLATE/config.yml" ".github/ISSUE_TEMPLATE/config.yml"
echo "✓ Downloaded issue templates"

# Download configuration file
download_file ".flight-crew.yml" ".flight-crew.yml"
echo "✓ Downloaded configuration file"

echo ""
echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║                    Installation Complete! ✅                                 ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Add @copilot as a collaborator (REQUIRED for automatic assignment):"
echo "   - Go to Settings → Collaborators and teams"
echo "   - Click 'Add people' and search for '@copilot'"
echo "   - Add with Write permission or higher"
echo ""
echo "2. Create required labels in your repository:"
echo "   - 'ready' (green #0e8a16)"
echo "   - 'completed' (blue #1d76db)"
echo ""
echo "3. Review and edit .flight-crew.yml to configure the target branch"
echo "   Current setting: develop (change if needed)"
echo ""
echo "4. Commit and push the new files:"
echo "   git add .github/ .flight-crew.yml"
echo "   git commit -m 'Add Flight Crew agent system'"
echo "   git push"
echo ""
echo "5. Create a staging/development branch if you don't have one:"
echo "   git checkout -b develop"
echo "   git push -u origin develop"
echo ""
echo "6. Start using the system by creating an issue and labeling it 'ready'!"
echo ""
echo "⚠️  Note: If @copilot is not a collaborator, the workflow will comment"
echo "   with instructions, but automatic assignment will not work."
echo ""
echo "📚 Documentation:"
echo "   https://github.com/look-itsaxiom/flight-crew-poc"
echo ""
