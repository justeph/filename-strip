# FileName Strip

Create and personalize your own autocommands to strip and replace pattern on filename before opening your file

## Requirements

NeoVim 0.7.0+

## Installation

### Packer


```lua
use({
	'justeph/filename-strip',
	config = function()
		require("filename-strip").setup({})
	end
})
```
### Other package manager

The instructions above can be adapted to any other plugin manager

## What is this plugin and what I can do with it?

This plugin allows you to define autocommands that are executed on the 'BufNewFile' and 'BufRead' events.

It allows you to search and replace some pattern in the filename before opening it.

Typical use case (and the main reason I wrote this plugin): strip leading 'a/' and 'b/' from git output.

## Adding a custom rule

```lua
require("filename-strip").setup({
        autocmd = {
		my_new_rule = {
			pattern = <pattern>,
			repl = <replacement>,
			root = <root>,
			relative_to_root = <boolean>,
			strip_first = <boolean>
		},
	},
	enable_git_strip = <boolean>
})
```

Where :
* pattern (default: empty string) : is the pattern to search for
* repl (default: empty string) : is the replacement. See section bellow for more information
* root (default: empty string) : a directory or file specifying the root directory. Usefull to restrict some autocommands to some directories
* relative_to_root (default: false, require root): when set to true, prepend the filename with the root directory after pattern replacement
* strip_first (default: false) : when true, directly apply the substitution, when false, first try to open the file as is
* enable_git (default: false) : enable the built in git strip autocommand (see example bellow for implementation)

Note :
`pattern` and `repl` are given as is to the `gsub` function, so you can do powerful manipulation using captures and even specify a function for `repl`! See this [doc](https://www.lua.org/pil/20.3.html) to understand everything that can be done. See example below for a useful use case using captures.

## Examples

### Git strip

```lua
git = {
        pattern = "^[a,b]/",
        root = ".git",
        relative_to_root = true,
}
```
This will create an autocommand that will execute only inside git repositories (i.e containing a `.git` directory), and remove the leading 'a/' or 'b/'. The `relative_to_root` parameter will ensure that you can open 'a/path/to/a/file' from anywhere inside the git directory! This is useful when doing a `git show`/`git diff` from a subdirectory

### Goto line

Some tools can add append/prepend some information to the filename. For example grep can add the line number wher pattern was found. You can add a rule like the following: 

```lua
grep = {
        pattern = "^(.*):(%d+):.*$",
        strip_first = true,
        repl = "+%2 %1"
},
```
This will create an autocommand that will convert input such as: `/path/to/my/file:xx:content of the file` to `+xx /path/to/my/file` to jump to line xx using `gsub` capture mechanism. See this [doc](https://www.lua.org/pil/20.3.html)
