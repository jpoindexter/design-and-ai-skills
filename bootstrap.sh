#!/usr/bin/env bash
# First-clone setup: installs skills + wires the post-merge hook.
# Run once after cloning: ./bootstrap.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
HOOK_PATH="$REPO_DIR/.git/hooks/post-merge"

echo "[bootstrap] setting up $(basename "$REPO_DIR")..."

# Wire the post-merge hook
cat > "$HOOK_PATH" << 'EOF'
#!/usr/bin/env bash
set -euo pipefail
REPO_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
echo "[post-merge] reinstalling skills from $(basename "$REPO_DIR")..."
bash "$REPO_DIR/install.sh"
EOF
chmod +x "$HOOK_PATH"
echo "[bootstrap] post-merge hook installed → .git/hooks/post-merge"

# Install skills now
echo "[bootstrap] installing skills..."
bash "$REPO_DIR/install.sh"
