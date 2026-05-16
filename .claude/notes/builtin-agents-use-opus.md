When launching a built-in agent (`claude`, `claude-code-guide`, `Explore`, `general-purpose`, `Plan`, `statusline-setup`) via the Agent tool, always pass `model: "opus"`.

Applies only to the built-in agents listed above. Custom agents defined in `~/.claude/agents/` or `.claude/agents/` keep whatever model their frontmatter specifies.
