# create a base image that has all of the database clients and odbc drivers we may need.
# The intent is that we will build other images from this one and not run it directly.`
#
name=kafdrop
image=attunitypm/$(name):latest
sourcedir=/home/jneal/src/kafdrop/target
sourcefile=kafdrop-3.28.0-SNAPSHOT.jar
installfile=$(sourcedir)/$(sourcefile)

build: 
	cp $(installfile) .
	docker build --build-arg installfile=$(sourcefile) -t $(image) .
	# Remove dangling images (intermittent images with tag <none>)
	yes | docker image prune > /dev/null
	rm $(sourcefile)

rebuild: nocache build

nocache: 
	# have docker rebuild images from scratch rather than using cache
	$(eval nocache := --no-cache)


push:
	# note that you need to be logged into docker hub with "docker login"
	docker push $(image)


