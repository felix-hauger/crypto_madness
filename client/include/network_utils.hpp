#ifndef NETWORK_UTILS_HPP
#define NETWORK_UTILS_HPP

#include <netinet/in.h>

int create_socket();
void bind_socket(int server_fd, struct sockaddr_in &address, int port);
void listen_socket(int server_fd);
int accept_connection(int server_fd, struct sockaddr_in &address);
void connect_to_server(int &sock, const char *server_ip, int port);
ssize_t send_message(int sock, const char *message);
ssize_t receive_message(int sock, char *buffer, size_t length);

#endif
