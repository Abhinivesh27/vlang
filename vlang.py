# project vlang v0.1 (custom programming language)

import sys
# using deque for better peroformance
from collections import deque

# source file loading unit 
file_name = sys.argv[1]
file = open(file_name, "r")
content = file.read()

que = deque()

# lexical and parsing unit
i = 0
while i < len(content):
    if (content[i] == "<"):
        j = i
        while (content[j] != ">"):
            j += 1
        que.appendleft(content[i+1:j])
        i = j
    elif (content[i] == "#"):
        print(que[0])
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

'''