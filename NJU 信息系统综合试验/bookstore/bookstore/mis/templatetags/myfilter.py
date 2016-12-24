# 自定义字典过滤器
from django import template
register = template.Library()

def key(d, key_name):
	value = 0
	try:
		value = d[key_name]
	except KeyError:
		value = 0
	return value
register.filter('key', key)

def staff(username, type):
	admin = ['admin', 'TinyCute']
	if username in admin:
		value = 1
		return value
	id = username.find('-')
	if username[0:id] == type:
		value = 1
		return value
	else:
		value = 0
		return value
register.filter('staff', staff)

def strequal(a,b):
	if a==b:
		value = 1
		return value
	else:
		value = 0 
		return value
register.filter('strequal', strequal)

def isbn(foo):
	try:
		isbn = foo.b_isbn.b_isbn
	except:
		isbn = foo.b_isbn
	return isbn
register.filter('isbn', isbn)	
	
def order_date(foo):
	try:
		date = foo.co_date
	except:
		try:
			date = foo.o_date
		except:
			try:
				date = foo.po_date
			except:
				date = foo.i_date
	return date
register.filter('order_date', order_date)
		