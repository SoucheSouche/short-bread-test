#include <vector>
#include <string>
#include <iostream>
#include <ShortBread.h>

int main(int argc, char *argv[])
{
    if (argc < 3)
    {
        std::cout << "give 2 words with identical size as argument" << std::endl;
        exit(EXIT_FAILURE);
    }

    ShortBread::init();
    std::vector<std::string> result = ShortBread::getResult(argv[1], argv[2]);

    for (auto &it : result)
    {
        std::cout << it << " ";
    }
    std::cout << std::endl;

    return 0;
}