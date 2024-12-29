---
layout: post
title: "Git Basic Usage"
date:   2024-12-30 06:10:00 +0900
categories: git
---

## Basic commands
___

#### git init
Initialize new git repository in the current directory. This command will generate `.git`  directory that contains everything related to the current git repository.

```
cd repository_path
git init
```

#### git add
```
git add source.c log.txt

git add .  # every files

git add *.c  # every .c files
```

Stage specified files before commit. Files filtered by `.gitignore` will not be staged.

Staged files can be unstaged with other git command. Use `git status` to show the command.

You may need to create `.gitignore` file to exclude specific files(automatically generated files, large size files, etc.).

* `.gitignore` example

```
a.out
# generated executable file

*.root
# large size file

*/**
# exclude child directories and files in there.
```
This `.gitignore` example is suitable for managing only source code in the current directory.

#### git status
Print staged files and untracked files and other useful information such as current branch name and unstage command.

New, modified, deleted files are shown as untracked files. 

#### git commit
Commit staged files. This will create a save point that stores current state of the repository. If there are staged or untracked files, user must commit, restore or reset these files.

A commit log contains commit hash, author, date and comment. You can change branch to other commit by using `git checkout COMMIT_HASH` command.

#### git log
List commit logs. There are various options for formatting, ordering, graphical branch representation, etc. 

* `git log --oneline` example

```
...

52b1cef Update README.md

...
```

52b1cef is **commit hash** and following is comment.

#### git checkout
Change current branch to other branch or commit.

```
git checkout 52b1cef   # change to other commit by using commit hash

git checkout main  # change to main branch
```

## Connect Git repository to remote repository
___

#### git remote add origin ADDRESS
Add remote repository and label it origin.

If you are using GitHub, ADDRESS can be either web URL or SSH key. Using URL for address dose not allow modifying the repository directly. Use SSH key If you want to modify the repository without pull request.

#### git push -u origin
Request to synchronize remote repository labeled as origin with local repository.

#### git pull
Try to synchronize local repository with remote repository. It is equivalent to `git pull origin`.

If difference between local and remote cannot be resolved automatically by git, user need to resolve the conflict manually.
