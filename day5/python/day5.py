import re

filePath = r"E:\desktop\day5.txt"

with open(filePath, "r") as f:
    temp = f.read().splitlines()

# print(temp)


def find_top_crate(stacks, moves):
    top_crates = {}

    for move in moves:
# split the move string into the number of crates and the source and destination stacks
        
        num_crates, from_stack, to_stack = re.findall(r'\d', move)
        print(num_crates, from_stack, to_stack)
        # convert the number of crates and source and destination stacks to integers
        num_crates = int(num_crates)
        from_stack = int(from_stack)
        to_stack = int(to_stack)

        # store the top crates of the source and destination stacks in variables
        from_crate = stacks[from_stack][-num_crates:]
        to_crate = stacks[to_stack][-1]

        # remove the crates from the source stack
        stacks[from_stack] = stacks[from_stack][:-num_crates]

        # add the crates to the destination stack
        stacks[to_stack].extend(from_crate)

        # store the top crate of each stack in the top_crates dictionary
        top_crates[from_stack] = stacks[from_stack][-1]
        top_crates[to_stack] = stacks[to_stack][-1]

    top_crates_list = [top_crates[i] for i in range(1, len(stacks)+1)]
    
    return top_crates_list

stacks = [["Z", "N"], ["M", "C", "D"], ["P"]]
moves = ["move 1 from 2 to 1", "move 3 from 1 to 3", "move 2 from 2 to 1", "move 1 from 1 to 2"]
print(find_top_crate(stacks, moves)) # ["C", "M", "Z"]