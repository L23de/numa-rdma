all: compile archive test

compile:
	javac numa/*.java

archive:
	jar cfmv NUMA.jar Manifest.txt numa/*.class
	rm numa/*.class

test:
	java -jar NUMA.jar

generate:
	python mock/generate.py
	python mock/sqlconvert.py
	mv *.csv mock
	mv aggregate.sql mock

clean:
	rm -f numa/*.class
	rm -f NUMA.jar

clean-all: clean
	rm -f mock/*.csv 
	rm -f mock/*.sql
