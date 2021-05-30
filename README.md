# NextUp: A Project Management Tool

<p>
NextUP is a Project Management tool that helps track the progress of a project using a stage
system. It aims to improve the productivity in a project and also implement a structure for
project task segregation. We aim to help users complete their personal as well as group tasks
using this application. Project management application software is designed to plan and
document project tasks and activities, build schedules and timelines, solve project issues,
manage risks and threats, assign budgets and control costs, establish collaboration and
cooperation between project participants, assure and control quality, assemble project teams
and organize human resources, and share information. It allows you to take your project
through all the stages of the project life cycle, from project conceptualization and initiation
through project execution, control and completion.
</p>

## Contributors

-   [Swadhin Routray](https://github.com/swadhinroutray)
-   [Aryaman Singh](https://github.com/aaryaa07)
-   [Saksham Mehta](https://github.com/saksham0403)

## Getting Started

#### Intial steps after cloning the repository

```sh
$ cd NextUp
$ ./Taskfile.sh install  #install dependencies in both client and api directories
$ cp .env.example .env   # Copy env
```

#### Taskfile commands

```sh
./Taskfile.sh install       # installation package-json project dependencies
./Taskfile.sh     # (default) starts the project in dev mode
```

## Dependencies

-   Node.js
-   MongoDB
-   Flutter v2
-   Redis

##### Project Task Stages

-   1: Ideation
-   2: Planning
-   3: Development
-   4: Testing
-   5: Analysis
