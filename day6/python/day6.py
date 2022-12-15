import re

filePath = r"day6.txt"

with open(filePath, "r") as f:
    buffer = f.read()

every4 = [buffer[k:k+4] for k,character in enumerate(buffer)]

for l in every4:
    if len(set(l)) == 4:
        result = l
        break

match = re.search(l, buffer)
print(match.span())


#### part two ####
every14 = [buffer[k:k+14] for k,character in enumerate(buffer)]

for l in every14:
    if len(set(l)) == 14:
        result = l
        break

match = re.search(l, buffer)
print(match.span())
