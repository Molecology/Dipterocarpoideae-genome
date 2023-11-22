#! /usr/bin/env python
# -*- coding:UTF-8 -*-
import os
import sys
import gzip
file1 = file(sys.argv[1],'r')   #ancester_SNP
file4 = file(sys.argv[4],'w')   #
dic={}
dic1={}   ####Existing SNP sites.
genelist=[]
for line in file1:
	_line=line.strip().split("\t")
	id=pos = '\t'.join(_line[0:2])
	dic[id]=0
with open(sys.argv[2],'r') as f2:  ### VCF 
	for Line in f2:
		if '#' in Line:
			break
	for Line in f2:
		_Line = Line.strip().split("\t")
		pos = '\t'.join(_Line[0:2])
		if not (pos in dic):
			continue
		else:
			dic1[pos]=1
with open(sys.argv[3],'r') as f3:
	for LINE in f3:
		_LINE=LINE.strip().split("\t")
		site_pos='\t'.join(_LINE[3:5])
		geneID = _LINE[2].split(":")[1]
		if not (site_pos  in dic1):
			continue
		else:
			genelist.append(geneID)
Genelist=list(set(genelist))
for ID in Genelist:
	file4.write(ID+'\n')
		
