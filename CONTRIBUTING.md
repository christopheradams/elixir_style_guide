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
  functionality, for example [Emacs][Emacs LineWrap] or [Vim][Vim word wrap]);
* use reference-style links, like `[an example][Example]`. Put the links in
  alphabetical order at the end of the document, and capitalize the first word
  of the link label.

Use Ruby and [Markdownlint] to check your changes:

```sh
gem install mdl rake
rake test
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

## Translations

If you would like to help translate the Style Guide, check if there is
an [existing translation][Translations] to contribute to. To create a new
translation:

1. [Fork] this repository.
1. Clone your fork locally.
1. Copy `README.md` to a new file named after the country/language, like
   `README-jaJP.md`, and commit your translations there.
1. Add the main [repo][Repo] as an upstream remote, to fetch and merge changes.

<!-- Links -->
[Emacs LineWrap]: http://emacswiki.org/emacs/LineWrap
[Fork]: https://github.com/christopheradams/elixir_style_guide#fork-destination-box
[Markdownlint]: https://github.com/mivok/markdownlint
[Repo]: https://github.com/christopheradams/elixir_style_guide.git
[Translations]: README.md#translations
[Vim word wrap]: http://vim.wikia.com/wiki/Automatic_word_wrapping
