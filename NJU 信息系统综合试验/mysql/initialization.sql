/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2014/2/28 12:53:32                           */
/*==============================================================*/


drop table if exists Book;

drop table if exists Customer;

drop table if exists CustomerOrder;

drop table if exists FinancialReport;

drop table if exists InList;

drop table if exists OutList;

drop table if exists PurchaseOrder;

drop table if exists StockList;

drop table if exists Supplier;

/*==============================================================*/
/* Table: Book                                                  */
/*==============================================================*/
create table Book
(
   b_isbn               varchar(100) not null,
   b_name               varchar(100) not null,
   b_author             varchar(100) not null,
   b_publisher          varchar(100) not null,
   b_date               date not null,
   b_price              float not null,
   primary key (b_isbn)
);

/*==============================================================*/
/* Table: Customer                                              */
/*==============================================================*/
create table Customer
(
   c_id                 varchar(100) not null,
   c_name               varchar(100) not null,
   c_email              varchar(100) not null,
   c_password           varchar(100) not null,
   c_sex                varchar(100) not null,
   c_address            varchar(100) not null,
   c_money              int not null,
   c_expense            int,
   primary key (c_id)
);

/*==============================================================*/
/* Table: CustomerOrder                                         */
/*==============================================================*/
create table CustomerOrder
(
   co_id                varchar(100) not null,
   c_id                 varchar(100),
   b_isbn               varchar(100),
   o_id                 varchar(100),
   po_id                varchar(100),
   co_date              date not null,
   co_amount            int not null,
   b_price              float not null,
   co_status            smallint not null,
   primary key (co_id)
);

/*==============================================================*/
/* Table: FinancialReport                                       */
/*==============================================================*/
create table FinancialReport
(
   f_id                 varchar(100) not null,
   sl_id                varchar(100),
   f_date               date not null,
   f_revenue            int not null,
   f_cost               int not null,
   f_profit             int not null,
   primary key (f_id)
);

/*==============================================================*/
/* Table: InList                                                */
/*==============================================================*/
create table InList
(
   i_id                 varchar(100) not null,
   f_id                 varchar(100),
   sl_id                varchar(100),
   po_id                varchar(100),
   i_date               date not null,
   s_id                 varchar(100) not null,
   co_id                varchar(100),
   b_isbn               varchar(100) not null,
   po_amount            int not null,
   po_price             int not null,
   primary key (i_id)
);

/*==============================================================*/
/* Table: OutList                                               */
/*==============================================================*/
create table OutList
(
   o_id                 varchar(100) not null,
   f_id                 varchar(100),
   co_id                varchar(100),
   sl_id                varchar(100),
   o_date               date not null,
   c_id                 varchar(100) not null,
   b_isbn               varchar(100) not null,
   co_amount            int not null,
   b_price              int not null,
   primary key (o_id)
);

/*==============================================================*/
/* Table: PurchaseOrder                                         */
/*==============================================================*/
create table PurchaseOrder
(
   po_id                varchar(100) not null,
   sl_id                varchar(100),
   s_id                 varchar(100),
   b_isbn               varchar(100),
   i_id                 varchar(100),
   co_id                varchar(100),
   po_date              date not null,
   po_amount            int not null,
   po_price             float not null,
   po_status            smallint not null,
   primary key (po_id)
);

/*==============================================================*/
/* Table: StockList                                             */
/*==============================================================*/
create table StockList
(
   sl_id                varchar(100) not null,
   po_id                varchar(100),
   b_isbn               varchar(100) not null,
   sl_in_all            int not null,
   sl_out_all           int not null,
   sl_stock             int not null,
   primary key (sl_id)
);

/*==============================================================*/
/* Table: Supplier                                              */
/*==============================================================*/
create table Supplier
(
   s_id                 varchar(100) not null,
   s_name               varchar(100) not null,
   s_score              int not null,
   primary key (s_id)
);

alter table CustomerOrder add constraint FK_CustomerBookQuery foreign key (b_isbn)
      references Book (b_isbn) on delete restrict on update restrict;

alter table CustomerOrder add constraint FK_CustomerBuy foreign key (c_id)
      references Customer (c_id) on delete restrict on update restrict;

alter table CustomerOrder add constraint FK_Sale foreign key (o_id)
      references OutList (o_id) on delete restrict on update restrict;

alter table CustomerOrder add constraint FK_StockOut foreign key (po_id)
      references PurchaseOrder (po_id) on delete restrict on update restrict;

alter table FinancialReport add constraint FK_Analyze foreign key (sl_id)
      references StockList (sl_id) on delete restrict on update restrict;

alter table InList add constraint FK_Buy2 foreign key (po_id)
      references PurchaseOrder (po_id) on delete restrict on update restrict;

alter table InList add constraint FK_Cost foreign key (f_id)
      references FinancialReport (f_id) on delete restrict on update restrict;

alter table InList add constraint FK_InStock foreign key (sl_id)
      references StockList (sl_id) on delete restrict on update restrict;

alter table OutList add constraint FK_OutStock foreign key (sl_id)
      references StockList (sl_id) on delete restrict on update restrict;

alter table OutList add constraint FK_Revenue foreign key (f_id)
      references FinancialReport (f_id) on delete restrict on update restrict;

alter table OutList add constraint FK_Sale2 foreign key (co_id)
      references CustomerOrder (co_id) on delete restrict on update restrict;

alter table PurchaseOrder add constraint FK_Buy foreign key (i_id)
      references InList (i_id) on delete restrict on update restrict;

alter table PurchaseOrder add constraint FK_PurchaseBookQuery foreign key (b_isbn)
      references Book (b_isbn) on delete restrict on update restrict;

alter table PurchaseOrder add constraint FK_PurchaseQuery foreign key (sl_id)
      references StockList (sl_id) on delete restrict on update restrict;

alter table PurchaseOrder add constraint FK_Selection foreign key (s_id)
      references Supplier (s_id) on delete restrict on update restrict;

alter table PurchaseOrder add constraint FK_StockOut2 foreign key (co_id)
      references CustomerOrder (co_id) on delete restrict on update restrict;

alter table StockList add constraint FK_PurchaseQuery2 foreign key (po_id)
      references PurchaseOrder (po_id) on delete restrict on update restrict;

