# NextUp: A Project Management Tool

- To get started:
```sh
$ cd NextUp
$ ./Taskfile.sh install  #install dependencies in both client and api directories
$ cp .env.example .env   # Copy env 
```

## Taskfile commands

```sh
./Taskfile.sh install       # installation package-json project dependencies
./Taskfile.sh     # (default) starts the project in dev mode
```

## Abstract Details: 
```
NextUp is a Project Management tool which will facilitate easier job scheduling,task completion, faster planning and help you keep track of deadlines. It aims to help you keep track of day to day tasks and also lets you add in extra work as and when necessary. The Application will consist of two aspects: Mobile Application and the Server Side API. 

Tech Stack for the Mobile Application: 
    - Flutter (Written in Dart Code)
    - State Management tool, i.e., MobX OR Inbuilt State Management of Flutter

Tech Stack for the Server Side API:
    - Node.js (JavaScript’s Runtime Environment)
    - Firebase (For in-app Push Notifications about deadlines and stage completion)
    - MongoDB  (To store stage progression and also track multiple projects)

Flow of the Application: 
 - There are four stages in each project: Ideation, Planning, Coding/Development, Review, Closure/Analysis.
 
 - When a user opens the application, and creates a  new project, He puts in the details such as title, duration, deadline, requirements and personnel.
 
 - This is then set up in the Ideation phase. Once ideation is complete, then the user needs to initiate completion, which is a 2FA using his email, as once the stage is completed, you cannot go back to it. 

 - Similarly, it moves to the subsequent phase until the Analysis stage.

 - The application will consist of two tabs: In Progress & Completed. The project will be in the In Progress tab for the first four stages. The projects in the Analysis stage are placed in the completed tab. 

 - After each stage completion, a push notification will be sent to the respective users of that project using a firebase plugin. 

 -CRON jobs will provide daily reminders using push notifications. 

```

## Requirements to run the project
 - Node.js
 - MongoDB
 - Flutter
 - Redis

 ## Board Structure 
 ##### Stages 
 - 1: Ideation 
 - 2: Planning 
 - 3: Development 
 - 4: Review 
 - 5: Analysis 


The first four stages will be in the in progress tab and the Analysis stage will be pushed into the Completed Tab.