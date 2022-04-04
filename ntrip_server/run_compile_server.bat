mkdir ..\..\build
gcc -Wall -W -O3 -DWINDOWSVERSION ntripserver.c -DNDEBUG -o ..\..\build\ntripserver -lwsock32