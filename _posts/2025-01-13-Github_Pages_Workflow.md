---
layout: post
title: "Github Pages Workflow"
date:   2025-01-13 17:00:00 +0900
categories: github
---
## Github Pages
Github Pages serves static files in the Github repository by using static site generator Jekyll and Github Actions. Github Pages provide default Github Action workflow which is not modifiable and has limitations. My purpose is to understand related concepts and use custom workflow so that I can have customized blog.

## Workflow
A workflow is defined in a YAML file. It has to follow specific syntax Github Actions can read.
```
name: workflow_example
...
```
### Event
Workflow is triggered by an event.
Example below shows a event definition triggered by `git push` on `main` branch.
```
on:
  push:
    branches:
      - main
```
### Job
Workflow consists of one or more jobs and each job consists of a runner and one or more steps.
```
jobs:
  job1:
    ...
  job2:
    ...
```
#### Runner
A machine that execute a series of steps in a job.
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

## Enable Custom Workflow
`github.com/{username}/{username}.github.io/settings/pages` contains settings for Github Pages. Open dropdown menu in 'Build from Deployment' - 'Source' and select 'GitHub Actions' instead of 'Deploy from a branch' which uses default workflow.


This is important because default workflow of Github Pages does not allows using packages and plugins out of its whitelist.


Also, workflow templates tailored for Github Pages should not be used too.
For example, use `jekyll.yml` instead of `jekyll-gh-pages.yml` in [starter-workflows](https://github.com/actions/starter-workflows/tree/main/pages). The former has an additional step `Setup Ruby`, and the latter uses minima of fixed version 2.5.1 in the step `Build with Jekyll`

## Test Jekyll
At this point, custom workflow is enabled and should be added by using 'New workflow' in Github Actions page or adding the `jekyll.yml` file in `.github/workflow/` directory.


Test the other things like dependencies Gemfile has in local environment. Letting Github Action do the test is very time consuming.
1. Install ruby. If system ruby exists and version is too low, use `rbenv` or similar tool.
2. Make sure `Gemfile` and `_config.yml` don't have Github Pages related options.
3. Run `bundle install` and `bundle exec jekyll serve`.

#### References
[About workflows](https://docs.github.com/en/actions/writing-workflows/about-workflows)


[Workflow syntax for Github Actions](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions)


[Jekyll - Github Actions](https://jekyllrb.com/docs/continuous-integration/github-actions/)
