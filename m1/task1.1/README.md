## Module 1 DevOps Introduction

### TASK 1.1 (Git)

### DevOps is ...

#### Git commands used

* `git config` to setup username, email and core editor
![user name setup](images/scr1.png)
 
* `git clone`
![cloning](images/scr_clone.png) 

* `git add .` and `git commit -m "<message>"` to add files to be tracked and commit them
![init commit](images/scr_add.png)

* `git branch <branch_name>` to create a new branch
* `git checkout <branch_name>` to go to branch_name
![new brach and checkout](images/scr_branch.png)

*This can be done in one command: `git checkout -b <branch_name>`*
![one command to branch and checkout](images/scr_check.png)

* `git merge <branch1>` to merge branch1 into a current branch, **one need to provide a message with `-m` option if files from current branch to be changed** 
![merge](images/scr_merge.png)

* `git log`
  * `git shortlog`
  ![shorlog](images/scr_shortlog.png)
  * `git log --oneline --graph`
  ![log with options](images/scr_adog.png)
  * `git reflog`
  ![reflog](images/scr_reflog.png)
