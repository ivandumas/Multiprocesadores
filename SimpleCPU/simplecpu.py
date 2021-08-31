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
    "0" : "0",
    "1" : "0",
    "2" : "0",
    "3" : "0",
    "4" : "0",
    "5" : "0",
    "6" : "0",
    "7" : "0",
    "8" : "0",
    "9" : "0",
    "10" : "0",
    "11" : "0",
    "12" : "0",
    "13" : "0",
    "14" : "0",
    "15" : "0",
    "16" : "0",
    "17" : "0",
    "18" : "0",
    "19" : "0",
    "20" : "0",
}

#code statements
opcodesInstructions = {
  "MOV" : 2,
  "ADD" : 3,
  "SUB" : 3,
  "JMPZ": 2,
}

stack = []
labels = {}
jumps = {}

def format(filename):
  asm_file = open(filename)
  count=0
  count1=0
  asm_line=[]
  for line in asm_file:
    asm_line.append([])
    for word in line.split():
      if ("," in word):
        word1=word.translate({ord(','):None}).upper()
        asm_line[count].append(word1)
      else:
        word1 = word.upper()
        asm_line[count].append(word1)
    count+=1
  
  for lst in asm_line:
    if (len(lst)<1):
      asm_line.remove(lst)
  for lst in asm_line:
    if (len(lst)<1):
      asm_line.remove(lst)

  for line in asm_line:
    if (":" in line[0]):
      word2=line[0].translate({ord(':'):None})
      labels[word2]=count1
    count1+=1

  return asm_line

def error(text, index):
    print("Error:" + text + " in line " + str(index))
    exit()

def mov(args):
    if (len(args)!=opcodesInstructions["MOV"]+1):
        error("More arguments of MOV",args[-1])
    if args[0] in registers:
        if args[1] in memories:
            #Convertimos a binario la parte de registro y memoria
            listToString="".join(args[0])
            pos=listToString.strip('R')
            num=int(pos)
            binario="{0:04b}".format(num)

            listToString1="".join(args[1])
            num1=int(listToString1)
            binario1="{0:08b}".format(num1)
            print("MOV " + args[0] + ", " + args[1]+"\t 0000 "+binario+" "+binario1)
            registers[args[0]] = memories[args[1]]
        elif args[1][0] == "#":
           #Convertimos a binario la parte de registros y número a cargar
            listToString4="".join(args[0])
            pos4=listToString4.strip('R')
            num4=int(pos4)
            binario4="{0:04b}".format(num4)

            listToString5="".join(args[1])
            pos5=listToString5.strip('#')
            num5=int(pos5)
            binario5="{0:08b}".format(num5)
            print("MOV " + args[0] + ", #" + args[1][1:]+"\t 0011 "+binario4+" "+binario5)
            registers[args[0]] = args[1][1:]
        else:
            error(x)
    elif args[0] in memories:
        if args[1] in registers:
			#Convertimos a binario la parte de cargar la memoria con lo del registro
            listToString2="".join(args[1])
            pos2=listToString2.strip('R')
            num2=int(pos2)
            binario2="{0:04b}".format(num2)

            listToString3="".join(args[0])
            num3=int(listToString3)
            binario3="{0:08b}".format(num3)
            print("MOV " + args[0] + ", " + args[1]+"\t 0001 "+binario2+" "+binario3)
            memories[args[0]] = registers[args[1]]
        else:
            error("Second argument of MOV", args[-1])
    else:
        error("First argument of MOV", args[-1])

def add(args):
    if (len(args)!=opcodesInstructions["ADD"]+1):
        error("More arguments of ADD",args[-1])
    if(args[0] in registers and args[1] in registers and args[2] in registers):
        #Convertimos en binario los registros de la suma
        listToString6="".join(args[0])
        pos6=listToString6.strip('R')
        num6=int(pos6)
        binario6="{0:04b}".format(num6)
        
        listToString7="".join(args[1])
        pos7=listToString7.strip('R')
        num7=int(pos7)
        binario7="{0:04b}".format(num7)
        
        listToString8="".join(args[2])
        pos8=listToString8.strip('R')
        num8=int(pos8)
        binario8="{0:04b}".format(num8)
        
        print("ADD " + args[0] + ", " + args[1] + ", " + args[2]+"\t 0010 "+binario6+" "+binario7+" "+binario8)
        registers[args[0]] = str(int(registers[args[1]]) + int(registers[args[2]]))
    else:
        error("Wrong argument on ADD")

def sub(args):
    if (len(args)!=opcodesInstructions["SUB"]+1):
        error("More arguments of SUB",args[-1])
    if(args[0] in registers and args[1] in registers and args[2] in registers):
        #Convertimos en binario los registros de la resta
        listToString9="".join(args[0])
        pos9=listToString9.strip('R')
        num9=int(pos9)
        binario9="{0:04b}".format(num9)
        
        listToString10="".join(args[1])
        pos10=listToString10.strip('R')
        num10=int(pos10)
        binario10="{0:04b}".format(num10)
        
        listToString11="".join(args[2])
        pos11=listToString11.strip('R')
        num11=int(pos11)
        binario11="{0:04b}".format(num11)
        
        print("SUB " + args[0] + ", " + args[1] + ", " + args[2]+"\t 0100 "+binario9+" "+binario10+" "+binario11)
        registers[args[0]] = str(int(registers[args[1]]) - int(registers[args[2]]))
    else:
        error("Wrong argument on SUB")

def jmpz(args, linePointer):
    if(len(args)!=opcodesInstructions["JMPZ"]+1):
        error("More arguments of JMPZ",args[-1])
    if(args[1] in jumps):
        #Convertimos en binario el registro y el offset del salto
        listToString13="".join(args[0])
        pos13=listToString13.strip('R')
        num13=int(pos13)
        binario13="{0:04b}".format(num13)
        
        listToString14=str(jumps[args[1]])
        num14=int(listToString14)
        binario14="{0:08b}".format(num14)
        
        print("JMPZ " + args[0] + ", " + str(jumps[args[1]])+"\t 0101"+" "+binario13+" "+binario14)
        
        if(registers[args[0]] == '0'):
            return jumps[args[1]]
        else:
            linePointer += 1
            return linePointer   
    else:
        error("Wrong offset", args[-1])

def printStack():

  print("---------------------\nREGISTERS\n---------------------")
  for clave, valor in registers.items():
    print(clave,"\t\t",valor)
  print("----------------------\nMEMORY\n----------------------")
  for clave, valor in memories.items():
    print("M",clave,"\t\t",valor)

def checkInstruction(line, index):
    values = []
    semi = False
    for val in line:
        if(val[:2] == "//"):
            break
        elif(val[-1] == ";" and semi == False):
            values.append(val[:-1])
            semi = True
        elif(semi == False):
            values.append(val)
        else:
            error("Extra value after ;", index)
    if(semi == False):
        error("Missing ;", index)
    values.append(index)
    return values

def analysis():
  global linePointer
  linePointer = 0
  asmlist = format("example1.asm")

  equal = False
  finished = False

  #procesamos el archivo
  newList = []
  for i in range(0,len(asmlist)):
      line = asmlist[i]
      #borramos comentarios
      if(line[0] == "//"):
          pass
      #unimos las instrucciones
      elif(":" in line[0][-1]):
          jumps[line[0][:-1]] = len(newList)
          if(len(line) > 1):
              if(line[1] in opcodesInstructions):
                  newList.append([line[1], checkInstruction(line[2:], i)])
              #verificamos los comentarios
              elif(line[1] == "//"):
                  pass
              else:
                  error("Failed statement", i)
      elif(line[0] in opcodesInstructions):
          newList.append([line[0], checkInstruction(line[1:], i)])
      else:
          error("Failed statement", i)

  while(not finished):
      line = newList[linePointer]
      if (line[0]=="MOV"):
          mov(line[1])
          linePointer+=1
      elif (line[0]=="ADD"):
          add(line[1])
          linePointer+=1
      elif (line[0]=="SUB"):
          sub(line[1])
          linePointer+=1
      elif (line[0]=="JMPZ"):
          linePointer = jmpz(line[1],linePointer+1)
      if (linePointer>len(newList)-1):
          finished = True
          break
  printStack()

if __name__ == "__main__":
  analysis()
