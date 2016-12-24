# coding = utf-8
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render_to_response, render, redirect
from django.template import RequestContext
from bookstore.forms import *
from bookstore.mis.models import *
from django.contrib import auth
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_protect, csrf_exempt
from django.core.urlresolvers import reverse
from django.db.models import Q # filter中使用|
import time, datetime, random, numpy, math


# Create your views here.

def recommend():
	book_list = Book.objects.order_by('-b_date')
	new_book_list = book_list[0:4]
	hot_stock = StockList.objects.order_by('-sl_out_all')[0:4]
	hot_book_list = []
	for foo in hot_stock:
		hot_book_list.append(Book.objects.get(b_isbn=foo.b_isbn))
	recommend_book_list = book_list[6:10]
	return [new_book_list, hot_book_list, recommend_book_list]
	

# 
# 主页面
#
def index(request):
	book_list = recommend()
	new_book_list = book_list[0]
	hot_book_list = book_list[1]
	recommend_book_list = book_list[2]
	book_search = False
	if 'book_search' in request.GET and request.GET['book_search']:
		book_search = True
		book_search_result = Book.objects.filter(b_name__icontains = request.GET['book_search'])
		stock = {}
		for book in book_search_result:
			book_stock = StockList.objects.filter(b_isbn=book.b_isbn)
			if book_stock:
				stock[book.b_isbn] = book_stock[0].sl_stock
			else:
				stock[book.b_isbn] = 0		
	# 禁止已登录管理人员进入客户系统主界面
	if request.user.username:
		if User.objects.get(username = request.user.username).is_superuser:
			return redirect('/staff/')
			return render_to_response('staff/staff.html', locals())
	return render_to_response('index.html', locals())

# 
# 基本界面
#
def register(request):
	register = False
	if request.method == 'POST':
		# 将客户信息添加到Customer表
		id = len(Customer.objects.all()) + 1
		name = request.POST.get('name', '')
		email = request.POST.get('email', '')
		password = request.POST.get('password', '')
		sex = request.POST.get('sex', '')
		address = request.POST.get('address', '')
		Customer.objects.create(c_id=id, c_name=name, c_email=email, c_password=password, c_sex=sex, c_address=address, c_expense=0)
		# 注册成功
		register = True
		# 将客户信息添加到User表
		User.objects.create_user(username=name, email=email, password=password)
	# return render_to_response('test.html', locals())
	return render_to_response('account/register.html', context_instance = RequestContext(request, locals()))

	
@csrf_exempt
def login(request):
	book_list = recommend()
	new_book_list = book_list[0]
	hot_book_list = book_list[1]
	recommend_book_list = book_list[2]
	if request.method == 'POST':
		name = request.POST.get('name', '')
		password = request.POST.get('password', '')
		user = auth.authenticate(username=name, password=password)
		if user is not None:
			auth.login(request, user)
			if user.is_superuser:
				return redirect('/staff/')
				return render_to_response('staff/staff.html', context_instance = RequestContext(request, locals()))
			else:
				return redirect('/')
				return render_to_response('customer/customer.html', context_instance = RequestContext(request, locals()))
		else:
			return render_to_response('index.html', locals())
	else:
		return render_to_response('index.html', locals())

def logout(request):
	book_list = recommend()
	new_book_list = book_list[0]
	hot_book_list = book_list[1]
	recommend_book_list = book_list[2]
	name = request.user.username
	auth.logout(request)
	return render_to_response('account/logout.html', locals())

# 
# 客户系统
#	
# 客户系统主界面
def customer(request):
	book_list = recommend()
	new_book_list = book_list[0]
	hot_book_list = book_list[1]
	recommend_book_list = book_list[2]
	if 'book_search' in request.GET and request.GET['book_search']:
		book_search = Book.objects.filter(b_name__icontains = request.GET['book_search'])
	return render_to_response('customer/customer.html', locals())
# 客户购书模块	
def customer_purchase(request):
	search = False
	book_list = recommend()
	new_book_list = book_list[0]
	hot_book_list = book_list[1]
	recommend_book_list = book_list[2]
	post = False
	if request.method == 'POST':
		post = True
		b_isbn = request.POST.get('isbn', '')
		co_amount = request.POST.get('amount', '')
		if Book.objects.filter(b_isbn=b_isbn):
			book_exist = True
			co_id = len(CustomerOrder.objects.all()) + 1
			c = Customer.objects.get(c_name=request.user.username)
			co_date = time.strftime("%Y-%m-%d", time.localtime())
			b= Book.objects.get(b_isbn=b_isbn)
			co_status = 0
			CustomerOrder.objects.create(co_id=co_id, c_id=c.c_id, b_isbn=b, co_date=co_date, co_amount=co_amount, b_price=b.b_price, co_status = co_status)
			# 库存量判断
			stock = StockList.objects.get(b_isbn=b_isbn)
		else:
			book_exist = False
	return render_to_response('customer/purchase.html', context_instance = RequestContext(request, locals()))
# 客户购书模块（由搜索界面跳转至）	
def customer_purchase_search(request):
	search = True
	book_list = recommend()
	new_book_list = book_list[0]
	hot_book_list = book_list[1]
	recommend_book_list = book_list[2]
	post = False
	if request.method == 'POST':
		post = True
		b_isbn = request.POST.get('isbn', '')
		co_amount = request.POST.get('amount', '')
		if Book.objects.filter(b_isbn=b_isbn):
			book_exist = True
			co_id = len(CustomerOrder.objects.all()) + 1
			c = Customer.objects.get(c_name=request.user.username)
			co_date = time.strftime("%Y-%m-%d", time.localtime())
			b= Book.objects.get(b_isbn=b_isbn)
			co_status = 0
			CustomerOrder.objects.create(co_id=co_id, c_id=c.c_id, b_isbn=b, co_date=co_date, co_amount=co_amount, b_price=b.b_price, co_status = co_status)
		else:
			book_exist = False
	# 查询url中是否包含ISBN号
	url = request.path
	isbn = url.replace('/customer/customer_purchase', '').replace('/', '')
	return render_to_response('customer/purchase.html', context_instance = RequestContext(request, locals()))
# 客户荐书模块
def customer_recommend(request):
	book_list = recommend()
	new_book_list = book_list[0]
	hot_book_list = book_list[1]
	recommend_book_list = book_list[2]
	flag = False
	if request.method == 'POST':
		# 将荐购书籍添加到Book表
		isbn = request.POST.get('isbn', '')
		name = request.POST.get('name', '')
		author = request.POST.get('author', '')
		publisher = request.POST.get('publisher', '')
		date = request.POST.get('date', '')
		price = request.POST.get('price', '')	
		Book.objects.create(b_isbn=isbn, b_name=name, b_author=author, b_publisher=publisher, b_date=date, b_price=price)
		# 荐购成功
		flag = True
		# 将荐购书籍添加到库存帐
		id = len(StockList.objects.all()) + 1
		in_all = 0
		out_all = 0
		stock = in_all - out_all
		StockList.objects.create(sl_id=id, b_isbn=isbn, sl_in_all=in_all, sl_out_all=out_all, sl_stock=stock)
	return render_to_response('customer/recommend.html', context_instance = RequestContext(request, locals()))
# 客户个人资料修改模块
def customer_profile(request):
	flag = False
	name = request.user.username
	if name:
		profile = Customer.objects.get(c_name = name)
		if request.method == 'POST':
			email = request.POST.get('email', '')
			sex = request.POST.get('sex', '')
			address = request.POST.get('address', '')
			# 修改Customer表
			Customer.objects.filter(c_name=name).update(c_email=email, c_sex=sex, c_address=address)
			# 修改User表
			User.objects.filter(username=name).update(email=email)
			flag = True
	return render_to_response('customer/profile.html', context_instance = RequestContext(request, locals()))
# 客户已完成订单显示
def customer_order_finished(request):
	book_list = recommend()
	new_book_list = book_list[0]
	hot_book_list = book_list[1]
	recommend_book_list = book_list[2]
	type = {}
	book = {}
	username = request.user.username
	c_id = Customer.objects.get(c_name=username).c_id
	order_list = CustomerOrder.objects.order_by('-co_id').filter(c_id=c_id).filter(co_status=1)
	for order in order_list:
		type[order.co_id] = u'已完成'
	return render_to_response('customer/order.html', locals())
# 客户未完成订单显示
def customer_order_unfinished(request):
	book_list = recommend()
	new_book_list = book_list[0]
	hot_book_list = book_list[1]
	recommend_book_list = book_list[2]
	type = {}
	username = request.user.username
	c_id = Customer.objects.get(c_name=username).c_id
	order_list = CustomerOrder.objects.order_by('-co_id').filter(c_id=c_id).filter(Q(co_status=0) | Q(co_status=2))
	for order in order_list:
		if order.co_status == 0:
			type[order.co_id] = u'未处理'
		else:
			type[order.co_id] = u'采购中'
	return render_to_response('customer/order.html', locals())

# 
# 管理系统
#
# 管理员系统主界面（不同部门浏览界面权限不同）
def staff(request):
	book_list = recommend()
	new_book_list = book_list[0]
	hot_book_list = book_list[1]
	recommend_book_list = book_list[2]
	book_search = False
	if 'book_search' in request.GET and request.GET['book_search']:
		book_search = True
		book_search_result = Book.objects.filter(b_name__icontains = request.GET['book_search'])
		stock = {}
		for book in book_search_result:
			book_stock = StockList.objects.filter(b_isbn=book.b_isbn)
			if book_stock:
				stock[book.b_isbn] = book_stock[0].sl_stock
			else:
				stock[book.b_isbn] = 0	
	# 禁止已登录客户进入管理系统主界面
	if request.user.username:
		if not User.objects.get(username = request.user.username).is_superuser:
			return redirect('/')
			return render_to_response('index.html', locals())
	return render_to_response('staff/staff.html', locals())
	
### 销售部
# 客户基本信息
def staff_sales_profile(request):
	customer_list = Customer.objects.order_by('-c_expense')
	return render_to_response('staff/sales/customer_profile.html', locals())
# 客户订单显示
def staff_sales_profile_order(request, offset):
	type = {}
	c_id = int(offset)
	c_name = Customer.objects.get(c_id=c_id).c_name
	order_list = CustomerOrder.objects.filter(c_id=c_id).order_by('-co_id')
	for foo in order_list:
		if foo.co_status == 0:
			type[foo.co_id] = u'未处理'
		elif foo.co_status == 1:
			type[foo.co_id] = u'已完成'
		elif foo.co_status == 2:
			type[foo.co_id] = u'采购中'
	return render_to_response('staff/sales/customer_profile_order.html', locals())
# 图书库存量查询	
def staff_sales_stock(request):
	stock_list = StockList.objects.order_by('b_isbn')
	book = {}
	for stock in stock_list:
		isbn = stock.b_isbn
		b_name = Book.objects.get(b_isbn=isbn).b_name
		book[isbn] = b_name	
	return render_to_response('staff/sales/stock_set.html', locals())
# 客户订单显示
def staff_sales_order(request):
	type=u'已完成'
	order = CustomerOrder.objects.filter(co_status=1).order_by('-co_id')
	return render_to_response('staff/sales/customer_order.html', locals())
# 已完成订单查询
def staff_sales_order_finished(request):
	type=u'已完成'
	order = CustomerOrder.objects.filter(co_status=1).order_by('-co_id')
	return render_to_response('staff/sales/customer_order.html', locals())
# 有货订单查询
def staff_sales_order_stockin(request):
	type=u'有货'
	order_u = CustomerOrder.objects.filter(co_status=0).order_by('co_id')
	order = []
	stock = {}
	for foo in order_u:
		if foo.b_isbn.b_isbn in stock:
			sl_stock = stock[foo.b_isbn.b_isbn]
		else:
			sl_stock = StockList.objects.get(b_isbn=foo.b_isbn.b_isbn).sl_stock
			stock[foo.b_isbn.b_isbn] = sl_stock
		if sl_stock>=foo.co_amount:
			order.append(foo)
			stock[foo.b_isbn.b_isbn] = stock[foo.b_isbn.b_isbn] - foo.co_amount
	return render_to_response('staff/sales/customer_order.html', locals())
# 缺货订单查询
def staff_sales_order_stockout(request):
	type=u'缺货'
	order_u = CustomerOrder.objects.filter(co_status=0).order_by('co_id')
	order = []
	stock = {}
	for foo in order_u:
		if foo.b_isbn.b_isbn in stock:
			sl_stock = stock[foo.b_isbn.b_isbn]
		else:
			sl_stock = StockList.objects.get(b_isbn=foo.b_isbn.b_isbn).sl_stock
			stock[foo.b_isbn.b_isbn] = sl_stock
		if sl_stock<foo.co_amount:
			order.append(foo)
		else:
			stock[foo.b_isbn.b_isbn] = stock[foo.b_isbn.b_isbn] - foo.co_amount
	return render_to_response('staff/sales/customer_order.html', locals())
# 采购中订单查询
def staff_sales_order_purchase(request):
	type=u'采购中'
	order = CustomerOrder.objects.filter(co_status=2).order_by('-co_id')
	return render_to_response('staff/sales/customer_order.html', locals())
# 出货单查询
def staff_sales_order_out(request):
	type=u'已出库'
	order = OutList.objects.all().order_by('-o_id')
	return render_to_response('staff/sales/customer_order.html', locals())
# 未完成订单处理
def staff_sales_order_process(request):
	order_u = CustomerOrder.objects.filter(co_status=0).order_by('co_id')
	order_in = []
	order_out =[]
	stock = {}
	for foo in order_u:
		if foo.b_isbn.b_isbn in stock:
			sl_stock = stock[foo.b_isbn.b_isbn]
		else:
			sl_stock = StockList.objects.get(b_isbn=foo.b_isbn.b_isbn).sl_stock
			stock[foo.b_isbn.b_isbn] = sl_stock
		if sl_stock>=foo.co_amount:
			order_in.append(foo)
			# 订单可以被满足，修改stock值
			stock[foo.b_isbn.b_isbn] = stock[foo.b_isbn.b_isbn] - foo.co_amount
		else:
			order_out.append(foo)
	# 有货单处理
	for foo in order_in:
		# 客户订单修改
		CustomerOrder.objects.filter(co_id=foo.co_id).update(co_status=1)
		# 出货单添加
		o_id = len(OutList.objects.all()) + 1
		o_date = time.strftime("%Y-%m-%d", time.localtime())
		OutList.objects.create(o_id=o_id, co_id=foo.co_id, o_date=o_date, c_id=foo.c_id, b_isbn=foo.b_isbn.b_isbn, co_amount=foo.co_amount, b_price=foo.b_price)
		# 库存帐修改（出库）
		b_isbn = foo.b_isbn.b_isbn
		stock = StockList.objects.filter(b_isbn=b_isbn)
		sl_in_all = stock[0].sl_in_all
		sl_out_all = stock[0].sl_out_all + foo.co_amount
		sl_stock = sl_in_all - sl_out_all
		stock.update(sl_out_all=sl_out_all, sl_stock=sl_stock)	
		# 客户开销修改
		customer = Customer.objects.get(c_id=foo.c_id)
		expense = customer.c_expense + foo.b_price*foo.co_amount
		Customer.objects.filter(c_id=foo.c_id).update(c_expense=expense)

	# 缺货单处理
	for foo in order_out:
		po_id = len(PurchaseOrder.objects.all()) + 1
		# 客户订单修改
		CustomerOrder.objects.filter(co_id=foo.co_id).update(co_status=2)
		# 采购单添加
		po_date = time.strftime("%Y-%m-%d", time.localtime())
		po_status = 0
		b_price = foo.b_price
		PurchaseOrder.objects.create(po_id=po_id, b_isbn=foo.b_isbn, co_id=foo.co_id, po_date=po_date, po_amount=foo.co_amount, po_price=b_price*0.6, po_status=po_status)

		
	return render_to_response('staff/sales/customer_order.html', locals())

### 采购部
# 供应商管理
@csrf_exempt
def staff_purchase_supplier(request):
	supplier_list = Supplier.objects.order_by('-s_score')
	post = False
	if request.method == 'POST':
		s_name = request.POST.get('name', '')
		s_score = request.POST.get('score', '')
		if s_name:
			s_id = len(Supplier.objects.all()) + 1 
			Supplier.objects.create(s_id=s_id, s_name=s_name, s_score=s_score)
			post = True	
	return render_to_response('staff/purchase/supplier.html', locals())
# 采购单显示
def staff_purchase_order(request):
	type = u'已处理'
	order_list = PurchaseOrder.objects.filter(po_status=1).order_by('-po_id')
	now = datetime.date.today()
	weekday = now.weekday()
	return render_to_response('staff/purchase/purchase_order.html', locals())
# 已完成采购单显示
def staff_purchase_order_finished(request):
	type = u'已处理'
	order_list = PurchaseOrder.objects.filter(po_status=1).order_by('-po_id')
	now = datetime.date.today()
	weekday = now.weekday()
	return render_to_response('staff/purchase/purchase_order.html', locals())
# 入库单显示
def staff_purchase_order_in(request):
	type = u'已入库'
	order_list = InList.objects.all().order_by('-i_id')
	now = datetime.date.today()
	weekday = now.weekday()
	return render_to_response('staff/purchase/purchase_order.html', locals())
# 未完成采购单显示
def staff_purchase_order_unfinished(request):
	type = u'未处理'
	order_list = PurchaseOrder.objects.filter(po_status=0).order_by('po_id')
	now = datetime.date.today()
	weekday = now.weekday()
	return render_to_response('staff/purchase/purchase_order.html', locals())
# 未完成采购单处理
def staff_purchase_order_process(request):

	order = PurchaseOrder.objects.filter(po_status=0).order_by('po_id')
	# 轮盘赌选择供应商
	supplier = Supplier.objects.all()
	p = {}
	sum = 0
	for foo in supplier:
		sum += foo.s_score
	tmp = 0.0
	rand = random.random()
	for foo in supplier:
		tmp = tmp + foo.s_score	
		p[foo.s_id] = tmp/sum
		print foo.s_id,',', p[foo.s_id], ',', tmp 
		if p[foo.s_id]>rand:
			s_id = foo.s_id
			break
	rand = random.random()
	for foo in order:
		# 80%机会有货
		if rand>0.2:
			# 有货，采购订单得到满足
			PurchaseOrder.objects.update(po_status=1, s=s_id)
			# 入库单添加
			i_id = len(InList.objects.all()) + 1
			po_id = foo.po_id
			i_date = time.strftime("%Y-%m-%d", time.localtime())
			s_id = s_id
			co_id = foo.co_id
			b_isbn = foo.b_isbn.b_isbn
			po_amount = foo.po_amount
			po_price = foo.po_price
			InList.objects.create(i_id=i_id, po_id=po_id, i_date=i_date, s_id=s_id, co_id=co_id, b_isbn=b_isbn, po_amount=po_amount, po_price=po_price)
			# 库存帐修改（入库）
			b_isbn = foo.b_isbn.b_isbn
			stock = StockList.objects.filter(b_isbn=b_isbn)
			sl_in_all = stock[0].sl_in_all + po_amount
			sl_out_all = stock[0].sl_out_all 
			sl_stock = sl_in_all - sl_out_all
			stock.update(sl_in_all=sl_in_all, sl_stock=sl_stock)
			# 判断是否是顾客的缺货订单
			if foo.co_id:
				CustomerOrder.objects.filter(co_id=foo.co_id).update(co_status=1)
				# 出库单添加
				o_id = len(OutList.objects.all()) + 1
				o_date = time.strftime("%Y-%m-%d", time.localtime())
				c_id = CustomerOrder.objects.get(co_id=foo.co_id).c_id
				b_price = Book.objects.get(b_isbn=b_isbn).b_price
				OutList.objects.create(o_id=o_id, co_id=foo.co_id, o_date=o_date, c_id=c_id, b_isbn=b_isbn, co_amount=po_amount, b_price=b_price)
				# 库存帐修改（出库）
				b_isbn = foo.b_isbn.b_isbn
				stock = StockList.objects.filter(b_isbn=b_isbn)
				sl_in_all = stock[0].sl_in_all
				sl_out_all = stock[0].sl_out_all + po_amount
				sl_stock = sl_in_all - sl_out_all
				stock.update(sl_out_all=sl_out_all, sl_stock=sl_stock)
				# 客户开销修改
				customer = Customer.objects.get(c_id=c_id)
				expense = customer.c_expense + b_price*foo.po_amount
				Customer.objects.filter(c_id=c_id).update(c_expense=expense)
	return 	redirect('/staff/purchase/purchase_order/unfinished/')						
	return render_to_response('staff/purchase/purchase_order.html', locals())
# 策略补货显示（经济批量+安全库存）
def staff_purchase_strategy(request):
	post = False
	now = datetime.date.today()
	weekday = now.weekday()
	lead_time = 1
	strategy_list = []
	safety_stock = {}
	book_stockout = {}
	order_quantity = {}
	std = {}
	mean = {}
	start_date = datetime.date.today() - datetime.timedelta(days=lead_time)
	end_date = datetime.date.today()
	scale_date = (end_date-start_date).days + 1
	stock_list = StockList.objects.all()
	for book in stock_list:
		# 计算该书的安全库存量
		# 服务水平：96% 1.75 | 提前期： 1天  | 标准差：今天与昨天的需求标准差
		z = 1.75			
		# 计算需求标准差
		out_list = OutList.objects.filter(o_date__range=[start_date, end_date]).filter(b_isbn=book.b_isbn)
		demand = []
		# 计算start_date - end_date间每一天的需求量
		date = start_date
		for i in range(scale_date):
			amount = 0
			for out in out_list:
				if out.o_date == date:
					amount += out.co_amount
			demand.append(amount)
			date = date + datetime.timedelta(days=1)
		# time range内如果该书有销售的话，再考虑补货
		if out_list:
			std[book.b_isbn] = int(round(numpy.std(demand)))
			mean[book.b_isbn] = int(round(numpy.mean(demand)))
			safety_stock[book.b_isbn] = int(round(z * math.sqrt(lead_time) * std[book.b_isbn]))
			# 确定是否要补货
			if book.sl_stock<safety_stock[book.b_isbn]:
				strategy_list.append(book)
				book_stockout[book.b_isbn] = Book.objects.get(b_isbn=book.b_isbn).b_name
				# 确定经济批量 单次订货成本：100 | 需求量：今天与昨天的需求均值 | 库存成本：10
				C = 100
				R = mean[book.b_isbn]
				H = 10
				order_quantity[book.b_isbn] = int(round(math.sqrt(2*C*R/H)))
		
	return render_to_response('staff/purchase/strategy.html', locals())
# 策略补货处理（经济批量+安全库存）
def staff_purchase_strategy_process(request):
	post = True
	now = datetime.date.today()
	weekday = now.weekday()
	lead_time = 1
	strategy_list = []
	safety_stock = {}
	book_stockout = {}
	order_quantity = {}
	std = {}
	mean = {}
	start_date = datetime.date.today() - datetime.timedelta(days=lead_time)
	end_date = datetime.date.today()
	scale_date = (end_date-start_date).days + 1
	stock_list = StockList.objects.all()
	for book in stock_list:
		# 计算该书的安全库存量
		# 服务水平：96% 1.75 | 提前期： 1天  | 标准差：今天与昨天的需求标准差
		z = 1.75			
		# 计算需求标准差
		out_list = OutList.objects.filter(o_date__range=[start_date, end_date]).filter(b_isbn=book.b_isbn)
		demand = []
		# 计算start_date - end_date间每一天的需求量
		date = start_date
		for i in range(scale_date):
			amount = 0
			for out in out_list:
				if out.o_date == date:
					amount += out.co_amount
			demand.append(amount)
			date = date + datetime.timedelta(days=1)
		# time range内如果该书有销售的话，再考虑补货
		if out_list:
			std[book.b_isbn] = int(round(numpy.std(demand)))
			mean[book.b_isbn] = int(round(numpy.mean(demand)))
			safety_stock[book.b_isbn] = int(round(z * math.sqrt(lead_time) * std[book.b_isbn]))
			# 确定是否要补货
			if book.sl_stock<safety_stock[book.b_isbn]:
				strategy_list.append(book)
				book_stockout[book.b_isbn] = Book.objects.get(b_isbn=book.b_isbn).b_name
				# 确定经济批量 单次订货成本：100 | 需求量：今天与昨天的需求均值 | 库存成本：10
				C = 100
				R = mean[book.b_isbn]
				H = 10
				order_quantity[book.b_isbn] = int(round(math.sqrt(2*C*R/H)))
				# 添加策略补货订单
				po_id = len(PurchaseOrder.objects.all()) + 1
				b_isbn = Book.objects.get(b_isbn=book.b_isbn)
				po_date = time.strftime("%Y-%m-%d", time.localtime())
				po_amount = order_quantity[book.b_isbn]
				po_price = Book.objects.get(b_isbn=book.b_isbn).b_price * 0.6
				po_status = 0
				PurchaseOrder.objects.create(po_id=po_id,b_isbn=b_isbn,po_date=po_date,po_amount=po_amount,po_price=po_price,po_status=po_status)
	return render_to_response('staff/purchase/strategy.html', locals())

# 财务部
# 库存帐显示
def staff_finance_stock(request):
	book = {}
	stock_list =StockList.objects.all().order_by('sl_id')
	for stock in stock_list:
		isbn = stock.b_isbn
		b_name = Book.objects.get(b_isbn=isbn).b_name
		book[isbn] = b_name	
	return render_to_response('staff/finance/stock.html', locals())

# 收支表显示及添加
def staff_finance_profit(request):
	profit = FinancialReport.objects.order_by('f_id')
	num = len(profit)
	# profit为空表，进行初始化
	if not profit:
		f_date = InList.objects.order_by('i_date')[0].i_date
		# 计算该日总支出
		in_list = InList.objects.filter(i_date=f_date)
		f_cost = 0
		for foo in in_list:
			f_cost = f_cost + foo.po_amount * foo.po_price
		# 计算该日总收入
		out_list = OutList.objects.filter(o_date=f_date)
		f_revenue = 0
		for foo in out_list:
			f_revenue = f_revenue + foo.co_amount * foo.b_price
		f_profit = f_revenue - f_cost
		# 添加收支记录
		f_id = len(FinancialReport.objects.all()) + 1
		FinancialReport.objects.create(f_id=f_id, f_date=f_date, f_revenue=f_revenue, f_cost=f_cost, f_profit=f_profit)
	# 如果FinancialReport表不空，则试图添加记录
	if profit:
		start_date = profit[num-1].f_date + datetime.timedelta(days=1)
		end_date = datetime.date.today() - datetime.timedelta(days=1)
		scale = (end_date-start_date).days + 1
		f_date = start_date
		for i in range(scale):
			# 计算该日总支出
			in_list = InList.objects.filter(i_date=f_date)
			f_cost = 0
			for foo in in_list:
				f_cost = f_cost + foo.po_amount * foo.po_price
			# 计算该日总收入
			out_list = OutList.objects.filter(o_date=f_date)
			f_revenue = 0
			for foo in out_list:
				f_revenue = f_revenue + foo.co_amount * foo.b_price
			f_profit = f_revenue - f_cost
			# 添加收支记录
			f_id = len(FinancialReport.objects.all()) + 1
			FinancialReport.objects.create(f_id=f_id, f_date=f_date, f_revenue=f_revenue, f_cost=f_cost, f_profit=f_profit)
			# f_date转到下一日
			f_date = f_date + datetime.timedelta(days=1)

	
	profit_list = FinancialReport.objects.order_by('-f_id')
	# 计算总利润
	total_cost = 0
	total_revenue = 0
	total_profit = 0
	for profit in profit_list:
		total_cost += profit.f_cost
		total_revenue += profit.f_revenue
		total_profit += profit.f_profit
	return render_to_response('staff/finance/profit.html', locals())

# 前10销量， 后10销量
def staff_finance_analysis_quantity(request):
	type = u'销量'
	book = {}
	stock = StockList.objects.order_by('-sl_out_all')
	top = stock[0:10]
	stock = StockList.objects.order_by('sl_out_all')
	bottom = stock[0:10]
	for foo in top:
		book[foo.b_isbn] = Book.objects.get(b_isbn=foo.b_isbn).b_name
	for foo in bottom:
		book[foo.b_isbn] = Book.objects.get(b_isbn=foo.b_isbn).b_name	
	return render_to_response('staff/finance/analysis.html', locals())
# 前10销额， 后10销额
def staff_finance_analysis_revenue(request):
	type = u'销额'
	book = {}
	revenue = {}
	top = []
	bottom = []
	stock = StockList.objects.all()
	# 计算每本书的总收入
	for foo in stock:
		revenue[foo.b_isbn] = foo.sl_out_all * Book.objects.get(b_isbn=foo.b_isbn).b_price
	# 计算前10/后10收入，键值为该书的ISBN
	top_revenue = sorted(revenue.iteritems(), key=lambda d:d[1], reverse = True)[0:10]
	bottom_revenue = sorted(revenue.iteritems(), key=lambda d:d[1])[0:10]
	# 得到前10/后10收入stock记录
	for k,v in top_revenue:
		top.append(StockList.objects.get(b_isbn=k))
	for k,v in bottom_revenue:
		bottom.append(StockList.objects.get(b_isbn=k))
	for foo in top:
		book[foo.b_isbn] = Book.objects.get(b_isbn=foo.b_isbn).b_name
	for foo in bottom:
		book[foo.b_isbn] = Book.objects.get(b_isbn=foo.b_isbn).b_name
	return render_to_response('staff/finance/analysis.html', locals())


# 测试
#
def test(request):
	return render_to_response('test.html', locals())