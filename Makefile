all: build test

build:
	gradle build
	cp numa/build/libs/numa.jar .

test:
	java -jar numa.jar

clean:
	gradle clean
	rm -rf NUMA.jar
