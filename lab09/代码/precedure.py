import pymysql
from prettytable import PrettyTable

conn = pymysql.connect(host='localhost', user='NKGyh', password='3.1415926', database='dbsclab2022')

cursor = conn.cursor()
dept_name = 'Physics'

try:
    cursor.callproc('get_courses', (dept_name,))
    a = cursor.fetchall()
    table = PrettyTable()
    table.field_names = ('Courses',)
    for i in a:
        table.add_row(i)
    print(table)
finally:
    cursor.close()
    conn.close()
