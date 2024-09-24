#include "../include/main.hpp"
#include "../include/network_utils.hpp"

int main()
{
    std::cout << "coucou client" << std::endl;

    int sock = create_socket();
    
    char buffer[1024] = {0};

    connect_to_server(sock, "10.10.54.16", 8080);

    receive_message(sock, buffer, 1024);

    if (strlen(buffer) > 0) {
        std::cout << buffer << std::endl;

        char input_test[1024];

        std::cin >> input_test;

        send_message(sock, input_test);
    }

    close(sock);

    // while (true) {

    // }

    return 0;
}