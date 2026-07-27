# herdr ships its own fish completions; load them lazily on first completion.
command -q herdr && herdr completion fish | source
