---
layout: post
title: "Github Pages Workflow"
date:   2025-01-13 17:00:00 +0900
categories: github
---
## Github Pages
Github Pages serves static files in the Github repository using Github Actions by using static site generator Jekyll. Github Pages provide default Github Action workflow which have some limits. I want to create custom workflow where a higher version of Jekyll and minima can be built. My purpose is to understand related concepts and make my blog use minima v3.0.0 with dark theme by adding new workflow.

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
#### Runner
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


This is important point because Github Pages does not allow packages and plugins out of its whitelist, which does not include the latest version of minima.
It means that workflow template for Github Pages should not be used too.
For example, use `jekyll.yml` instead of `jekyll-gh-pages.yml` in [starter-workflows](https://github.com/actions/starter-workflows/tree/main/pages). Major differences are that former has an additional step `Setup Ruby` and there is difference in `Build with Jekyll` step. The latter uses minima of fixed version 2.5.1.

## Local Test
At this point, custom workflow should be working. Test it in local environment if current setup works correctly without any errors. Letting Github Action do the test is very time consuming.
1. Install ruby. If system ruby exists and version is too low, use `rbenv` or similar tool.
2. Make sure `Gemfile` and `_config.yml` don't have Github Pages related options.
3. Run `bundle install` and `bundle exec jekyll serve`.

#### References
[About workflows](https://docs.github.com/en/actions/writing-workflows/about-workflows)


[Workflow syntax for Github Actions](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions)


[Jekyll - Github Actions](https://jekyllrb.com/docs/continuous-integration/github-actions/)
