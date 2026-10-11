#!/bin/bash
# SessionStart hook: installs the Remotion video skills (remotion-dev/skills)
# at user level so they are available in every cloud session. Installed with
# -g so nothing is written inside this repository. Never blocks the session.
set -uo pipefail

# Only cloud sessions start from a fresh container; local machines keep the
# skills after the first manual install.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

if [ -f "$HOME/.claude/skills/remotion-best-practices/SKILL.md" ]; then
  exit 0
fi

if ! command -v npx >/dev/null 2>&1; then
  echo "install-remotion-skills: npx not found, skipping" >&2
  exit 0
fi

timeout 300 npx -y skills add remotion-dev/skills -g -a claude-code -y >/dev/null 2>&1 \
  || echo "install-remotion-skills: install failed, skipping" >&2
exit 0
