### ONLY PYTHON > 3.10


from Directory import Directory
filePath = r"day7.txt"

with open(filePath, "r") as f:
    filesystem = f.read().splitlines()


DIR_SIZE = 100000

home = Directory('home', parent=None)
current_dir = home

for line in filesystem[1:]:

    line = line.split(' ')
    match line[0]:
        case "$":
            if line[1] == 'ls':
                continue
            if line[2] == '..':
                current_dir = current_dir.parent_directory
            else:
                current_dir = Directory(name=line[2], parent=current_dir)
                current_dir.parent_directory.subdirectories.append(current_dir)
                current_dir.parent_directory.subnames.append(current_dir.name)

        case "dir":
            continue
        case _:
            current_dir.files.append(int(line[0]))


def getDirSize(directory):

    global total

    for sub_dir in directory.subdirectories:
        directory.size += getDirSize(sub_dir)

    directory.size += sum(directory.files)
    if directory.size <= DIR_SIZE:
        total += directory.size
    return directory.size


total = 0
x = getDirSize(home)
print(total)
print(x)

#### Part two ####

TOTAL_DISK = 70000000
FREE_NEEDED = 30000000

sizes = []


def printAll(directory):
    sizes.append(
        (directory.size - (FREE_NEEDED - (TOTAL_DISK - x)), directory.size))
    for sub in directory.subdirectories:
        printAll(sub)


printAll(home)

print(list(filter(lambda x: x[0] > 0, sorted(sizes)))[0])
