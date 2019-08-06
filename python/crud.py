#
# Basado de la sig. publicación:
#		http://mynotework.blogspot.com/2015/08/python-crud-in-database-sqlserver.html
#
#  PAGINA OFICIAL PARA INSTALAR SQL SERVER Y DRIVER 2017
# SQL Server:
#		https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-2017
#
# Antes de instalar el driver primero instalar FreeTDS le permite a sus programas
# comunicarse de forma nativa con las bases de datos de Microsoft SQL Server y
# Sybase:
#		http://pymssql.org/en/stable/intro.html#install
# :~$ sudo apt-get install freetds-dev
#
# Para mas información:
#		ttp://www.freetds.org/
#
# Driver:
#		http://pymssql.org/en/stable/intro.html#install
# :~$ pip install pymssql --user	
#

import pymssql

conn = pymssql.connect(host='localhost', user='sa', password='.2019ICT', database='TestDB')
cur = conn.cursor() 

#CREATE , INSERT , UPDATE, SELECT always use execute command
cur.execute('CREATE TABLE test(id INT, name VARCHAR(100))')
cur.execute("INSERT INTO test(id,name) VALUES('3','mahendra')")
cur.execute("UPDATE test set name='rony' where id='1'")
cur.execute("DELETE from test where id='1'")
conn.commit() # don't forget to commit after manipulating database

#To retrieve data / select you can do this
cur.execute('SELECT * from test')
row = cur.fetchone()

while row:
      #Index column fields in database always from 0
      print (row[0],row[1])
      row = cur.fetchone()

conn.close() #don't forget close connection after all process CRUD complete