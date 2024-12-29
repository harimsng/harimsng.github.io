---
title: "Git Basic Usage"
date: 2024-12-30
---

== Basic commands ==

==== git init ====
Initialize new git repository in the current directory. This command will generate <code>.git</code>  directory that contains everything related to the current git repository.

 cd repository_path
 git init

==== git add ====
 git add source.c log.txt
 
 git add .  # every files
 
 git add *.c  # every .c files

Stage specified files before commit. Files filtered by <code>.gitignore</code> will not be staged.

Staged files can be unstaged with other git command. Use <code>git status</code> to show the command.

You may need to create <code>.gitignore</code> file to exclude specific files(automatically generated files, large size files, etc.).

* <code>.gitignore</code> example

 a.out
 # generated executable file
 
 *.root
 # large size file
 
 */**
 # exclude child directories and files in there.
This <code>.gitignore</code> example is suitable for managing only source code in the current directory.

==== git status ====
Print staged files and untracked files and other useful information such as current branch name and unstage command.

New, modified, deleted files are shown as untracked files. 

==== git commit ====
Commit staged files. This will create a save point that stores current state of the repository. If there are staged or untracked files, user must commit, restore or reset these files.

A commit log contains commit hash, author, date and comment. You can change branch to other commit by using <code>git checkout COMMIT_HASH</code> command.

==== git log ====
List commit logs. There are various options for formatting, ordering, graphical branch representation, etc. 

* <code>git log --oneline</code> example

 ...
 
 52b1cef Update README.md
 
 ...

52b1cef is hash and following is comment.

==== git checkout ====
Change current branch to other branch or commit.

 git checkout 52b1cef   # change to other commit
 
 git checkout main  # change to main branch

== Connect Git repository to remote repository ==

==== git remote add origin ADDRESS ====
Add remote repository and label it origin.

If you are using GitHub, ADDRESS can be either web URL or SSH key. Using URL for address dose not allow modifying the repository directly. Use SSH key If you want to modify the repository without pull request.

==== git push -u origin ====
Request to synchronize remote repository labeled as origin with local repository.

==== git pull ====
Try to synchronize local repository with remote repository. It is equivalent to <code>git pull origin</code>.

If difference between local and remote cannot be resolved automatically by git, user need to resolve the conflict manually.
