function _sponge_remove_from_history

  while test (count $_sponge_queue) -gt "$sponge_delay"
    builtin history delete --case-sensitive --exact -- $_sponge_queue[-1]
    set --erase _sponge_queue[-1]
    set -f should_save
  end

  if set -qf should_save
    builtin history save
  end
end
