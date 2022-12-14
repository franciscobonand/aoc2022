filePath = r"day1.txt"

with open(filePath, 'r') as f:
    lines = f.read().split('\n\n')

calories_by_elf = [list(map(int, line.split('\n'))) for line in lines]

print(sorted([sum(elf) for elf in calories_by_elf]))

