#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jul  7 20:38:48 2023

@author: ningnong
"""

import mysql.connector


# credentials for database connection

credentials = {
  'host' : "localhost",
  "user" : "scott",
  "password" : "4034",
  "database" : "movies"
}


def adduser(username, email, phone_number): 
    
    stmt = 'CALL createuser(%s,%s,%s,@output);'
    
    db = get_db(credentials) 
    
    cursor = db.cursor(prepared=True)
    
    cursor.execute(stmt,(username,email,phone_number))
    
    db.close()
    
    print('Done!')
    
def addreview(username, movie_id, review_rating, review_description): 
    
    stmt = 'CALL addreview(%s,%s,%s,%s,@output);'
    
    db = get_db(credentials)  
    
    cursor = db.cursor(prepared=True)
    
    cursor.execute(stmt, (username,movie_id, review_rating, review_description))
    
    db.close()
    
    print('Done!')
    
    
def add_movie1(movie_name, release_date):
    
    stmt = 'CALL addmovie1(%s,%s,@output);'

    db = get_db(credentials)  
    
    cursor = db.cursor(prepared=True)
    
    cursor.execute(stmt, (movie_name, release_date))
    
    db.close()
    
    print('Done!')
    

def get_movie(movie_name): 
    
    stmt = 'CALL getmovie(%s);'
    
    db = get_db(credentials)  
    
    cursor = db.cursor(prepared=True)
    
    cursor.execute(stmt, (movie_name,))
    
    for row in  cursor.fetchall():
        print(row)
        
    db.close()
    
    
def updatebudget(movie_id, movie_budget): 
    
    stmt = 'CALL updatebudget(%s,%s)'
    
    
    db = get_db(credentials)  
    
    cursor = db.cursor(prepared=True)
    
    cursor.execute(stmt, (movie_id,movie_budget))
    
    db.close()

def get_db(cred):
    
    db = mysql.connector.connect(host=cred['host'], user=cred['user'], 
                                 password=cred['password'], 
                                 database=cred['database'])
    
    return db
    
