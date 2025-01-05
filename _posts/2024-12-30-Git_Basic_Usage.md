---
layout: post
title: "Git Basic Usage"
date:   2024-12-30 06:10:00 +0900
categories: git
---

## Basic commands
___

#### git init
Initialize new git repository in the current directory. This command will create `.git` directory that contains files related to the git repository.

```
cd repository_path
git init
```

#### git add
```
git add source.c log.txt

git add .  # every files except file name is starting with dot.

git add *.c  # files ending with '.c'
```

At some point, user will want to make record for current state of the repository.

Differences between previous commit and current state such as new, modified, deleted files are called untracked files. 

`git add` command stages selected untracked files. Staged files can be unstaged. Use `git status` to show unstage command.

You may need to create `.gitignore` file to prevent specific files(automatically generated files, large files, etc.) being automatically staged.

* `.gitignore` example

```
a.out
# ignore generated executable file

*.root
# ignore data file

*/**
# exclude child directories and files.
```
This `.gitignore` example is suitable for managing only source code in the current directory.

#### git status
Print staged files and untracked files and other useful information such as current branch name and unstage command.

#### git commit
Commit staged files. This will create a save point that stores current state of the repository. Commit logs for the repository are stored at `.git`

A commit log includes commit hash, author, date and comment. You can change branch to other commit by using `git checkout COMMIT_HASH` command.

#### git log
List commit logs. There are various options for formatting, ordering, graphical branch representation, etc.

* `git log --oneline` example

```
...

52b1cef Update README.md

...
```

52b1cef is short version of **commit hash** and following "Update ..." is comment.

#### git checkout
Change current branch to other branch.

```
git checkout 52b1cef   # change to other commit by using commit hash

git checkout main  # change to main branch
```

## Connect Git repository to remote repository
___

#### git remote add origin ADDRESS
Add remote repository and label it origin.

If you are using GitHub, ADDRESS can be either web URL or SSH key. Using URL dose not allow modifying the repository directly. Use SSH key If you want to modify the repository without pull request.

#### git push origin main
Update main branch of remote repository labeled origin using local repository.

#### git pull
Update local repository using remote repository.

If local and remote repository cannot be merged automatically by git, user need to resolve the merge conflict.
