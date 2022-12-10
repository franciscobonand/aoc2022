#include <iostream>
#include <fstream>
#include <string>
#include <tuple>
#include <unordered_set>

// You gotta know the code is cursed when ya boy is about to use freaking ascii conversions
#define a_ascii_value 97
#define A_ascii_value 65

enum class PriorityLevels
{
    lowest = 1,
    highest = 27
};

int main()
{
    std::fstream my_file("input.txt");
    std::string line;

    // This looks disgusting, it is, but I'm using freaking string_views to split the string in half
    static auto parse_compartments = [&]()
    {
        std::string_view line_view_first_half{&line[0], line.size() / 2};
        std::string_view line_view_second_half{&line[line.size() / 2], line.size() / 2};
        std::tuple<int, int> compartment_lengths{line_view_first_half.length(), line_view_second_half.length()};

        std::string first_compartment(std::get<0>(compartment_lengths), 'x'), second_compartment(std::get<1>(compartment_lengths), 'x');
        char *first_pointer = &first_compartment[0];
        char *second_pointer = &second_compartment[0];

        std::copy(line_view_first_half.begin(), line_view_first_half.end(), first_pointer);
        std::copy(line_view_second_half.begin(), line_view_second_half.end(), second_pointer);

        return std::tuple<std::string, std::string>{first_compartment, second_compartment};
    };

    // This is where the magic happens, I'll use ascii to remove the offset from a or A.
    // This way a = 0, for lower case chars, and A = 0, for upper case chars.
    // Then all I gotta do is just do char - a or char - A and then add the priority (low or high)
    // Ex: (d - a) = (100 - 97) + low = 3 + 1 = 4
    // Ex: (D - A) = (68 - 65) + high = 3 + 27 = 30
    // Nasty trick for sure, probs there is better stuff...
    // Also to not have to iterate over each of the characters all I'm gonna do is create a set with all of the first half chars (dont need reps)
    // And then go through the second half chars, if they are on the set then I'll do my dirty maths

    static auto process_compartments = [](std::string first_compartment, std::string second_compartment)
    {
        int priority_value = 0;
        std::unordered_set<char> whats_popping_first_compartment;
        for (const char &c : first_compartment)
            whats_popping_first_compartment.insert(c);
        for (const char &c : second_compartment)
        {
            if (whats_popping_first_compartment.count(c))
            {
                int ascii_value_of_c = static_cast<int>(c);
                int lowest_priority = static_cast<int>(PriorityLevels::lowest);
                int highest_priority = static_cast<int>(PriorityLevels::highest);

                ascii_value_of_c >= a_ascii_value ? priority_value = (ascii_value_of_c - a_ascii_value + lowest_priority) : priority_value = (ascii_value_of_c - A_ascii_value + highest_priority);
                break;
            }
        }

        return priority_value;
    };

    int priority_level_answer = 0;

    while (getline(my_file, line))
    {
        auto [first_compartment, second_compartment] = parse_compartments();
        priority_level_answer += process_compartments(first_compartment, second_compartment);
    }

    std::cout << "priority_level_answer ::: " << priority_level_answer << std::endl;
    return 0;
}