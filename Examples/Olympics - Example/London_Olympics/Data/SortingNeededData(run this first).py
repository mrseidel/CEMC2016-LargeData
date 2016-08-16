def OpenFile(fileName):
    '''(string) -> (array of strings)
           
    This function opens a file as array
    '''    
    file=open(fileName,'r')
    hold=file.readlines()
    file.close()
    return(hold)
def WriteFile(fileName,fileToWrite):
    '''(string,string) -> ()
               
    This function stores a string as a file
    '''        
    file=open(fileName,'w')
    file.write(fileToWrite)
    file.close()

def SetRange(upper, lower):
    '''(int,int) -> (str)
                   
    This function puts two numbers together seperated by "-"
    '''       
    return (str(lower)+ "-" +str(upper))
def JoinArray(array,addBetween):
    '''(array,string) -> (string)
                   
    This function joins an array to a string with a string in between
    '''       
    arrayHolder=''
    for i in array:
        arrayHolder+=str(i) + addBetween
    return (arrayHolder)

def quickSort(array,low,high):
    '''(array,int,int) -> ()
                   
    This function sorts an array
    '''       
    if (low<high):
        pivotPoint = partition (array,low,high)
        quickSort(array,low,pivotPoint-1)
        quickSort(array,pivotPoint+1,high)
        
def partition(array,low,high):
    '''(array,int,int) -> ()
                   
    This function helps the sorting of an array
    '''       
    pivot=array[low]
    lowerBound=low+1
    upperBound=high
    while(True):
        while (lowerBound<=upperBound and array[lowerBound]<=pivot):
            lowerBound+=1
        while (array[upperBound]>=pivot and upperBound>=lowerBound):
            upperBound-=1
        if (upperBound<lowerBound):
            break
        else:
            array[lowerBound],array[upperBound]=array[upperBound],array[lowerBound]
    array[low],array[upperBound]=array[upperBound],array[low]
    return(upperBound)

tempfilelist=[]
fileString=''
originalFile=[]
print("reading country data")

countrylistraw=OpenFile('country list unprocessed.txt')

print("processing country data")
for i in range(len(countrylistraw)):
    countrylistraw[i]=countrylistraw[i].replace("Côte d'Ivoire","Cote d'Ivoire")
    countrylistraw[i]=countrylistraw[i].replace("São Tomé and Príncipe","Sao Tome and Principe")
    countrylistraw[i]=countrylistraw[i].split()
for i in range(len(countrylistraw)):
    countrylistraw[i].pop(0)
for i in countrylistraw:
    for k in i:
        k=k.replace('[n','')
        if (k.find("(")>=0):
            fileString+=','
        
        fileString+=k+" "
        if (k.find(")")>0):
            break
    fileString+="\n"
    
print("writing country data")
WriteFile('country list Olympic Order.txt',fileString)


tempArray=OpenFile('country list Olympic Order.txt')

quickSort(tempArray,0,len(tempArray)-1)

WriteFile('country list sorted.txt',JoinArray(tempArray,""))

print("reading athlete data")
counter=0
fileString=''
koreaIndex=[]
print("sorting athlete data (removing useless columnns, changing bad format)")

for i in range(0,6):
    originalFile+=OpenFile('London 2012 results, event by event - '+str(i+1)+'.csv')

for i in range(0,len(originalFile)):
    
    tempHold=originalFile[i].split(',')
    
    if (tempHold[2]==''):
        tempHold[2],tempHold[3]=tempHold[3],tempHold[2]
        originalFile[i]=JoinArray(tempHold,',')[:-1]    
   
    originalFile[i]=str(i+1)+ "," + originalFile[i]
    if (originalFile[i].find(' Swi,')>=0 and originalFile[i].find('China')==-1):
        originalFile[i]=originalFile[i].replace(' Swi,',' Switzerland,')
    originalFile[i]=originalFile[i].replace(') Heat',"")
    originalFile[i]=originalFile[i].replace('Srb',"Serbia")        
    originalFile[i]=originalFile[i].replace('(Ivc)',"Cote d'Ivoire")    
    originalFile[i]=originalFile[i].replace('Ivc',"Cote d'Ivoire")
    originalFile[i]=originalFile[i].replace("Côte d'Ivoire","Cote d'Ivoire")
    originalFile[i]=originalFile[i].replace('Viet Nam','Vietnam')
    originalFile[i]=originalFile[i].replace('DPR Korea',"Democratic People's Republic of Korea")
    originalFile[i]=originalFile[i].replace('Russian Fed.','Russian Federation')
    originalFile[i]=originalFile[i].replace("Korea, Democratic People's Republic Of","Democratic People's Republic of Korea")
    originalFile[i]=originalFile[i].replace(' Icl',' Iceland')
    originalFile[i]=originalFile[i].replace('Dominican Rep.','Dominican Republic')
    originalFile[i]=originalFile[i].replace('(SPA)','Spain')
    originalFile[i]=originalFile[i].replace('&','and')
    originalFile[i]=originalFile[i].replace('United Kingdom','Great Britain')
    if (originalFile[i].find(' Rou,')>=0 or originalFile[i].find(',Rou,')>=0 or originalFile[i].find(' Rou ')>=0):
        originalFile[i]=originalFile[i].replace('Rou','Romania')
    if (originalFile[i].find('Venezuela')>=0 and originalFile[i].find('Bolivarian')>=0):
        originalFile[i]=originalFile[i].replace('"Venezuela, Bolivarian Republic Of"','Venezuela')    
WriteFile('original.txt',JoinArray(originalFile,''))

originalFile=OpenFile('original.txt')
originalFile[8021]=originalFile[8021].replace('Dmc','Dominica')
originalFile[9052]=originalFile[9052].replace('Dmc','Dominica')
originalFile[3886]=originalFile[3886].replace('Lit','Liechtenstein')
originalFile[3887]=originalFile[3887].replace('Lit','Liechtenstein')

originalFile[12386]=originalFile[12386].replace('Hong','Hong Kong')
originalFile[9778]=originalFile[9778].replace('Hong','Hong Kong')
originalFile[1863]=originalFile[1863].replace('25 ','')
for i in range(5016,5034):
    originalFile[i]=originalFile[i].replace('"Korea, Republic Of"',"Korea Republic of ")
    originalFile[i]=originalFile[i].replace('"Alexander Mikhaylin, Russia"',"Alexander Mikhaylin")
    tempString=''
    tempArray=originalFile[i].split(',')
    for k in range(0,3):
        tempString+= tempArray[k]+","
    tempString+=tempArray[3] + " " +tempArray[4] +","+ tempArray[5] + " "+ tempArray[6] + "," 
    for k in range(7,len(tempArray)):
        tempString+= tempArray[k]+ ","
    tempString=tempString[:-1]
    originalFile[i]=tempString
    
for i in range(12325,12329):
    tempArray=originalFile[i].split(',')
    tempArray.pop(4)
    tempArray.pop(4)
    tempString=JoinArray(tempArray,',')
    originalFile[i]=tempString[:-1]
tempArray=originalFile[11967].split(',')
tempArray.pop(4)
tempArray.pop(4)
tempString=JoinArray(tempArray,',')
originalFile[11967]=tempString[:-1]
    
for i in range(14927,14931):
    originalFile[i]=originalFile[i].replace(', Hockey"',',", Hockey')

for i in range(14786,14795):    
    if (i!=14787):
        tempHold=originalFile[i].split(',')
        tempHold[6]= '",'+tempHold[6][:-1]
        originalFile[i]=JoinArray(tempHold,',')[:-1]
originalFile.pop(14300)
for i in range(23):
    originalFile.pop(12362)
for i in range(0,4):
    originalFile.pop(12164) 
originalFile.pop(11163)
originalFile.pop(10804)
for i in range(0,3):
    originalFile.pop(9813)
originalFile.pop(7752)
originalFile.pop(7683)
originalFile.pop(2699)
originalFile.pop(1182)
for i in range(len(originalFile)-1,-1,-1):
    if (originalFile[i].find('Date')>=0):
        originalFile.pop(i)

#originalFile[7750]=''

WriteFile('sortedOlympicInfo.txt',JoinArray(originalFile,""))


sortFile=OpenFile('sortedOlympicInfo.txt')

simpleSet=[]
complicatedSet=[]

for i in sortFile:
    if (i.find('"') != -1):
        complicatedSet.append(i)
    else:
        simpleSet.append(i)

WriteFile('complicatedSet.txt',JoinArray(complicatedSet,''))
WriteFile('simpleSet.txt',JoinArray(simpleSet,''))

print("reading country names  (may take a few seconds)")


countrylist=OpenFile('country list sorted.txt')

print("creating Country index")
countryIndexRef='A'
for i in range(len(countrylist)):
    countrylist[i] = countrylist[i][:-1]
    countrylist[i] = countrylist[i].strip()
for i in range(0,len(countrylist)):
    if (countrylist[i][0] != countryIndexRef[len(countryIndexRef)-1]):
        countryIndexRef+=countrylist[i][0]
countryIndex=[]

upperB=-1
lowerB=0
#countryIndex.append(SetRange(upperB,lowerB))
for i in range(len(countryIndexRef)):
    lowerB=upperB+1
    upperB+=2
    for k in range(lowerB,len(countrylist)-1):
        if (countrylist[k][0] != countrylist[k+1][0]):
            upperB=k
            break
    countryIndex.append(SetRange(upperB,lowerB))
#lowerB=upperB+1
#upperB+=1
#countryIndex.append(SetRange(upperB,lowerB))

WriteFile('CountryIndex.txt',JoinArray(countryIndex, '\n'))


complicatedSet= OpenFile('complicatedSet.txt')
tempChar=''
for i in range(0,len(complicatedSet)):
    firstQuotation=False
    tempString=''
    complicatedSet[i]=complicatedSet[i].replace("Korea, Democratic People's Republic Of","Democratic People's, Republic Of Korea")
    
    complicatedSet[i]=complicatedSet[i].replace(" Swi"," Switzerland")
    
    for k in range(0,len(complicatedSet[i])):
        tempChar=complicatedSet[i][k]
        if (tempChar=='"'):
            firstQuotation = not firstQuotation
        elif (firstQuotation==True and tempChar==','):
            pass
        else:
            tempString+=complicatedSet[i][k]
    complicatedSet[i]=tempString

    
WriteFile('complicatedSet2.txt',JoinArray(complicatedSet,''))

finalList = []
print("generating athlete list")

infoHolder=[]
info1=''
info2=''
finalInfo=[]
columnHolder=''
minRange=0
maxRange=0
indexRange=[]
countryPresent2=False
isCountry=False
findInIndex=''
indexLoc=0
firstOneIsBlank=False
countries=[]
x=0
shortform=False;
simpleSet=OpenFile("simpleSet.txt") 
simpleSet+=OpenFile('complicatedSet2.txt')
LineHolder=[]
countryFound=False
for i in range(len(simpleSet)):
    countryPresent=False
    
    firstOneIsBlank=False
    countryFound=False
    
    simpleSet[i] = simpleSet[i][:-1].split(',')
    columnHolder = simpleSet[i][3]
    x=0
    #if (columnHolder==''):
     #   firstOneIsBlank=True
    infoHolder = columnHolder.split()

    for k in infoHolder:
        x+=1
        isCountry=False
        findInIndex=k[0]
        indexLoc = countryIndexRef.find(findInIndex)
        indexRange=countryIndex[indexLoc].split('-')
        minRange=int(indexRange[0])
        maxRange=int(indexRange[1]) + 1
        if (k=='Spa' or k=='(Spa)'):
            k='Spain '
        elif(k==' Swi'):
            k=' Switzerland '        
        for m in range(minRange,maxRange):
            countries=countrylist[m].split()
            shortform=False
            
            for z in range(len(countries)):
                
                if (k==countries[z] or k.find('(')>=0):
                    countryFound=True

                    if (k.find('(')>=0):
                        shortform=True
                    countryPresent = True
                    isCountry=True  
                    if (k == 'Costa'):
                        if (JoinArray(infoHolder,"").find('CostaRica')==-1):
                            countryPresent=False
                            isCountry=False       
                    elif (k=='Chad'):
                        countryPresent=False
                        isCountry=False
                    elif(k=='Georgia'):
                        if (JoinArray(infoHolder,"").find('Georgia Davies')>=0):
                            countryPresent=False
                            isCountry=False      
                    elif(k=='Jordan'):
                        if (JoinArray(infoHolder,"").find('Ernest')>=0):
                            countryPresent=False
                            isCountry=False 
                    elif(k=='El'):
                        if (JoinArray(infoHolder,"").find('Salvador')==-1):
                            countryPresent=False
                            isCountry=False 

                    break
            if (isCountry==True):
                break
        if (isCountry==False):
            info1+= k + " "
        else:
            info1+= ";" + k + " "

    columnHolder2 = simpleSet[i][4]
    if (columnHolder2==''):
        firstOneIsBlank=True
    if (columnHolder2=='Mol'): 
        columnHolder2='Moldova Republic of'
    elif(columnHolder2==' Swi'):
        columnHolder2=' Switzerland'
    infoHolder = columnHolder2.split()
    if (countryPresent==True):
        for k in infoHolder:
            countryPresent2=False
            findInIndex = k[0]
            indexLoc = countryIndexRef.find(findInIndex)
            indexRange=countryIndex[indexLoc].split('-')
            minRange=int(indexRange[0])
            maxRange=int(indexRange[1]) + 1
            for m in range(minRange,maxRange):
                countries=countrylist[m].split()
                for z in range(len(countries)):
                    if (k==countries[z] or k.find('(')>=0):
                        countryPresent2=True
                        break
                if (countryPresent2==True):
                    break
            if (countryPresent2==False):
                info2+= (k+ " ")
            else:
                info2+= ";" + k + " "
        
        if (firstOneIsBlank==False):
        
            addToEnd=';'+simpleSet[i][0] + ';' +simpleSet[i][1] +';' +simpleSet[i][2]
            for k in range(5,len(simpleSet[i])):
                addToEnd+=';'+simpleSet[i][k]        
            info2+= addToEnd + "\n"
    else:
        info1+= ";"+JoinArray(infoHolder," ")
        
    #---------------------------------------------
    addToEnd=';'+simpleSet[i][0] + ';' +simpleSet[i][1] +';' +simpleSet[i][2]
    
    for k in range(5,len(simpleSet[i])):
        addToEnd+=';'+simpleSet[i][k]
    info1+= addToEnd + "\n"  
finalInfo=info1+info2
WriteFile('completeFiltered.txt',finalInfo)

filteredData=OpenFile('completeFiltered.txt')
lenarray=[]
for i in range(len(filteredData)):
    filteredData[i]=filteredData[i].split(';')
    
    if (filteredData[i][0]==''):
        filteredData[i][0]=' Team '
    if (filteredData[i][1]=='Rou '):
        filteredData[i][1]='Romania '
    elif (filteredData[i][1]=='Spa '):
        filteredData[i][1]='Spain'
    elif (filteredData[i][1]=='Swi '):
        filteredData[i][1]='Switzerland'
    elif (filteredData[i][1]=='Korea '):
        if(JoinArray(filteredData[i],'').find('Republic')==-1):
            filteredData[i][1]='Korea Republic of'
    
    filteredData[i]=JoinArray(filteredData[i],';')[:-2]

quickSort(filteredData,0,len(filteredData)-1)
WriteFile('FinalInfo.txt',JoinArray(filteredData,'\n'))

sortedData=OpenFile('FinalInfo.txt')

for i in range(len(sortedData)):
    if (sortedData[i].find("Democratic People's Republic of ;Korea")>=0):
        sortedData[i]=sortedData[i].replace("Democratic People's Republic of ;Korea","Democratic People's Republic of Korea")
    sortedData[i]=sortedData[i].replace("Trinidad and ;Tobago","Trinidad and Tobago")
    if (sortedData[i].find("United States")>=1 and sortedData[i].find("America")==-1):
        sortedData[i]=sortedData[i].replace("United States","United States of America")
        
short=''
countries=OpenFile('country list sorted.txt')
for i in range(len(countries)):
    countries[i]=countries[i].split(',')
for i in range(len(sortedData)):
    sortedData[i]=sortedData[i].split(';')
    if (sortedData[i][1].find('(')>=0 or len(sortedData[i][1].strip())==3):
        short=sortedData[i][1].strip()
        short=short.replace('(','')
        short=short.replace(')','')
            
        short='('+short+')'
        short=short.upper()
        if (short=='(PAL)'):
            sortedData[i][1]=countries[142][0]
        elif(short=='(ICL)'):
            sortedData[i][1]='Iceland'
        elif(short=='(NGE)'):
            sortedData[i][1]='Niger' 
        elif(short=='(SWI)'):
            sortedData[i][1]='Switzerland'   
        elif(short=='(SAN)'):
            sortedData[i][1]='San Marino'
        elif(short=='(VGB)'):
            sortedData[i][1]='British Virgin Islands'
        elif(short=='(LEB)'):
            sortedData[i][1]='Lebanon'
        elif(short=='(MOL)'):
            sortedData[i][1]='Moldova Republic of'
        elif(short=='(SPA)'):
            sortedData[i][1]='Spain'
        for k in countries:
            if (short==k[1].strip()):
                sortedData[i][1]=k[0]                
                break

for i in range(len(sortedData)):
    sortedData[i]=JoinArray(sortedData[i],';')[:-1]
sortedData=JoinArray(sortedData,'')
WriteFile('FinalInfoClean.txt',sortedData)

sortedData=OpenFile('FinalInfoClean.txt')

for i in range(0,len(sortedData)):
    sortedData[i]=sortedData[i].split(';')
    
    sortedData[i][0],sortedData[i][1]=sortedData[i][1],sortedData[i][0]
    
    sortedData[i]=JoinArray(sortedData[i],';')[:-1]
quickSort(sortedData,0,len(sortedData)-1)

for i in range(34):
    sortedData.pop(0)


WriteFile('Final Data Sorted by Country.txt',JoinArray(sortedData,''))

for i in range(0,len(sortedData)):
    sortedData[i]=sortedData[i].split(';')
    
    sortedData[i][0],sortedData[i][1]=sortedData[i][1],sortedData[i][0]
    
    sortedData[i]=JoinArray(sortedData[i],';')[:-1]
quickSort(sortedData,0,len(sortedData)-1)

WriteFile('Final Data Sorted by Name.txt',JoinArray(sortedData,''))



#----
sortedData=OpenFile('Final Data Sorted by Country.txt')
nameList=[]
for i in sortedData:
    tempHold=i.split(';')
    
    if (tempHold[0] != ' Team '):
        nameList.append(tempHold[0]+","+tempHold[1])
nameListShort=[]
nameListShort.append(nameList[0])
for i in nameList:
    if (nameListShort[len(nameListShort)-1]!=i):
        nameListShort.append(i)

WriteFile('Names List.txt',JoinArray(nameListShort,'\n'))

print('Finish')