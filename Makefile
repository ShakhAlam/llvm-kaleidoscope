SOURCES = $(shell find ast kaleidoscope lexer logger parser -name '*.cpp')
HEADERS = $(shell find ast kaleidoscope lexer logger parser -name '*.h')
OBJ = ${SOURCES:.cpp=.o}

CC = clang-12
#CC = llvm-g++
# -stdlib=libc++ -std=c++11
CFLAGS = -g -O3 -I /usr/lib/llvm-12/include/ -I /usr/lib/llvm-12/build/include -I ./ -std=c++17 -lstdc++
#LLVMFLAGS = 
LLVMFLAGS = `llvm-config-12 --cxxflags --ldflags --system-libs --libs core`

.PHONY: main

main: main.cpp ${OBJ}
	${CC} ${CFLAGS} ${LLVMFLAGS} ${OBJ} $< -o $@

clean:
	rm -r ${OBJ}

%.o: %.cpp ${HEADERS}
	${CC} ${CFLAGS} ${LLVMFLAGS} -c $< -o $@
