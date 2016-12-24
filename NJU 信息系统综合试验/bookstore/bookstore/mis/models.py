# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Remove `managed = False` lines for those models you wish to give write DB access
# Feel free to rename the models, but don't rename db_table values or field names.
#
# Also note: You'll have to insert the output of 'django-admin.py sqlcustom [appname]'
# into your database.
from __future__ import unicode_literals

from django.db import models

class Book(models.Model):
    b_isbn = models.CharField(primary_key=True, max_length=100)
    b_name = models.CharField(max_length=100)
    b_author = models.CharField(max_length=100)
    b_publisher = models.CharField(max_length=100)
    b_date = models.DateField()
    b_price = models.FloatField()
    class Meta:
        db_table = 'book'

class Customer(models.Model):
    c_id = models.CharField(primary_key=True, max_length=100)
    c_name = models.CharField(max_length=100)
    c_email = models.CharField(max_length=100)
    c_password = models.CharField(max_length=100)
    c_sex = models.CharField(max_length=100)
    c_address = models.CharField(max_length=100)
    c_expense = models.IntegerField(blank=True, null=True)
    class Meta:
        db_table = 'customer'


class Supplier(models.Model):
    s_id = models.CharField(primary_key=True, max_length=100)
    s_name = models.CharField(max_length=100)
    s_score = models.IntegerField()
    class Meta:
        db_table = 'supplier'

class CustomerOrder(models.Model):
    co_id = models.CharField(primary_key=True, max_length=100)
    c = models.ForeignKey('Customer', blank=True, null=True)
    b_isbn = models.ForeignKey('Book', db_column='b_isbn', blank=True, null=True)
    o = models.ForeignKey('OutList', blank=True, null=True)
    po = models.ForeignKey('CustomerOrder', blank=True, null=True)
    co_date = models.DateField()
    co_amount = models.IntegerField()
    b_price = models.FloatField()
    co_status = models.IntegerField()
    class Meta:
        db_table = 'customerorder'

class PurchaseOrder(models.Model):
    po_id = models.CharField(primary_key=True, max_length=100)
    sl = models.ForeignKey('StockList', blank=True, null=True)
    s = models.ForeignKey('Supplier', blank=True, null=True)
    b_isbn = models.ForeignKey('Book', db_column='b_isbn', blank=True, null=True)
    i = models.ForeignKey('InList', blank=True, null=True)
    co = models.ForeignKey('CustomerOrder', blank=True, null=True)
    po_date = models.DateField()
    po_amount = models.IntegerField()
    po_price = models.FloatField()
    po_status = models.IntegerField()
    class Meta:
        db_table = 'purchaseorder'


class InList(models.Model):
    i_id = models.CharField(primary_key=True, max_length=100)
    f = models.ForeignKey('FinancialReport', blank=True, null=True)
    sl = models.ForeignKey('StockList', blank=True, null=True)
    po = models.ForeignKey('CustomerOrder', blank=True, null=True)
    i_date = models.DateField()
    s_id = models.CharField(max_length=100)
    co_id = models.CharField(max_length=100, blank=True)
    b_isbn = models.CharField(max_length=100)
    po_amount = models.IntegerField()
    po_price = models.IntegerField()
    class Meta:
        db_table = 'inlist'

class OutList(models.Model):
    o_id = models.CharField(primary_key=True, max_length=100)
    f = models.ForeignKey('FinancialReport', blank=True, null=True)
    co = models.ForeignKey('CustomerOrder', blank=True, null=True)
    sl = models.ForeignKey('StockList', blank=True, null=True)
    o_date = models.DateField()
    c_id = models.CharField(max_length=100)
    b_isbn = models.CharField(max_length=100)
    co_amount = models.IntegerField()
    b_price = models.IntegerField()
    class Meta:
        db_table = 'outlist'

class FinancialReport(models.Model):
    f_id = models.CharField(primary_key=True, max_length=100)
    sl = models.ForeignKey('StockList', blank=True, null=True)
    f_date = models.DateField()
    f_revenue = models.IntegerField()
    f_cost = models.IntegerField()
    f_profit = models.IntegerField()
    class Meta:
        db_table = 'financialreport'

class StockList(models.Model):
    sl_id = models.CharField(primary_key=True, max_length=100)
    po = models.ForeignKey('CustomerOrder', blank=True, null=True)
    b_isbn = models.CharField(max_length=100)
    sl_in_all = models.IntegerField()
    sl_out_all = models.IntegerField()
    sl_stock = models.IntegerField()
    class Meta:
        db_table = 'stocklist'

	


