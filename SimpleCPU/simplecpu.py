registers = {
    "R0" : "0",
    "R1" : "0",
    "R2" : "0",
    "R3" : "0",
    "R4" : "0",
    "R5" : "0",
    "R6" : "0",
    "R7" : "0"
}

memories = {
    "0" : "13",
    "1" : "23",
    "2" : "0",
    "3" : "0",
    "4" : "1",
    "5" : "20",
    "6" : "0",
    "7" : "0",
    "8" : "0",
    "9" : "0",
    "10" : "0",
    "11" : "0",
    "12" : "0",
    "13" : "0",
    "14" : "0",
    "15" : "0"
}

#Instrucciones por Opcode
opcodesInstructions = {
  "MOV" : 2,
  "ADD" : 3,
  "SUB" : 3,
  "JMPZ": 2
}

labels = {}

global linePointer

def format(filename):
  asm_file = open(filename)
  count=0
  count1=0
  asm_line=[]
  for line in asm_file:
    asm_line.append([])
    for word in line.split():
      if ("//" in word):
        break
      if ("," in word):
        word1=word.translate({ord(','):None}).upper()
        asm_line[count].append(word1)
      elif (";" in word):
        word1=word.translate({ord(';'):None}).upper()
        asm_line[count].append(word1)
      else:
        word1 = word.upper()
        asm_line[count].append(word1)
    count+=1

  #print(*asm_line, sep = "\n")
  
  asm_line = list(filter(None, asm_line))
  
  #print(asm_line)

  for line in asm_line:
    #print(line)
    if (":" in line[0]):
      word2=line[0].translate({ord(':'):None})
      #print(word2)
      labels[word2]=count1
    count1+=1
  
  #print(asm_line)

  return asm_line

def error():
  print("ERRORRRRRRRRRRRR PERRO")

def mov(elem1,elem2):
  #print("FUNCION MOV")
  if elem1 in registers:
    if elem2 in memories:
      registers[elem1]=memories[elem2]
    elif elem2[0]=="#":
      registers[elem1]=elem2[1:len(elem2)+1]
    else:
      error()
  elif elem1 in memories:
    if elem2 in registers:
      memories[elem1]=registers[elem2]
    else:
      error()
  else:
    error()

def add(elem1,elem2,elem3):
  #print("FUNCION ADD")
  if (elem1 in registers) and (elem2 in registers) and (elem3 in registers):
    elem2t = registers[elem2]
    elem3t = registers[elem3]
    registers[elem1] = str(int(elem2t) + int(elem3t))
  else:
    error()
    
def sub(elem1,elem2,elem3):
  #print("FUNCION ADD")
  if (elem1 in registers) and (elem2 in registers) and (elem3 in registers):
    elem2t = registers[elem2]
    elem3t = registers[elem3]
    registers[elem1] = str(int(elem2t) - int(elem3t))
  else:
    error()

def jmpz(reg,label):
  global linePointer
  #print("FUNCION JUMP IF EQUAL")
  #print(flag,label)
  global linePointer
  #print("FUNCION JUMP IF EQUAL")
  #print(flag,label)
  if (label in labels) and (reg in registers):
    if (int(registers[reg])==0):
      linePointer=labels[label]
    else:
      linePointer+=1
  else:
    error()

def printMemory():
  print("---------------------\nREGISTERS\n---------------------")
  #keys=gprs.keys()
  #for i in range (len(gprs)):
    #print (keys[0][i])
  for clave, valor in registers.items():
    print(clave,"\t\t",valor)
  print("---------------------\nMEMORY\n---------------------")
  #keys=gprs.keys()
  #for i in range (len(gprs)):
    #print (keys[0][i])
  for clave, valor in memories.items():
    print("M",clave,"\t\t",valor)

def analysis(file):
  global linePointer
  linePointer = 0
  asmlist = format(file)

  equal = False
  finished = False

  while(not finished):
    x=0
    line = asmlist[linePointer]
    if (":" in line[x]):
      x=1
      #print(linePointer)
      if len(line)<2:
        linePointer+=1
        if (linePointer>len(asmlist)-1):
          finished = True
          break
        line = asmlist[linePointer]
        #print(linePointer)
        x=0
    #print(line[0] in opcodesInstructions)
    if (line[x] in opcodesInstructions):
      if (line[x]=="MOV"):
        if (len(line)==(opcodesInstructions["MOV"]+1+x)):
          #print(line[x+1],line[x+2])
          mov(line[x+1],line[x+2])
          linePointer+=1
        else:
          error()
          break
      elif (line[x]=="ADD"):
        #print(opcodesInstructions["ADD"])
        #print(len(line)==(opcodesInstructions["ADD"]+1+x))
        if (len(line)==(opcodesInstructions["ADD"]+1+x)):
          add(line[x+1],line[x+2],line[x+3])
          linePointer+=1
        else:
          error()
          break
      elif (line[x]=="SUB"):
        #print(opcodesInstructions["ADD"])
        #print(len(line)==(opcodesInstructions["ADD"]+1+x))
        if (len(line)==(opcodesInstructions["SUB"]+1+x)):
          add(line[x+1],line[x+2],line[x+3])
          linePointer+=1
        else:
          error()
          break
      elif (line[x]=="JMPZ"):
        #print(opcodesInstructions["SHR"])
        #print(len(line)==(opcodesInstructions["SHR"]+1+x))
        if (len(line)==(opcodesInstructions["JMPZ"]+1+x)):
          jmpz(line[x+1],line[x+2])
        else:
          error()
          break
      else:
        error()
        break
    else:
      #print(line[x])
      error()
      break
    #print(gprs)
    if (linePointer>len(asmlist)-1):
      finished = True
      break
  
    printMemory()

if __name__ == "__main__":
  analysis("SimpleCPU/example2.asm")