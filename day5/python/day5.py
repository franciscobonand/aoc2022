import re
import numpy as np

filePath = r"day5.txt"

with open(filePath, "r") as f:
    stack, moves = f.read().split('\n\n')

def stack_toMatrix(stack_string):
    stack_string = re.sub(r" {4}", " ", stack_string) # remove extra spaces
    
    stack_matrix = stack_string.split('\n')[:-1]      # split lines
    stack_matrix = [row.split(' ') for row in stack_matrix] # split spaces creating a matrix
    transposed = np.transpose(stack_matrix)                 # transpose so we get list of stacks
    return [list(filter(None, i)) for i in transposed]      # leave only crates in the stack (remove empty slots)

def do_move(moves, stack):
    moves = moves.split('\n')
    
    moves_list =  [re.findall(r"\d+", move) for move in moves]
    for move in moves_list:
        qtd, from_stack, to_stack = int(move[0]), int(move[1]), int(move[2])
        to_move = stack[from_stack-1][:qtd]
        stack[from_stack-1] = stack[from_stack-1][qtd:] # remove items from original stack
        for m in to_move:   # insert items into target stack
            stack[to_stack-1].insert(0,m)
        
    for i in stack:
        print(re.sub(r"[\[\]]","",i[0]),end="")


stack_matrix = stack_toMatrix(stack)
do_move(moves, stack_matrix)
print()


#### Part two ####

def do_move(moves, stack):
    moves = moves.split('\n')
    
    moves_list =  [re.findall(r"\d+", move) for move in moves]
    for move in moves_list:

        qtd, from_stack, to_stack = int(move[0]), int(move[1]), int(move[2])
        to_move = stack[from_stack-1][:qtd]
        stack[from_stack-1] = stack[from_stack-1][qtd:] # remove items from original stack
        for m in to_move[::-1]:   # insert items into target stack
            stack[to_stack-1].insert(0,m)
        
    for i in stack:
        print(re.sub(r"[\[\]]","",i[0]),end="")

stack_matrix = stack_toMatrix(stack)
do_move(moves, stack_matrix)