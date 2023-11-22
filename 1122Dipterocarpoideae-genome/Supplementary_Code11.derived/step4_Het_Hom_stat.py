"""
xxxx
"""
import os
import sys

pos_file = sys.argv[1]
in_file = sys.argv[2]
pos_dict = {}
file_handle = open(pos_file)
with open(pos_file) as file_handle:
    for line in file_handle:
        items = line.strip().split('\t')
        key_str = '\t'.join(items[0: 2])
        pos_dict[key_str] = items[2]

hetStatHash = {}
homVarStatHash = {}
name_duizhao ={}
homstat={}
hetstat={}
Poslist=[]
#het_filehandle = open('het_stat.txt', 'w', encoding='utf-8')
#hom_filehandle = open('hom_stat.txt', 'w', encoding='utf-8')
#outfile =open('Het_Hom_stat.txt', 'w')
outfile=file(sys.argv[3],"w")
with open(in_file) as file_handle:
    for line in file_handle:
        if '##' in line:
            continue
        elif '#CHR' in line:
            items = line.strip().split('\t')
            num = len(items)
            for i, value in enumerate(items):
                name_duizhao[i] = value
                hetStatHash[i] = 0
                homVarStatHash[i] = 0
            break
    
    for line in file_handle:
        items = line.split('\t')
        pos = '\t'.join(items[0: 2])
        if not (pos in pos_dict):
            continue
        items_num = len(items)
        for idx in range(9, items_num):
            gene = items[idx][0:3]
#            line = '\t'.join([name_duizhao[idx], pos, pos_dict[pos], gene])+'\n'
            if gene == '0/1':
#               hetStatHash[idx] = hetStatHash[idx] + 1
#               het_filehandle.write(line)
                hetstat.setdefault(pos, []).append("1")
                Poslist.append(pos)
            elif (gene == '1/1' or gene == '0/0') and gene != pos_dict[pos]:
#                homVarStatHash[idx] = homVarStatHash[idx] + 1
#                hom_filehandle.write(line)
                homstat.setdefault(pos, []).append("1")
                Poslist.append(pos)
outfile.write("Pos\tHet_num\tHom_num\n")
poslist=list(set(Poslist))
for k in poslist:
    K='_'.join(k.split()[:])
    if k in hetstat and k in homstat:
        outfile.write(str(K)+"\t"+str(len(hetstat[k]))+"\t"+str(len(homstat[k]))+"\n")
    if k in hetstat and k not in homstat:
        outfile.write(str(K)+"\t"+str(len(hetstat[k]))+"\t0\n")
    if k not in hetstat and k in homstat:
        outfile.write(str(K)+"\t0\t"+str(len(homstat[k]))+"\n")
