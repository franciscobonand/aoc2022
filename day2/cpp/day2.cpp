#include <iostream>
#include <string>
#include <fstream>
#include <unordered_map>
#include <tuple>

// Self documenting code is a must++ (pun intended)

#define Rock 'A'
#define ResponseRock 'X'
#define Paper 'B'
#define ResponsePaper 'Y'
#define Scissors 'C'
#define ResponseScissors 'Z'

// Turns out the elf was Benito Mussolini and could not explain shit
#define ImALoser 'X'
#define ImTight 'Y'
#define ImSomethingSomething 'Z'

// Y'all got moves and they mean somethin
enum class MoveValues
{
    rock = 1,
    paper,
    scissors
};

// We can win, lose, tie it up
enum class Outcomes
{
    lost = 0,
    draw = 3,
    won = 6
};

// Don't mantain the order and you should perish
std::unordered_map<char, MoveValues> my_response = {
    {Rock, MoveValues::rock},
    {Paper, MoveValues::paper},
    {Scissors, MoveValues::scissors}};

// This will be the possible ways when the elf plays something I will either win, tie or die (I mean lose)
std::unordered_map<char, std::tuple<char, char, char>> elf_crusher = {
    {Rock, {Paper, Rock, Scissors}},
    {Paper, {Scissors, Paper, Rock}},
    {Scissors, {Rock, Scissors, Paper}}};

int main()
{
    int total_score = 0;
    std::ifstream my_file("input1.txt");
    std::string line;
    char elf_move, my_destiny;

    // This is as close to fascism as it can gets
    static auto line_splitter = [&]()
    {
        std::string_view line_view{line};
        elf_move = *line_view.begin();
        my_destiny = *(line_view.begin() + 2);
    };

    while (getline(my_file, line))
    {
        line_splitter();
        auto &[winning_char, we_tie_it_up_tight, life_is_rough] = elf_crusher[elf_move];

        if (my_destiny == ImSomethingSomething)
        {
            total_score += static_cast<int>(Outcomes::won) + static_cast<int>(my_response[winning_char]);
        }
        else if (my_destiny == ImTight)
        {
            total_score += static_cast<int>(Outcomes::draw) + static_cast<int>(my_response[we_tie_it_up_tight]);
        }
        else
        {
            total_score += static_cast<int>(Outcomes::lost) + static_cast<int>(my_response[life_is_rough]);
        }
    }
    std::cout << "Total score value is: " << total_score << std::endl;
    my_file.close();
    return 0;
}