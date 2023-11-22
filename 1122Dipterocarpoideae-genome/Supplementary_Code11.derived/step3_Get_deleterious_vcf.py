#! /usr/bin/env python
# -*- coding:UTF-8 -*-
import os
import sys
import gzip
file1 = file(sys.argv[1],'r')   #snp.var
file2 = file(sys.argv[2],'r')   #variant_function
#file3 = file(sys.argv[3],'r')   #snp
file4 = file(sys.argv[4],'w')
dic={}
dic1={}

for line in file1:
	_line=line.strip().split()
	id=_line[0]+"+"+_line[1]
	dic[id]=id
for Line in file2:
	_Line =Line.strip().split("\t")
	if _Line[2].startswith("evm"):
		ID =_Line[2].split(":")[1]+"+"+_Line[2].split(":")[4][2:-1]
		loc =_Line[3]+_Line[4]
		key =ID+loc
		if ID in dic.keys():
			dic1[loc]=key
#print dic1
with gzip.open(sys.argv[3],'r') as f3:
	for l in f3:
		_l =l.strip().split()
		if l.startswith("#"):continue
		Loc =_l[0]+_l[1]
		if Loc in dic1.keys():
			file4.write(l)


