# all:

generate:
	python mock/generate.py
	python mock/sqlconvert.py
	mv *.csv mock
	mv *.sql mock

clean:
	rm -f */*.class
	rm -f *.jar
	rm -f *.csv

clean-all: clean
	rm -f mock/*.csv 
	rm -f mock/*.sql
