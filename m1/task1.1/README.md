## Module 1 DevOps Introduction

## TASK 1.1 (Git)

### DevOps is ...

DevOps is a methodology which breaks the gap between development and operations. It allows continuous deployment and delivery of a product.
It is archived via automatization of builds, infrastructure deployment, testing and publishing.
DevOps works close with developers and ensures that may change how product is deployed can be implemented without delays.


### Git commands used

* `git config` to setup username, email and core editor

![user name setup](images/scr1.png)
 
* `git clone` 

![cloning](images/scr_clone.png) 

* `git add .` and `git commit -m "<message>"` to add files to be tracked and commit them

![init commit](images/scr_add.png)

* `git branch <branch_name>` to create a new branch
* `git checkout <branch_name>` to go to branch_name

![new brach and checkout](images/scr_branch.png)

  * *This can be done in one command:* `git checkout -b <branch_name>` 
  
  ![one command to branch and checkout](images/scr_check.png)

* `git merge <branch1>` to merge branch1 into a current branch, **need to provide a message with `-m` option if files from current branch to be changed** 

![merge](images/scr_merge.png)

* `git log` 
  * `git shortlog` usefull for short message about changes 
  
  ![shorlog](images/scr_shortlog.png)
  
  * `git log --oneline --graph` 
  
  ![log with options](images/scr_adog.png)
  
  * `git reflog` 
  
  ![reflog](images/scr_reflog.png)
  
[reflog output file](task1.1_GIT.txt)
