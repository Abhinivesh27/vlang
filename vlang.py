# project vlang v0.1 (custom programming language)

import sys
# using deque for better peroformance
from collections import deque

# source file loading unit 
file_name = sys.argv[1]
file = open(file_name, "r")
content = file.read()

string_var = deque()
var_var = deque()
var_data = deque()


# lexical and parsing unit
i = 0
while i < len(content):
    if (content[i] == "<"):
        j = i
        while (content[j] != ">"):
            j += 1
        string_var.appendleft(content[i+1:j])
        i = j 
    if (content[i] == "$"):
        j = i 
        while (content[j] !="_"):
            j += 1
        var_var.appendleft(content[i+1:j])
        i = j
    

    if (content[i] == "#"):
         var_book = {var_var[0]:var_data[0]}
         #print(var_book[var_var[0]])

    if (content[i] == "="):
        j = i 
        if (content[i+2]=="<"):
            while (content[j] !=">"):
                j += 1
        var_data.appendleft(content[i+3:j])
        i = j 
    
    if (content[i:i+4] == "disp"):
        j = i 
        while (content[j] != "_"):
            j += 1
        #print(content[i+5:])
        try:
            print(var_book[content[i+6:j]])
        except:
            pass
    i+=1






'''
SYNTAX (v0.1)

for vlang version 0.1 
	1. supports only strings (no string operations)
	2. intrepreted language
	3. <STRING>#
	4. Example: <Velalar>#
	5. # - it indicates end of a line, 
    6. every line of vlang must contain # at its end
    7. variable starts with $ and ends with _
'''