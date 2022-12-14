import numpy as np
filePath = r"day3.txt"

with open(filePath, "r") as f:
    temp = f.read().splitlines()
total = 0
for line in temp:
    size = int(len(line)/2)

    first, second = line[:size], line[size:]

    first_array, second_array = [i for i in first], [i for i in second]

    intersect = np.intersect1d(first_array, second_array)
    if ord(intersect[0]) <= 90:
        total += ord(intersect[0])-38

    else:
        total += ord(intersect[0])-96
print(total)



#### part two ####

total = 0
for key in range(0, len(temp), 3):
    first, second, third = temp[key], temp[key+1], temp[key+2]

    first_array, second_array, third_array = [i for i in first], [i for i in second], [i for i in third]

    intersect = np.intersect1d(first_array, second_array)
    intersect = np.intersect1d(third_array, intersect)

    if ord(intersect[0]) <= 90:
        total += ord(intersect[0])-38

    else:
        total += ord(intersect[0])-96
print(total)