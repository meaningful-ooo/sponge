# Sponge version
set --global sponge_version 1.0.0

# Allow to repeat previous command by default
if not set --query --universal sponge_delay
  set --universal sponge_delay 2
end

# Add default filters
if not set --query --universal sponge_filters
  set --universal sponge_filters sponge_filter_failed sponge_filter_matched
end

# Consider `0` the only successful exit code by default
if not set --query --universal sponge_successful_exit_codes
  set --universal sponge_successful_exit_codes 0
end

# Don't filter out commands that already have been in the history by default
if not set --query --universal sponge_allow_previously_successful
  set --universal sponge_allow_previously_successful true
end

# No active regex patterns by default
if not set --query --universal sponge_regex_patterns
  set --universal sponge_regex_patterns
end

# Attach event handlers
functions --query \
  _sponge_on_prompt \
  _sponge_on_preexec \
  _sponge_on_postexec \
  _sponge_on_exit