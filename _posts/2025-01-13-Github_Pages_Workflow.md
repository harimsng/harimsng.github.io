---
layout: post
title: "Github Pages Workflow"
date:   2025-01-13 17:00:00 +0900
categories: github
---
## Github Pages
Github Pages serves static files in the Github repository by using static site generator Jekyll and Github Actions. Github Pages provide default Github Action workflow which is not modifiable and has limitations. My purpose is to understand related concepts and use custom workflow so that my blog uses minima v3.0.0 with dark theme.

## Workflow
Workflow is defined by a YAML file. It has to follow specific syntax for Github Actions to work.
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

## Workflow Templates
[Github Pages tutorial](https://github.com/skills/github-pages) requires using default workflow 'pages-build-deployment' which cannot be modified. I need to change one of Github Pages options to enable custom workflow.
`github.com/{username}/{username}.github.io/settings/pages` contains settings for Github Pages. Open dropdown menu in 'Build from Deployment' - 'Source' and select 'GitHub Actions'.


This is important point because Github Pages does not allow packages and plugins out of its whitelist, which does not include the latest version of minima.
It means that workflow templates tailored for Github Pages should not be used too.


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
