# Contributing to the Elixir Style Guide

First of all, thanks for wanting to contribute! :heart:

You can contribute in several ways:

* open up an issue if you find something plain old wrong in the style guide
  (e.g., typos or formatting);
* open up an issue if you find inconsistencies in the style guide. This way, we
  can discuss the better way to eliminate those inconsistencies;
* if you have any suggestions or opinions, open up an issue or (even better!) a
  pull request.

If you edit the `README.md` file, please stick to this set of
formatting/markup/style rules so that the style remains consistent:

* don't make lines longer than 80 characters (most editors have an auto-wrapping
  functionality, for example [emacs](http://emacswiki.org/emacs/LineWrap) or
  [vim](http://vim.wikia.com/wiki/Automatic_word_wrapping));
* leave **two newlines** before each first, second and third level header (`#`
  to `###`) and **one newline** before every other type of headers (`####` to
  `######`).

Install [markdownlint](https://github.com/mivok/markdownlint) to check your
changes, and run:

```sh
mdl --style 'markdown.rb' README.md
```

**IMPORTANT**: By submitting a patch, you agree that your work will be
licensed under the license used by the project.


## Collaborators

If you have contributed to the repository you can be appointed as a collaborator
after submitting a change and getting it merged. Collaborators are invited to
manage issues, make corrections to the style guide, review pull requests, and
merge approved changes.

1. All changes must pass automatic checks before being merged.
1. Minor changes and corrections can be merged without review.
1. Significant changes or new style rules should be discussed and approved in a
   pull request.
