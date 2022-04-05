NTRIP THINGS


# Ntrip Server

## ntripserver

Original github project is：

* [ntripserver]( https://github.com/mwruschel/ntripserver ).
  (c) German Federal Agency for Cartography and Geodesy (BKG), 2002-2007

* [rtcmserver]( https://github.com/aortner/rtcmserver ).




## NTRIP
The ntripserver is a HTTP client based on "Networked Transport of
RTCM via Internet Protocol" (NTRIP). This is an application-level
protocol streaming Global Navigation Satellite System (GNSS) data
over the Internet.
NTRIP Version 1.0 is a generic, stateless protocol based on the
Hypertext Transfer Protocol HTTP/1.1. The HTTP objects are
enhanced to GNSS data streams.

The primary motivation for NTRIP Version 2.0 is to develop a fully
HTTP-compatible Internet protocol standard that would work with proxy
servers and to add an optional data transport via UDP. Hence, one
NTRIP Version 2.0 transport approach is still based on HTTP1.1 on top
of TCP. The second NTRIP Version 2.0 transport approach is based on
both, the Internet Standard Protocol RTSP (Real Time Streaming Protocol)
for stream control on top of TCP and the Internet Standard Protocol RTP
(Real Time Transport Protocol) for data transport on top of
connectionless UDP.

NTRIP is designed for disseminating differential correction data
(e.g in the RTCM-104 format) or other kinds of GNSS streaming data to
stationary or mobile users over the Internet, allowing simultaneous
PC, Laptop, PDA, or receiver connections to a broadcasting host. NTRIP
supports wireless Internet access through Mobile IP Networks like GSM,
GPRS, EDGE, or UMTS.

NTRIP is implemented in three system software components:
*NTRIP clients, NTRIP servers and NTRIP casters*. **The NTRIP caster is the
actual HTTP server program whereas NTRIP client and NTRIP server are
acting as HTTP clients. **



## ntripserver

The program ntripserver is designed to provide real-time data
from a single NTRIP source running under a POSIX operating system.

<u>Basically the ntripserver grabs a GNSS byte stream</u> (Input, Source)
from either

1. a Serial port, or
2. an IP server, or
3. a File, or
4. a SISNeT Data Server, or
5. a UDP server, or
6. an NTRIP Version 1.0 Caster

and forwards that incoming stream to either

1. an NTRIP Version 2.0 Caster via TCP/IP (Output, Destination), or
2. an NTRIP Version 2.0 Caster via RTSP/RTP (Output, Destination), or
3. an NTRIP Version 2.0 Caster via plain UDP (Output, Destination), or
4. an NTRIP Version 1.0 Caster.

Please note, the options to support NTRIP Version 2.0 are currently still
under development and should be used with care. Keep in mind that details
of the NTRIP Version 2.0 transport protocol are still under discussion
and may be changed.




## Installation

### linux
To install the program run

- gunzip ntripserver.tgz
- tar -xf ntripserver.tar
- make, or
- make debug (for debugging purposes).

### compile on windows
To compile the source code on a Windows system where a mingw gcc
compiler is available, you may like to run the following command:

- gcc -Wall -W -O3 -DWINDOWSVERSION ntripserver.c -DNDEBUG  -o ntripserver -lwsock32, or
- mingw32-make, or
- mingw32-make debug



**or visual studio add:**

win_include files, and

ws2_32.lib,







## Usage
The exacutable will show up as ntripserver on Linux
or ntripserver.exe on a Windows system.

### how to use

The user may call the program with the following options:

```CMD
-h|? print this help screen

-E <ProxyHost>       Proxy server host name or address, required i.e. when
        	     running the program in a proxy server protected LAN,
        	     optional
-F <ProxyPort>       Proxy server IP port, required i.e. when running
        	     the program in a proxy server protected LAN, optional
-R <maxDelay>	     Reconnect mechanism with maximum delay between reconnect
        	     attemts in seconds, default: no reconnect activated,
        	     optional




-M <InputMode> Sets the input mode (1 = Serial Port, 2 = IP server,
   3 = File, 4 = SISNeT Data Server, 5 = UDP server, 6 = NTRIP Caster),
   mandatory

   <InputMode> = 1 (Serial Port): (using 8-N-1 = data bits-parity-stop bits)
   -i <Device>       Serial input device, default: /dev/gps, mandatory if
        	     <InputMode>=1
   -b <BaudRate>     Serial input baud rate, default: 19200 bps, mandatory
        	     if <InputMode>=1
   -f <InitFile>     Name of initialization file to be send to input device,
        	     optional

   <InputMode> = 2|5 (IP port | UDP port):
   -H <ServerHost>   Input host name or address, default: 127.0.0.1,
        	     mandatory if <InputMode> = 2|5
   -P <ServerPort>   Input port, default: 1025, mandatory if <InputMode>= 2|5
   -f <ServerFile>   Name of initialization file to be send to server,
        	     optional
   -x <ServerUser>   User ID to access incoming stream, optional
   -y <ServerPass>   Password, to access incoming stream, optional
   -B Bind to incoming UDP stream, optional for <InputMode> = 5

   <InputMode> = 3 (File):
   -s <File>	     File name to simulate stream by reading data from (log)
        	     file, default is /dev/stdin, mandatory for <InputMode> = 3

   <InputMode> = 4 (SISNeT Data Server):
   -H <SisnetHost>   SISNeT Data Server name or address,
        	     default: 131.176.49.142, mandatory if <InputMode> = 4
   -P <SisnetPort>   SISNeT Data Server port, default: 7777, mandatory if
        	     <InputMode> = 4
   -u <SisnetUser>   SISNeT Data Server user ID, mandatory if <InputMode> = 4
   -l <SisnetPass>   SISNeT Data Server password, mandatory if <InputMode> = 4
   -V <SisnetVers>   SISNeT Data Server Version number, options are 2.1, 3.0
        	     or 3.1, default: 3.1, mandatory if <InputMode> = 4

   <InputMode> = 6 (NTRIP Version 1.0 Caster):
   -H <SourceHost>   Source caster name or address, default: 127.0.0.1,
        	     mandatory if <InputMode> = 6
   -P <SourcePort>   Source caster port, default: 2101, mandatory if
        	     <InputMode> = 6
   -D <SourceMount>  Source caster mountpoint for stream input, mandatory if
        	     <InputMode> = 6
   -U <SourceUser>   Source caster user Id for input stream access, mandatory
        	     for protected streams if <InputMode> = 6
   -W <SourcePass>   Source caster password for input stream access, mandatory
        	     for protected streams if <InputMode> = 6




-O <OutputMode> Sets output mode for communatation with destination caster
   1 = http: NTRIP Version 2.0 Caster in TCP/IP mode
   2 = rtsp: NTRIP Version 2.0 Caster in RTSP/RTP mode
   3 = ntrip1: NTRIP Version 1.0 Caster
   4 = udp: NTRIP Version 2.0 Caster in Plain UDP mode
   optional

   Defaults to NTRIP1.0, but will change to 2.0 in future versions
   Note that the program automatically falls back from mode rtsp to mode http and
   further to mode ntrip1 if necessary.

   -a <DestHost>     Destination caster name or address, default: 127.0.0.1,
        	     mandatory
   -p <DestPort>     Destination caster port, default: 2101, mandatory
   -m <DestMount>    Destination caster mountpoint for stream upload,
        	     mandatory
   -n <DestUser>     Destination caster user ID for stream upload to
        	     mountpoint, only for NTRIP Version 2.0 destination
        	     casters, mandatory
   -c <DestPass>     Destination caster password for stream upload to
        	     mountpoint, mandatory
   -N <STR-record>   Sourcetable STR-record
        	     optional for NTRIP Version 2.0 in RTSP/RTP and TCP/IP mode
```



Example1: ***Reading from serial port and forward to NTRIP Version 1.0 Caster:***

```CMD
./ntripserver -M 1 -i /dev/ttys0 -b 9600 
              -O 2 -a www.euref-ip.net -p 2101 -m Mount2 -n serverID -c serverPass
```

Example2: *Reading from NTRIP Version 1.0 Caster and forward to NTRIP Version 2.0*

```CMD
./ntripserver -M 6 -H www.euref-ip.net -P 2101 -D Mount1 -U clientID -W clientPass
              -O 1 -a www.goenet-ip.fi -p 2101 -m Mount2 -n serverID -c serverPass
```



### NTRIP Caster password and mountpoint

Feeding data streams into the NTRIP system using the ntripserver
program needs a password (and a user ID for NTRIP Version 2.0)
and one mountpoint per stream.

For the NTRIP Broadcasters EUREF-IP or IGS-IP this is currently
available from http://igs.bkg.bund.de/index_ntrip_prov.htm




## Disclaimer

Note that this example server implementation is currently an
experimental software. The BKG disclaims any liability nor
responsibility to any person or entity with respect to any loss or
damage caused, or alleged to be caused, directly or indirectly by the
use and application of the NTRIP technology.


## Further information

URL:    http://igs.bkg.bund.de/index_ntrip.htm
E-mail: euref-ip@bkg.bund.de






# Ntrip Caster
[ntrip caster](https://github.com/ALGSS/ntrip_caster) project is forked  [tisyang/ntrip_caster](https://github.com/tisyang/ntrip_caster). This project is serverd as a CORS network's NTRIP caster service program. 

It is developed by c program language and support compiled on windows or linux platform. It is also support high  concurrent  underling  based on single thread and libev.




## usage

### technology pipeline

下面文段中的概念解释：

源 CORS：ntrip server

Ntrip Client ：ntrip caster上虚拟建立的一个用来连接ntrip server的对象

客户端：实际的Ntrip Client。



> ntrip_caster 实现了 Ntrip Caster 和 Client 端均可用的 NTRIP 1.0协议。
>
> 当有客户端连接时，会创建一个到 Caster 的 Client 连接，将客户端的 GGA 数据转发到源 CORS 服务，并将源 CORS 返回的差分数据转发给客户端。细节如下：
>
> + 客户端接入时，验证模块将与数据库中的用户名密码进行比对，失败将拒绝连接。
> + 支持客户端的 source table 源列表请求。
> + 相同的用户名密码客户端重复连接时，将挤出之前的客户端。
> + 客户端连接后，将会从数据库中选择一个**未正在使用的  源 CORS 信息**（用户名、密码、服务器），同步创建一个 Ntrip Client 连接到源 CORS，后续将转发客户端的 GGA 数据和源 CORS 的差分数据，实现中继功能。
> + 客户端和源 CORS 连接会状态同步，即客户端断开，源 CORS 连接也会断开（如果是最后一个客户端的话）；源 CORS 连接断开，也会断开客户端的连接。
> + 如果，新客户端的位置与已有客户端相差不大（当前是30km，可代码中修改）且使用相同的挂载点，则会直接复用已有的源 CORS 连接（1+1基准站流动站作业，支持基站距离移动站50KM以内，都可以实现RTK固定解算）。
>



以上是 ntrip_caster 的原理，实际应用中 ntrip_caster 可以解决的需求场景包括：

1. 源 CORS 的服务重分发以及高效利用。使用多个源 CORS 帐号建立帐号池，然后使用 ntrip_caster 创建多用户，在保证源 CORS 帐号安全的情况下，重分发 CORS 服务。这么做，可以将包月包年的源 CORS 服务以灵活的服务期限进行分发（包天，包周，甚至几个小时）。同时，因为用户一般不会同时进行连接，那么可以进行超量分发，类似于飞机票的“超卖”。
2. 同地区的差分广播。利用 ntrip_caster 客户端差分数据复用的特性，可以利用 1 个 CORS 帐号，实现地区的无限制差分数据服务，覆盖范围可以达到 *1000平方公里（30km x 30km）*。
3. 源 CORS 的安全分享。在不失去已有 CORS 帐号的安全控制前提下，提供新的用户名密码分发已有 CORS 服务给第三方。

ntrip_caster  提供一个管理接口，可以用于用户创建、更新，源 CORS 增加、更新，实时连接查询等。ntrip_caster 也会输出连接日志，并周期打印客户端详细信息。



### DB

ntrip_caster 默认的帐号及源 CORS 数据均保存在数据库中（sqlite3），默认的文件名为 `ntrip_caster.db`。
通常可以使用管理接口来进行管理，而不是使用数据操作数据库。



### interfasces

管理接口以 TCP Server 端口形式提供，默认端口号为 8000（可以在代码中修改)，管理命令为文本格式，提供的管理命令均会使用密码进行验证，确保命令来源可信。管理密码通过环境变量 `CONSOLE_PASSWD` 设置，默认为 `passwd`.

管理接口提供以下命令：

####  USER-LIST 列出所有用户

格式为 `USER-LIST passwd`，命令返回数据库中所有有效的用户名密码，执行正常返回格式为:

```text
OK USER-LIST\r\n
user:pass  2020-12-31 23:59:59\r\n
...\r\n
\r\n
```

其中 `\r\n` 为回车换行，每个用户名密码以冒号分隔，然后是该帐号的过期时刻。

失败返回格式为 `ERROR xxxx\r\n`描述了错误信息。

#### USER-ADD 新增用户

格式为 `USER-ADD passwd user:pass EDATE [ETIME]`，其中 `EDATE` 为用户过期日期，`ETIME` 为过期时间，`ETIME` 为可选，默认为 `23:59:59`。命令向数据库中新增用户名密码以及有效期信息。

命令执行正常返回 `OK USER-ADD\r\n\r\n`，失败返回 `ERROR xxxx\r\n` 描述错误信息。

####  CLIENT-LIST 列出在线用户

格式为 `CLIENT-LIST passwd`, 命令会返回所有在线的用户名密码，执行正常返回格式为：

```text
OK CLIENT-LIST\r\n
user:pass  192.x.x.x 2020-03-31 10:00:00\r\n
...\r\n
\r\n
```

除了消息头和尾部`\r\n`，其他每行表示一个在线用户，分别表示用户名密码、IP地址和登录时间。

失败返回格式为 `ERROR xxxx\r\n`描述了错误信息。

####  USER-UPDATE 更新用户名密码

格式为 `USER-UPDATE passwd user newpass`，命令用于修改用户密码。

执行正常返回 `OK USER-UPDATE\r\n\r\n`，失败返回 `ERROR xxxx\r\n` 描述错误信息。

####  SOURCE-ADD 新增源 CORS 数据

格式为 `SOURCE-ADD passwd SERVER user:pass EDATE [ETIME]`，其中 `SERVER` 为 CORS 服务器 IP，`user:pass` 为 CORS 服务器用户名密码，`EDATE` 为过期日期，`ETIME` 为可选的过期时间，默认为 `23:59:59`。命令向数据库中新增一条源 CORS 数据。这里没有提供服务器端口信息，因为 ntrip_caster 约定自身监听的端口与源 CORS 端口一致。

执行正常返回 `OK SOURCE-ADD\r\n\r\n`，失败返回 `ERROR xxxx\r\n` 描述错误信息。

#### SOURCE-LIST 列出所有源 CORS 数据

格式为 `SOURCE-LIST passwd`，命令会输出所有的源 CORS 数据，执行正常返回格式：

```text
OK SOURCE-LIST\r\n
172.x.x.x user:pass 2020-12-31 23:59:59\r\n
...\r\n
\r\n
```

除了消息头和尾部`\r\n`，其他每行表示一条源 CORS 数据，分别表示IP地址、用户名密码、过期时间。

失败返回格式为 `ERROR xxxx\r\n`描述了错误信息。



#### 备注

ntrip_caster 代码中默认监听 8000（管理端口），8001-8003（Caster端口）。8001-8003 为 Caster 服务端口，这些是针对 qx 设定的，可以根据实际需求修改代码。

8001-8003 服务的 sourcetable 源列表在代码中是复制 qx 的 3 个挂载点 `RTCM23_GPS/RTCM30_GG/RTCM32_GGB` 编写的，可以根据实际需求修改代码。

某些情况下，可能需要隐藏 ntrip_caster 的出口 IP，以避免被源 CORS 服务封禁。可以采取的方式有：

1. 网络代理。将 ntrip_caster 运行主机的出口网络配置代理至另外一台主机。
2. 跳板程序。参考 [tcpredirection](https://github.com/tisyang/tcpredirection)，将 ntrip_caster 的源 CORS IP 指向跳板程序所在主机。



### others

ntrip_caster 是经过实际验证的程序，但还有一些需要改进的地方：

1. 数据库。ntrip_caster 开始使用的是文本存储数据，后来迁移使用了 sqlite3，没有使用其他数据库是为了减少依赖。但从实际考量，使用其他独立数据库是一个比较明确的需求，只是目前没有太多时间进行改进。
2. 源列表。目前程序中是代码写死的源列表，虽然可以靠修改程序代码来适应需求，但这毕竟缺乏弹性。其实有一个更好的实现思路，详见下一条。

3. 基于 TCP 重实现。中继客户端和源 CORS 的连接使用 TCP 实现，在连接中同步解析数据，验证并替换客户端中的密码，以旁路中间人的方式操纵两个连接的数据。这样就无需 ntrip_caster 来提供源列表了。



All other details you can find at [cors-rely document](https://github.com/tisyang/ntrip_caster/blob/master/README.md).



## submodule
```bash
git submodule 

git submodule add https://github.com/tisyang/wsocket.git thirdparties/wsocket/
git submodule add https://github.com/opensource-mirrors/freebsd-queue.git thirdparties/queue/
git submodule add https://github.com/opensource-mirrors/libev.git thirdparties/libev/
git submodule add https://github.com/tisyang/ulog.git thirdparties/ulog/
git submodule add https://github.com/sevensx/ntrip.git thirdparties/ref_ntrip/

git submodule status
git submodule update --init --recursive
```


# maintainer
murphe@qq.com




# license
BSD-3.
