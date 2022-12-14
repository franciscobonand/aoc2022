
filePath = r"day4.txt"

with open(filePath, "r") as f:
    temp = f.read().splitlines()

contains = 0
for line in temp:
    one, two = line.split(',')
    ones_list = one.split('-')
    twos_list = two.split('-')
    ones_list = list(map(int, ones_list))
    twos_list = list(map(int, twos_list))
    if ones_list[0] <= twos_list[0] and ones_list[1] >= twos_list[1]:

        contains += 1
    elif ones_list[0] >= twos_list[0] and ones_list[1] <= twos_list[1]:

        contains += 1
print(contains)



### part two ####

contains = 0
for line in temp:
    one, two = line.split(',')
    ones_list = one.split('-')
    twos_list = two.split('-')
    ones_list = list(map(int, ones_list))
    twos_list = list(map(int, twos_list))
    
    if ones_list[1] >= twos_list[0] and ones_list[0] <= twos_list[0]:
        contains+=1
    elif twos_list[1] >= ones_list[0] and twos_list[0] <= ones_list[0]:
        contains+=1
print(contains)
