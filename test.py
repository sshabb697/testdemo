#!/usr/bin/python3

import os 
import sys 
import datetime
import glob

def get_size(path):
    size = os.path.getsize(path)
    if size < 1024:
       return f"{size} bytes"
    elif size < 1024*1024:
       return f"{round(size/1024, 2)} KB"
    elif size < 1024*1024*1024:
       return f"{round(size/(1024*1024), 2)} MB"
    elif size < 1024*1024*1024*1024:
       return f"{round(size/(1024*1024*1024), 2)} GB"

def list_file(file_path, day):
  if not os.path.exists(file_path):
    print("Please provide valid path")
    sys.exit(1)
  if os. path.isfile(file_path):
    print("Please provide dictionary path")
    sys.exit(2)
  today=datetime.datetime.now()
  list_of_files = filter( os.path.isfile, glob.glob(file_path + '/**/*') )
  list_of_files = sorted( list_of_files,
                        key =lambda x: os.stat(os.path.join(file_path, x)).st_size,reverse=True)

  for each_file_path in list_of_files:
    if os.path.isfile(each_file_path):
       file_cre_date=datetime.datetime.fromtimestamp(os.path.getctime(each_file_path))
       dif_days=(today-file_cre_date).days
       day=int(day)
       if dif_days>day:
          print(each_file_path,"          ", file_cre_date.day,"-",file_cre_date.month,"-", file_cre_date.year,"     number of the day:", dif_days,"      The file ssize:",get_size(each_file_path))
          os.remove(each_file_path)
  
              


file_path=input("please input the project path: ")
day=input("Numbers of day to list the files and folder greater than: ")
list_file(file_path,day)