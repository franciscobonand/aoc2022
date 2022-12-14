filePath = r"day2.txt"

with open(filePath, "r") as f:
    temp = f.read().splitlines()

movesDict_1 = {"A": 1, "B":2, "C":3}
movesDict_2 = {"X": 1, "Y":2, "Z":3}

score_round = 0
total = 0
for line in temp:
    first, second = line.split(" ")
    # print(first, second)
    if movesDict_1[first]+1 == movesDict_2[second]:
        score_round = (movesDict_2[second]+6)
    elif movesDict_1[first] == movesDict_2[second]+2:
        score_round = (movesDict_2[second]+6)
    elif movesDict_1[first] == movesDict_2[second]:
        score_round = (movesDict_2[second]+3)
    else:
        score_round = (movesDict_2[second])
    
    total += score_round
print(total)

#### part two ####

movesDict_2 = {"X": 0, "Y":3, "Z":6}
total = 0
for line in temp:
    first, second = line.split(" ")
    
    if second == "X":
        if movesDict_1[first] - 1 == 0:
            my_move = 3
        else:
            my_move = movesDict_1[first] - 1
        score_round = my_move
    elif second == "Y":
        score_round = movesDict_1[first]+3
    else:
        if movesDict_1[first] + 1 == 4:
            my_move = 1
        else:
            my_move = movesDict_1[first] + 1
        score_round = my_move+6
    total += score_round

print(total)