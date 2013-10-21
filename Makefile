all:
	make Allocator.zip

clean:
	rm -f Allocator.log
	rm -f Allocator.zip
	rm -f TestAllocator
	rm -f TestAllocator.out

doc: Allocator.h
	doxygen Doxyfile

turnin-list:
	turnin --list reza cs371ppj3

turnin-submit: Allocator.zip
	turnin --submit reza cs371ppj3 Allocator.zip

turnin-verify:
	turnin --verify reza cs371ppj3

Allocator.log:
	git log > Allocator.log

Allocator.zip: makefile                            \
               Allocator.h Allocator.log           \
               TestAllocator.c++ TestAllocator.out
	zip -r Allocator.zip                       \
	       html/ makefile                      \
           Allocator.h Allocator.log           \
           TestAllocator.c++ TestAllocator.out

TestAllocator: Allocator.h TestAllocator.c++
	g++ -pedantic -std=c++0x -Wall TestAllocator.c++ -o TestAllocator -lgtest -lpthread -lgtest_main

TestAllocator.out: TestAllocator
	valgrind TestAllocator > TestAllocator.out
