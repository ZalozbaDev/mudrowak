# Jitsi meet custom version step-by-step guide

## customizations

### required

* https://github.com/jitsi/docker-jitsi-meet/pull/1737
* https://github.com/jitsi/docker-jitsi-meet/pull/1343

### nice to have

* https://github.com/jitsi/docker-jitsi-meet/pull/1864
* TBD etherpad with WBO integration

## how to

### fetch all required sources

* clone https://github.com/jitsi/docker-jitsi-meet
    * alternatively: use this version https://github.com/ZalozbaDev/docker-jitsi-meet
    * add upstream origin: git remote add upstream git@github.com:jitsi/docker-jitsi-meet.git
* add fork where VOSK PR branch resides: git remote add PR1343 git@github.com:janonym1/docker-jitsi-meet-VOSK.git
* add fork where fixes to the mandatory PRs reside: git remote add M4GNV5 git@github.com:M4GNV5/docker-jitsi-meet.git
* fetch all new remotes:
	* git fetch upstream
	* git fetch PR1343
	* git fetch M4GNV5
* merge fixes by rebase
	* git checkout M4GNV5/hidden-domain
	* git rebase master
	* git checkout -b rebase-hidden-domain
	* git checkout M4GNV5/vosk-pr-1343
	* git rebase master
	* git checkout -b rebase-pr-1343
	* git merge rebase-hidden-domain
	* fix merge conflict 
	* commit to master
	
### build all containers

