# Sponge [![Releases](https://img.shields.io/github/release/andreiborisov/sponge.svg?label=&color=0080FF)](https://github.com/andreiborisov/sponge/releases/latest)

Don't you hate it when you spend half an hour searching for a command through your shell history (you know it's there, you entered it two months ago yourself!), you finally find it and happily press `Enter` only to realize two seconds later... it's not that one, it's another one you'd entered just before that, the one with the _typo_. Ugh. Awful. Ungodly. Unproductive. Your day is ruined... unless you use _Sponge_.

---

Sponge runs in the background and keeps your history clean from typos, incorrectly used commands and something you don't want to store due to privacy reasons.

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install andreiborisov/sponge
```

### System requirements

- [fish](http://fishshell.com) 3.2+

## Usage

### Filter failed

Just use your shell as usual and enjoy typos-free history😎 Sponge will filter out all failed commands unless they previously have been in the history. You can tweak which exit codes Sponge considers successful with `sponge_successful_exit_codes` variable (by default it's only `0`):

```fish
set sponge_successful_exit_codes 0 127
```

If you wish to filter out all failed commands regardless of whether they already have been in the history or not, change `sponge_allow_previously_successful` variable:

```fish
set sponge_allow_previously_successful false
```

### Filter by regex

You can use the full power of regular expressions to filter out unwanted commands. Set `sponge_regex_patterns` variable and everything matched will be kept away from the history:

```fish
set sponge_regex_patterns '(?:\d{1,3}\.){3}\d{1,3}'
```

This example will filter any command containing IPv4 address.

### Adjusting delay

By default Sponge delays deleting of filtered command so you can always access the last 2 history entries. If you want to remove commands immediately or adjust the delay, change `sponge_delay` variable:

```fish
set sponge_delay 5
```

This will allow you to always access the last 5 entered commands.

## Advanced usage

Sponge uses extendable functions called _filters_ to decide which commands to filter out. You can plug into this mechanism by defining your own filters.

Filter function call signature is guaranteed to be compatible within the current major release:

| Argument | Name                    | Description                                                                     |
| -------- | ----------------------- | ------------------------------------------------------------------------------- |
| 1        | `command`               | The exact command that was entered                                              |
| 2        | `exit_code`             | The exit code of the command                                                    |
| 3        | `previously_in_history` | `true` or `false` flag indicating if the command has been in the history before |

Return with exit status `0` to filter out the command and `1` to keep the command in the history.

Check out predefined filters to see an example of filter functions:

- [`sponge_filter_failed`](https://github.com/andreiborisov/sponge/blob/main/functions/sponge_filter_failed.fish) filters by command exit code
- [`sponge_filter_matched`](https://github.com/andreiborisov/sponge/blob/main/functions/sponge_filter_matched.fish) filters using regex patterns

Be mindful of what you put in the filters, as they are run synchronously after each command execution and can slow down your prompt in case of compute-intensive tasks or network requests.

After you define your filter in `config.fish` or as a standalone function in fish `functions` folder, you need to register it with Sponge by adding the filter name in `sponge_filters` variable:

```fish
set --append sponge_filters my_awesome_filter
```

By default `sponge_filters` contains predefined filters, so make sure to append it instead of rewriting unless you want to disable them completely (which is also fine😌).

## License

[MIT](LICENSE)
