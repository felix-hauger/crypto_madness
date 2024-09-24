#include "../include/network_utils.hpp"
#include <iostream>
#include <cstring>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>

int create_socket() {
    int sock_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (sock_fd == 0) {
        std::cerr << "Échec de la création du socket" << std::endl;
        exit(EXIT_FAILURE);
    }
    return sock_fd;
}

void bind_socket(int server_fd, struct sockaddr_in &address, int port) {
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(port);

    if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
        std::cerr << "Échec du bind" << std::endl;
        close(server_fd);
        exit(EXIT_FAILURE);
    }
}

void listen_socket(int server_fd) {
    if (listen(server_fd, 3) < 0) {
        std::cerr << "Échec du listen" << std::endl;
        close(server_fd);
        exit(EXIT_FAILURE);
    }
}

int accept_connection(int server_fd, struct sockaddr_in &address) {
    int addrlen = sizeof(address);
    int new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen);
    if (new_socket < 0) {
        std::cerr << "Échec de l'acceptation" << std::endl;
        close(server_fd);
        exit(EXIT_FAILURE);
    }
    return new_socket;
}

void connect_to_server(int &sock, const char *server_ip, int port) {
    struct sockaddr_in serv_addr;
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(port);

    if (inet_pton(AF_INET, server_ip, &serv_addr.sin_addr) <= 0) {
        std::cerr << "Adresse invalide" << std::endl;
        exit(EXIT_FAILURE);
    }

    if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) {
        std::cerr << "Échec de la connexion" << std::endl;
        exit(EXIT_FAILURE);
    }
}

ssize_t send_message(int sock, const char *message) {
    return send(sock, message, strlen(message), 0);
}

ssize_t receive_message(int sock, char *buffer, size_t length) {
    return read(sock, buffer, length);
}
