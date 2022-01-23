--1.we want customers who havent made purchase in 150days.
--2.lets start with one customer
--3.we will use the order_item 

--customers who have purchased data
--call this table A 
--then subtract the numbers from our big table thats the whole usage
SELECT  DISTINCT C.ACC_NBR as ACC_NBR/*,A.ACCT_ID,B.SALE_LIST_PRICE/100
,B.OFFER_NAME,to_char(A.STATE_DATE,'yyyy-mm-dd hh24:mi:ss'),G.CUST_TYPE_NAME details*/
FROM RE_CC_INST A, OFFER B ,SUBS C,OFFER_CATG_MEM D,CUST H,CUST_TYPE G
WHERE A.OFFER_ID=B.OFFER_ID
AND C.SUBS_ID=A.SUBS_ID
AND C.CUST_ID=H.CUST_ID
AND H.CUST_TYPE=G.CUST_TYPE
AND B.OFFER_ID NOT IN('4108','4109')
AND b.offer_id=d.offer_id
and d.offer_catg_id in (204,1808,212,2408,2508,3208,1308,3809,3908,4110,4208,4408)
and b.offer_type=4
and lower (b.offer_name) not like '%hybrid business%'
and lower (b.offer_name) not like '%4g shared unlimited%'
and lower (b.offer_name) not like '%hbb%'
AND  EVENT_INST_ID IN (
SELECT EVENT_INST_ID FROM RE_SUBS_ORDER_INST WHERE SUB_ORDER_ID IS NOT NULL AND ORDER_ITEM_ID  IN (
select ORDER_ITEM_ID from ORDER_ITEM where TRUNC(state_date)between TRUNC(sysdate-150) and TRUNC(sysdate-1) and order_state IN ('C','E','G','P','I') AND SUBS_EVENT_ID='189'
)
)











SELECT A.* from 
(select  a.acc_nbr, a.cust_id, b.phone_number,offer_name from (select a.subs_id, a.acc_nbr, cust_id from
(select max(subs_id) subs_id, acc_nbr from subs
having count(*)>=1
group by acc_nbr) a,(select * from subs) b
where a.subs_id=b.subs_id) a, cust b, prod c, offer d
where subs_id=prod_id
and prod_state IN ('G','A')
and c.offer_id='526'
and a.cust_id=b.cust_id
and SUBS_PLAN_ID=d.offer_id
and a.acc_nbr in (
--and offer_name ='Latest MiFi Pack'






---TOTAL BASE--
--PREPAID BASE--
/*select subs_id, to_char(STATE_DATE, 'YYYYMMDD')state_date from order_item WHERE subs_event_id =104  and to_char(STATE_DATE, 'YYYYMMDD') BETWEEN  '20200201' AND '20200229'
and subs_id in (*/
(select DISTINCT a.acc_nbr /*, a.cust_id,*//*, b.phone_number,*/ /*offer_name*/ from (select a.subs_id, a.acc_nbr, cust_id from
(select max(subs_id) subs_id, acc_nbr from subs
having count(*)>=1
group by acc_nbr) a,(select * from subs) b
where a.subs_id=b.subs_id) a, cust b, prod c, offer d
where subs_id=prod_id
and prod_state IN ('G','A')
and c.offer_id='526'
and a.cust_id=b.cust_id
and SUBS_PLAN_ID=d.offer_id)
--and offer_name ='Latest MiFi Pack')
MINUS

--customers who have purchased data
--call this table A 
--then subtract the numbers from our big table thats the whole usage
(SELECT  DISTINCT C.ACC_NBR as ACC_NBR/*,A.ACCT_ID,B.SALE_LIST_PRICE/100
,B.OFFER_NAME,to_char(A.STATE_DATE,'yyyy-mm-dd hh24:mi:ss'),G.CUST_TYPE_NAME details*/
FROM RE_CC_INST A, OFFER B ,SUBS C,OFFER_CATG_MEM D,CUST H,CUST_TYPE G
WHERE A.OFFER_ID=B.OFFER_ID
AND C.SUBS_ID=A.SUBS_ID
AND C.CUST_ID=H.CUST_ID
AND H.CUST_TYPE=G.CUST_TYPE
AND B.OFFER_ID NOT IN('4108','4109')
AND b.offer_id=d.offer_id
and d.offer_catg_id in (204,1808,212,2408,2508,3208,1308,3809,3908,4110,4208,4408)
and b.offer_type=4
and lower (b.offer_name) not like '%hybrid business%'
and lower (b.offer_name) not like '%4g shared unlimited%'
and lower (b.offer_name) not like '%hbb%'
AND  EVENT_INST_ID IN (
SELECT EVENT_INST_ID FROM RE_SUBS_ORDER_INST WHERE SUB_ORDER_ID IS NOT NULL AND ORDER_ITEM_ID  IN (
select ORDER_ITEM_ID from ORDER_ITEM where TRUNC(state_date)between TRUNC(sysdate-150) and TRUNC(sysdate-1) and order_state IN ('C','E','G','P','I') AND SUBS_EVENT_ID='189'
)
)
)
)
) A
WHERE A.ACC_NBR NOT IN (select  acc_nbr from
(select distinct a.acc_nbr, imsi, iccid, offer_name, cust_id from acc_nbr a, sim_card b, sim_nbr c, subs d, prod e, subs_upp_inst f, offer g where ACC_NBR_STATE='C'
and a.acc_nbr_id=c.acc_nbr_id
and c.sim_card_id=b.sim_card_id
and a.acc_nbr=d.acc_nbr
and SIM_STATE='C'
and c.state='A'
and d.subs_id=e.prod_id
and PROD_STATE in ('I','A')
and d.subs_id=f.subs_id
and lower(offer_name) like '%staff%'
and f.STATE='A'
and (trunc(f.exp_date) is null or trunc(f.exp_date) > trunc(sysdate))
and f.PRICE_PLAN_ID=g.offer_id) a, cust b
where a.cust_id=b.cust_id
order by 1)
;

