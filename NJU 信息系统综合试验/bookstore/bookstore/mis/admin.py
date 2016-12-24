from django.contrib import admin
from bookstore.mis.models import *

class BookAdmin(admin.ModelAdmin):
	list_display = ('b_isbn', 'b_name', 'b_author', 'b_publisher', 'b_date', 'b_price',)
	search_fields = ('b_isbn',)
	ordering = ('b_date', 'b_price', 'b_name',)
class CustomerAdmin(admin.ModelAdmin):
	list_display = ('c_id', 'c_name', 'c_email', 'c_sex', 'c_address', 'c_expense',)
	search_fields = ('c_id', 'c_name',)
	ordering = ('c_id', 'c_name', 'c_expense',)
class SupplierAdmin(admin.ModelAdmin):
	list_display = ('s_id', 's_name', 's_score',)
	search_fields = ('s_id', 's_name',)
	ordering = ('s_score',)
class CustomerOrderAdmin(admin.ModelAdmin):
	list_display = ('co_id', 'c', 'b_isbn', 'co_date', 'co_amount', 'b_price', 'co_status',)
	search_fields = ('co_id', 'c', 'b_isbn',)
	ordering = ('-co_date',)
class PurchaseOrderAdmin(admin.ModelAdmin):
	list_display = ('po_id', 's', 'b_isbn', 'co', 'po_date', 'po_amount', 'po_price', 'po_status',)
	search_fields = ('po_id', 's', 'b_isbn', 'co',)
	ordering = ('-po_date',)
class InListAdmin(admin.ModelAdmin):
	list_display = ('i_id', 'po', 'i_date', 'b_isbn', 'po_amount', 'po_price',)
	search_fields = ('i_id', 'po', 'b_isbn',)
	ordering = ('-i_date',)
class OutListAdmin(admin.ModelAdmin):
	list_display = ('o_id', 'co', 'o_date', 'b_isbn', 'co_amount', 'b_price',)
	search_fields = ('o_id', 'co', 'b_isbn',)
	ordering = ('-o_date',)
class FinancialReportAdmin(admin.ModelAdmin):
	list_display = ('f_id', 'f_date', 'f_revenue', 'f_cost', 'f_profit',)
	search_fields = ('f_id', 'f_date',)
	ordering = ('-f_date', 'f_profit',)
class StockListAdmin(admin.ModelAdmin):
	list_display = ('sl_id', 'b_isbn', 'sl_in_all', 'sl_out_all', 'sl_stock',)
	search_fields = ('sl_id', 'b_isbn',)
	ordering = ('sl_stock',)
	
# Register your models here.
admin.site.register(Book, BookAdmin)
admin.site.register(Customer, CustomerAdmin)
admin.site.register(Supplier, SupplierAdmin)
admin.site.register(CustomerOrder, CustomerOrderAdmin)
admin.site.register(PurchaseOrder, PurchaseOrderAdmin)
admin.site.register(InList, InListAdmin)
admin.site.register(OutList, OutListAdmin)
admin.site.register(FinancialReport, FinancialReportAdmin)
admin.site.register(StockList, StockListAdmin)

