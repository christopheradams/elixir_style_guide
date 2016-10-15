all

rule 'MD007', :indent => 4 # Unordered list indentation

exclude_rule 'MD001' # Header levels should only increment by one level at a time
exclude_rule 'MD012' # Multiple consecutive blank lines
exclude_rule 'MD014' # Dollar signs used before commands without showing output
exclude_rule 'MD033' # Inline HTML
exclude_rule 'MD036' # Emphasis used instead of a header
