#include "../include/main.hpp"
#include "../include/network_utils.hpp"

int main()
{
    std::cout << "coucou server" << std::endl;

    int server_id = create_socket();
    struct sockaddr_in address;

    bind_socket(server_id, address, 8080);

    const char *message = "connected to server";

    char buffer[1024] = {0};


    listen_socket(server_id);

    while (true) {

        int new_socket = accept_connection(server_id, address);
        std::cout << "nouvel utilisateur connecté" << std::endl;
        send_message(new_socket, message);
        receive_message(new_socket, buffer, 1024);
        std::cout << "message du client : " << buffer << std::endl;
        close(new_socket);
    }

    close(server_id);

    return 0;
}