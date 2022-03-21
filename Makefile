#

rebuild: clean package

.PHONY: docker

clean:
	mvn clean

package:
	mvn package

docker:
	cd docker-qlik && make 

push: 
	cd docker-qlik && make && make push

