CC = g++
CFLAGS = -Wall -Wextra -Werror -std=c++17

# SHARE
SHARESRCDIR = share/src/
SHARELIBDIR = share/lib/
SHAREBUILDDIR = share/build/
SHAREFILES = network_utils.cpp
SHARESRC = $(addprefix $(SHARESRCDIR), $(SHAREFILES))
SHAREBUILD = $(SHAREFILES:%.cpp=$(SHARESRCDIR)%.o)

# SERVER
SRVSRCDIR = server/src/
SRVLIBDIR = server/lib/
SRVBUILDDIR = server/build/
SRVBINDIR = server/bin/
SRVFILES = main.cpp network_utils.cpp
SRVSRC = $(addprefix $(SRVSRCDIR), $(SRVFILES))
SRVBUILD = $(SRVFILES:%.cpp=$(SRVBUILDDIR)%.o)
SRVEXECNAME = server
SRVEXEC = $(addprefix $(SRVBINDIR), $(SRVEXECNAME))

# CLIENT
CLTSRCDIR = client/src/
CLTLIBDIR = client/lib/
CLTBUILDDIR = client/build/
CLTBINDIR = client/bin/
CLTFILES = main.cpp network_utils.cpp
CLTSRC = $(addprefix $(CLTSRCDIR), $(CLTFILES))
CLTBUILD = $(CLTFILES:%.cpp=$(CLTBUILDDIR)%.o)
CLTEXECNAME = client
CLTEXEC = $(addprefix $(CLTBINDIR), $(CLTEXECNAME))

# Default build target
all: $(SRVEXEC) $(CLTEXEC)

# Link server binary
$(SRVEXEC): $(SRVBUILD)
	$(shell mkdir -p $(SRVBINDIR))
	$(CC) -o $@ $^

# Link client binary
$(CLTEXEC): $(CLTBUILD)
	$(shell mkdir -p $(CLTBINDIR))
	$(CC) -o $@ $^

# Compile server object files
$(SRVBUILDDIR)%.o: $(SRVSRCDIR)%.cpp
	$(shell mkdir -p $(SRVBUILDDIR))
	$(CC) $(CFLAGS) -c -o $@ $<

# Compile client object files
$(CLTBUILDDIR)%.o: $(CLTSRCDIR)%.cpp
	$(shell mkdir -p $(CLTBUILDDIR))
	$(CC) $(CFLAGS) -c -o $@ $<

# Clean object files
clean:
	rm -f $(SRVBUILDDIR)* $(CLTBUILDDIR)*

# Clean binaries
fclean: clean
	rm -f $(SRVEXEC) $(CLTEXEC)
