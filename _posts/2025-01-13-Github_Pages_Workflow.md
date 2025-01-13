---
layout: post
title: "Customize workflow of Github pages"
date:   2025-01-13 17:00:00 +0900
categories: github
---
## Github Pages
Github Pages serves static files in the Github repository using Github Actions.
Github Pages created by following a [tutorial](https://github.com/skills/github-pages) does not provide workflow definition file. It seems that Github Actions uses default workflow If workflow does not exist. I want create new workflow to use a higher version of Jekyll. So I need to understand what workflow is and know how to write definition file.

## Workflow
As its name implies, workflow is consists of a series of works.
```
name: my_workflow
```
### Event
Workflow is triggered by an event. It consists of one or more jobs.
`git push` triggers workflow in almost all cases.
```
on:
	push:
		branches:
			- main
	pull_request:
		branches:
			- main
```
### Job
Job consists of a runner and steps. It will run on a runner machine and run steps.
```
jobs:
	job1:
		...
	job2:
		...
```
#### [Runner](https://docs.github.com/en/actions/using-github-hosted-runners)
A machine that execute jobs.
```
	job1:
		runs-on: ubuntu-latest
		#runs-on: [self-hosted, "ubuntu-latest"]
```
#### Steps
```
	job1:
		steps:
			- name: step 1
			  env:
			  run:
			- name: step2
			  uses:
```
A step can run a script or an action.


#### Reference
[About workflows](https://docs.github.com/en/actions/writing-workflows/about-workflows)
[Workflow syntax for Github Actions](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions)
[Github - actions/starter-workflows/pages/jekyll.yml](https://github.com/actions/starter-workflows/blob/main/pages/jekyll.yml)
