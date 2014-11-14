compiler=cc
flags=-std=c99 -Wall -g
libraries=-lgmp
exe=powerDigitSum


all: $(exe).c
	$(compiler) $(flags) $(exe).c -o $(exe) $(libraries)

clean:
	rm -f $(exe)
