#include <iostream>
#include <fstream>
#include <string>
#include <tuple>
#include <string_view>

int main()
{

    std::string line;
    std::ifstream input_file("calories.txt");
    std::tuple<int, int, int> three_most_profitable_elfs{0, 0, 0};
    std::tuple<int, std::tuple<int, int, int> &> elfs{0, three_most_profitable_elfs};

    static int compute_three_most_profitable_elves = [&]()
    {
        while (std::getline(input_file, line))
        {
            std::string_view view_line{line};
            auto &[current_elf, most_profitable_elves] = elfs;
            auto &[most_profitable_elf, second_most_profitable_elf, third_most_profitable_elf] = most_profitable_elves;

            if (*view_line.begin() != '\0' && *view_line.begin() != '\n')
            {
                current_elf += std::stoi(line);
            }
            else
            {
                if (current_elf > most_profitable_elf)
                {
                    third_most_profitable_elf = second_most_profitable_elf;
                    second_most_profitable_elf = most_profitable_elf;
                    most_profitable_elf = current_elf;
                }
                else if (current_elf > second_most_profitable_elf)
                {
                    third_most_profitable_elf = second_most_profitable_elf;
                    second_most_profitable_elf = current_elf;
                }
                else if (current_elf > third_most_profitable_elf)
                {
                    third_most_profitable_elf = current_elf;
                }
                current_elf = 0;
            }
        }
        return std::get<0>(three_most_profitable_elfs) + std::get<1>(three_most_profitable_elfs) + std::get<2>(three_most_profitable_elfs);
    }();

    std::cout << "The value of compute_three_most_profitable_elves is : " << compute_three_most_profitable_elves << std::endl;
    return 0;
}