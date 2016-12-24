from django.conf.urls import patterns, include, url
from django.contrib import admin
admin.autodiscover()
from bookstore.views import *

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'bookstore.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

	# 基本页面
    url(r'^admin/', include(admin.site.urls)),  #django自带后台管理系统
	url(r'^$', (index)),
	url(r'^login/$', (login)),
	url(r'^logout/$', (logout)),
	url(r'^register/$', (register)),
	url(r'^staff/$', (staff)),
	url(r'^customer/$', (customer)),	
	url(r'^test/$', (test)),
	# 客户系统
		# 客户购书模块
	url(r'^customer/customer_purchase/$', (customer_purchase)),
	url(r'^customer/customer_purchase/\S+/$', (customer_purchase_search)),
		# 客户荐书模块
	url(r'^customer/customer_recommend/$', (customer_recommend)),
		# 客户基本信息修改模块
	url(r'^customer/customer_profile/$', (customer_profile)),
		# 客户图书订单查询模块
	url(r'^customer/order/$', (customer_order_unfinished)),
	url(r'^customer/order/finished/$', (customer_order_finished)),
	url(r'^customer/order/unfinished/$', (customer_order_unfinished)),
	# 管理系统-销售部
	url(r'^staff/sales/$', (staff_sales_order_stockout)),
		# 客户信息管理模块
	url(r'^staff/sales/customer_profile/$', (staff_sales_profile)),
	url(r'^staff/sales/customer_profile/(\d+)/$', (staff_sales_profile_order)),
		# 图书库存查询模块
	url(r'^staff/sales/stock_set/$', (staff_sales_stock)),
		# 客户订单处理模块
	url(r'^staff/sales/customer_order/$', (staff_sales_order)),
	url(r'^staff/sales/customer_order/out$', (staff_sales_order_out)),
	url(r'^staff/sales/customer_order/finished$', (staff_sales_order_finished)),
	url(r'^staff/sales/customer_order/stockin$', (staff_sales_order_stockin)),
	url(r'^staff/sales/customer_order/stockout$', (staff_sales_order_stockout)),
	url(r'^staff/sales/customer_order/purchase$', (staff_sales_order_purchase)),
	url(r'^staff/sales/customer_order/process$', (staff_sales_order_process)),	
	# 管理系统-采购部
	url(r'^staff/purchase/$', (staff_purchase_order_unfinished)),
		# 供应商管理模块
	url(r'^staff/purchase/supplier/$', (staff_purchase_supplier)),
		# 采购单处理模块
	url(r'^staff/purchase/purchase_order/$', (staff_purchase_order)),
	url(r'^staff/purchase/purchase_order/in/$', (staff_purchase_order_in)),
	url(r'^staff/purchase/purchase_order/finished/$', (staff_purchase_order_finished)),
	url(r'^staff/purchase/purchase_order/unfinished/$', (staff_purchase_order_unfinished)),
	url(r'^staff/purchase/purchase_order/process/$', (staff_purchase_order_process)),
		# 策略补货模块
	url(r'^staff/purchase/strategy/$', (staff_purchase_strategy)),
	url(r'^staff/purchase/strategy/process/$', (staff_purchase_strategy_process)),
	# 管理系统-财务部
	url(r'^staff/finance/$', (staff_finance_profit)),
		# 库存帐模块
	url(r'^staff/finance/stock_report/$', (staff_finance_stock)),
		# 收支表模块
	url(r'^staff/finance/profit_report/$', (staff_finance_profit)),
		# 分析统计模块
	url(r'^staff/finance/analysis_report/quantity/$', (staff_finance_analysis_quantity)),	
	url(r'^staff/finance/analysis_report/revenue/$', (staff_finance_analysis_revenue)),
)

from django.contrib.staticfiles.urls import staticfiles_urlpatterns
urlpatterns += staticfiles_urlpatterns()
