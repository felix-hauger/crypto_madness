CC = g++
CFLAGS = -c -Wall -Wextra -Werror -std=c++17

# SERVER
SRVSRCDIR = server/src/
SRVLIBDIR = server/lib/
SRVBUILDDIR = server/build/
SRVBINDIR = server/bin/
SRVFILES = main.cpp
SRVSRC = $(addprefix $(SRVSRCDIR), $(SRVFILES))
SRVBUILD = $(SRVSRC:$(SRVSRCDIR)%.cpp=$(SRVBUILDDIR)%.o)
SRVEXECNAME = server
SRVEXEC = $(addprefix $(SRVBINDIR), $(SRVEXECNAME))

# CLIENT
CLTSRCDIR = client/src/
CLTLIBDIR = client/lib/
CLTBUILDDIR = client/build/
CLTBINDIR = client/bin/
CLTFILES = main.cpp
CLTSRC = $(addprefix $(CLTSRCDIR), $(CLTFILES))
CLTBUILD = $(CLTSRC:$(CLTSRCDIR)%.cpp=$(CLTBUILDDIR)%.o)
CLTEXECNAME = client
CLTEXEC = $(addprefix $(CLTBINDIR), $(CLTEXECNAME))


all: $(SRVEXEC) $(CLTEXEC)


$(SRVEXEC): $(SRVBUILD)
	$(shell mkdir -p $(SRVBINDIR))
	$(CC) -o $@ $^

$(CLTEXEC): $(CLTBUILD)
	$(shell mkdir -p $(CLTBINDIR))
	$(CC) -o $@ $^


$(SRVBUILDDIR)%.o: $(SRVSRC)
	$(shell mkdir -p $(SRVBUILDDIR))
	$(CC) $(CFLAGS) -c -o $@ $^

$(CLTBUILDDIR)%.o: $(CLTSRC)
	$(shell mkdir -p $(CLTBUILDDIR))
	$(CC) $(CFLAGS) -c -o $@ $^


clean :
	rm -f $(SRVBUILDDIR)* $(CLTBUILDDIR)*

fclean : clean
	rm -f $(SRVEXEC) $(CLTEXEC)
