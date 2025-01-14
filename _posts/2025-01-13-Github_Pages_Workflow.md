---
layout: post
title: "Github Pages Workflow"
date:   2025-01-13 17:00:00 +0900
categories: github
---
## Github Pages
Github Pages serves static files in the Github repository using Github Actions.
Github Pages created by following a [tutorial](https://github.com/skills/github-pages) does not provide workflow definition file. It seems that Github Actions uses default workflow If workflow does not exist. I want create new workflow to use a higher version of Jekyll. So I need to understand what workflow is and know how to write definition file.

## Workflow
Workflow is defined by a YAML file. It has to follow specific syntax for Github Actions to execute.
```
name: workflow_example
...
```
### Event
Workflow is triggered by an event.
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
Workflow consists of one or more jobs.
Each jobs consists of a runner and steps.
```
jobs:
  job1:
    ...
  job2:
    ...
```
#### [Runner](https://docs.github.com/en/actions/using-github-hosted-runners)
A machine that execute a series of steps in the jobs.
```
  job1:
    runs-on: ubuntu-latest
    #runs-on: [self-hosted, "ubuntu-latest"]
```
#### Steps
A step can run a script or an action.
```
  job1:
    steps:
      - name: step 1 # name of a step
        env: # environmental variables used in the runner.
          USER: hseong
        run: | # a command line or multi line with pipe 
          echo hello world
          bash script.sh
      - name: step2
        uses: # select an action
```

## Workflow Templates
Github Pages tutorial requires to use default workflow 'pages-build-deployment' which cannot be modified. I need to change one of Github Pages options to enable custom workflow.


`github.com/{username}/{username}.github.io/settings/pages` contains settings for Github Pages. Open dropdown menu in 'Build from Deployment' - 'Source' and select 'GitHub Actions'.

#### Reference
[About workflows](https://docs.github.com/en/actions/writing-workflows/about-workflows)


[Workflow syntax for Github Actions](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions)


[Github - actions/starter-workflows/pages/jekyll.yml](https://github.com/actions/starter-workflows/blob/main/pages/jekyll.yml)
