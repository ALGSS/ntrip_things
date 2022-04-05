mkdir ..\..\build
gcc -Wall -W -O3 -DWINDOWSVERSION src\ntripserver.c -DNDEBUG -o ..\..\build\ntripserver -lwsock32