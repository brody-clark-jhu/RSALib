RSA: RSA.o RSALib.o
	gcc RSA.o RSALib.o -g -o RSA

RSA.o: RSA.s
	gcc -g -c RSA.s -o RSA.o

RSALib.o: RSALib.s
	gcc -g -c RSALib.s -o RSALib.o

clean:
	rm -f *.o RSA

