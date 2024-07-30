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

```
export JITSI_RELEASE=stable
// adjust as required
export CUSTOM_RELEASE=stable-9584-1_custom-2

make build_base
docker image tag jitsi/base:latest jitsi/base:$CUSTOM_RELEASE

make build_base-java
docker image tag jitsi/base-java:latest jitsi/base-java:$CUSTOM_RELEASE

make build_jibri
docker image tag jitsi/jibri:latest jitsi/jibri:$CUSTOM_RELEASE

make build_jicofo
docker image tag jitsi/jicofo:latest jitsi/jicofo:$CUSTOM_RELEASE

make build_jigasi
docker image tag jitsi/jigasi:latest jitsi/jigasi:$CUSTOM_RELEASE

make build_jvb
docker image tag jitsi/jvb:latest jitsi/jvb:$CUSTOM_RELEASE

make build_prosody
docker image tag jitsi/prosody:latest jitsi/prosody:$CUSTOM_RELEASE

make build_web
docker image tag jitsi/web:latest jitsi/web:$CUSTOM_RELEASE

// optional: push to docker hub
docker login
for i in base base-java jibri jicofo jigasi jvb prosody web ; do
	echo $i
	docker image tag jitsi/$i:$CUSTOM_RELEASE zalozbadev/jitsi_$i:$CUSTOM_RELEASE
	docker push zalozbadev/jitsi_$i:$CUSTOM_RELEASE
done

```

### configure & run instance

see [README.md](../README.md) in root folder.
