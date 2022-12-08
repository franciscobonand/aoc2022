#include <iostream>
#include <fstream>
#include <string>
#include <tuple>
#include <string_view>

int main()
{

    std::string line;
    std::ifstream input_file("calories.txt");
    std::tuple<int, int> elfs{0, 0};

    bool compute_buffer = [&]()
    {
        while (std::getline(input_file, line))
        {
            std::string_view view_line{line};
            auto &[current_elf, most_profitable_elf] = elfs;

            if (*view_line.begin() != '\0' && *view_line.begin() != '\n')
            {
                current_elf += std::stoi(line);
            }
            else
            {
                if (current_elf > most_profitable_elf)
                {
                    most_profitable_elf = current_elf;
                }
                current_elf = 0;
            }
        }
        return true;
    }();

    std::cout << "The value of old_buffer is : " << std::get<1>(elfs) << std::endl;
    return 0;
}