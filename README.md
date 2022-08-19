# Sponge [![Releases](https://img.shields.io/github/release/meaningful-ooo/sponge.svg?label=&color=%23ffffff)](https://github.com/meaningful-ooo/sponge/releases/latest)

<div align="center">

[![Discord](https://img.shields.io/discord/776090526410604564?color=%235866f2&label=%20&logo=discord&logoColor=%23ffffff)](https://discord.gg/KEc2MMV3T9) [![Twitch Status](https://img.shields.io/twitch/status/borisovdev?color=%239146ff&label=%20&logo=twitch&logoColor=%23ffffff)](https://twitch.tv/borisovdev)

</div>

> Don't you hate it when you spend half an hour searching for a command, finally find it and happily press `Enter` only to realize a couple of seconds later... it's not that one, it's another one you've entered two months ago, the one with the _typo_.

> Ugh. Awful. Ungodly. Unproductive. Your day is ruined… unless you use _Sponge_.

Sponge quietly runs in the background and keeps your shell history clean from typos, incorrectly used commands and everything you don't want to store due to privacy reasons.

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install meaningful-ooo/sponge
```

### System requirements

- [fish](http://fishshell.com) 3.2+

## Usage

Just use your shell as usual and enjoy typos-free history😎

Sponge will automatically filter out all failed commands unless they have been in the history before. The last 2 entries are always available so you can quickly fix a misspelled command.

> Sponge won’t filter commands retroactively. If you don’t want previously mistyped commands clogging up your search results, clear the history once after Sponge installation:

```fish
history clear
```

## Settings

### Filter failed

By default Sponge will filter out all commands that don’t have `0` as an exit code. You can tweak which exit codes Sponge considers successful with `sponge_successful_exit_codes` variable:

```fish
set sponge_successful_exit_codes 0 127
```

If you wish to filter out all failed commands regardless of whether they already have been in the history or not, change `sponge_allow_previously_successful` variable:

```fish
set sponge_allow_previously_successful false
```

### Filter by regex

You can use the full power of regular expressions to filter out unwanted commands. Set `sponge_regex_patterns` variable and everything matched will be kept away from the history. For example, to filter out every command that contains IPv4 address, type:

```fish
set sponge_regex_patterns '(?:\d{1,3}\.){3}\d{1,3}'
```

### Adjusting delay

By default Sponge delays deleting of filtered command so you can always access the last 2 history entries. If you want to remove commands immediately or increase the delay, change `sponge_delay` variable:

```fish
set sponge_delay 5
```

### Custom filters

Sponge works by invoking an array of _filters_. You can plug into this mechanism by defining your own filters.

Filter is simply a function with a specific call signature:

| **Argument** | **Name**                | **Description**                                                                 |
| ------------ | ----------------------- | ------------------------------------------------------------------------------- |
| 1            | `command`               | The exact command that was entered                                              |
| 2            | `exit_code`             | The exit code of the command                                                    |
| 3            | `previously_in_history` | `true` or `false` flag indicating if the command has been in the history before |

Return with exit status `0` to filter out provided command and anything else to keep the command in the history.

You can define your filter in `config.fish` or as a standalone function in fish `functions` folder.

> Be mindful of what you put in filters, as they are run synchronously after each command execution and can slow down your prompt in case of compute-intensive tasks or network requests.

After that you need to register your filter with Sponge by adding its name in `sponge_filters` variable:

```fish
set --append sponge_filters my_awesome_filter
```

Make sure to append `sponge_filters` like in the example above unless you want to disable the built in filters:

- [`sponge_filter_failed`](https://github.com/meaningful-ooo/sponge/blob/main/functions/sponge_filter_failed.fish) filters by command exit code
- [`sponge_filter_matched`](https://github.com/meaningful-ooo/sponge/blob/main/functions/sponge_filter_matched.fish) filters using regex patterns

## License

[MIT](LICENSE)

# Meaningful

We are 🏴‍☠️ 🏰 💎 first ever blockchain state.

[More](https://meaningful.ooo).
