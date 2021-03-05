function _sponge_remove_from_history

while test (count $_sponge_queue) -gt $sponge_delay
  history delete --case-sensitive --exact -- $_sponge_queue[-1]
  set --erase _sponge_queue[-1]
end

history save
end
