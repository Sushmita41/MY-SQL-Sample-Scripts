##Phone verification status analysis

## Grabbing table t info

select
t.user_id,
t.user_name, 
t.email,
t.customer_id,
t.loan_header_id,
t.base_loan_id,
t.lead_sequence_id,
t.isExternal,
t.is_active,
t.status,
t.organization_id,
t.organization_name,
t.email_domain,
t.tierkey,
t.country,
t.region as state_web,
ai.state,
ai.phone_number,
ai.is_mobile,

min(t.`created_datetime`) as apply_start_timestamp,
max(t.`created_datetime`) as apply_end_timestamp,

if(sum(if(t.page='create_password_submit',1,0))>0,1,0) as created_password,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'create_password_submit' limit 1) as created_password_timestamp,

if(sum(if(t.page='account_terms',1,0))>0,1,0) as visit_account_terms,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'account_terms' limit 1) as visit_account_terms_timestamp,

if(sum(if(t.page='account_terms_submit',1,0))>0,1,0) as submit_account_terms,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'account_terms_submit' limit 1) as submit_account_terms_timestamp,

if(sum(if(t.page='personal_info',1,0))>0,1,0) as visit_personal_info, 
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'personal_info' limit 1) as visit_personal_info_timestamp,

if(sum(if(t.page='personal_info_submit',1,0))>0,1,0) as submit_personal_info, 
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'personal_info_submit' limit 1) as submit_personal_info_timestamp,

if(sum(if(t.page='contact-information',1,0))>0,1,0) as visit_contact_info,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'contact-information' limit 1) as visit_contact_info_timestamp,

if(sum(if(t.page='contact-information-submit',1,0))>0,1,0) as submit_contact_info,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'contact-information-submit' limit 1) as submit_contact_info_timestamp,

if(sum(if(t.page='verify-your-phone',1,0))>0,1,0) as visit_verify_ph,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'verify-your-phone' limit 1) as visit_verify_ph_timestamp,

if(sum(if(t.page='verify-your-phone-submit',1,0))>0,1,0) as submit_verify_ph,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'verify-your-phone-submit' limit 1) as submit_verify_ph_timestamp,

if(sum(if(t.page='address_info',1,0))>0,1,0) as visit_address_info,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'address_info' limit 1) as visit_address_info_timestamp,

if(sum(if(t.page='Address_info_submit',1,0))>0,1,0) as submit_address_info,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'Address_info_submit' limit 1) as submit_address_info_timestamp,
 
if(sum(if(t.page='payment_schedule',1,0))>0,1,0) as visit_payment_schedule,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'payment_schedule' limit 1) as visit_payment_schedule_timestamp,

if(sum(if(t.page='payment_schedule_submit',1,0))>0,1,0) as submit_payment_schedule,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'payment_schedule_submit' limit 1) as submit_payment_schedule_timestamp,

if(sum(if(t.page='reject',1,0))>0 and sum(if(t.page='pre_approved_submit',1,0))=0,1,0) as Application_Reject,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'reject' limit 1) as application_reject_timestamp,

if(sum(if(t.page='pre_approved',1,0))>0,1,0) as application_pre_approved,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'pre_approved' limit 1) as application_pre_approved_timestamp,

if(sum(if(t.page='pre_approved_submit',1,0))>0,1,0) as submit_application_pre_approved,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'pre_approved_submit' limit 1) as submit_application_pre_approved_timestamp,

if(sum(if(t.page='employment_info',1,0))>0,1,0) as visit_employment_info,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'employment_info' limit 1) as visit_employment_info_timestamp,

if(sum(if(t.page='employment_info_submit',1,0))>0,1,0) as submit_employment_info,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'employment_info_submit' limit 1) as submit_employment_info_timestamp,

if(sum(if(t.page='banking_info',1,0))>0,1,0) as visit_banking_info,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'banking_info' limit 1) as visit_banking_info_timestamp,

if(sum(if(t.page='banking_info_submit',1,0))>0,1,0) as submit_banking_info,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'banking_info_submit' limit 1) as visit_banking_info_submit_timestamp,

if(sum(if(t.page='user_account' ,1,0))>0,1,0) as Is_View_Dashboard, 
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'user_account' limit 1) as Is_View_Dashboard_timestamp,

if(sum(if(t.page='useraccount_click_sign_loan_doc' ,1,0))>0,1,0) as Is_Click_to_sign_loan_doc, 
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'useraccount_click_sign_loan_doc' limit 1) as Is_Click_to_sign_loan_doc_timestamp,

if(sum(if(t.page='loan_docs-TC',1,0))>0,1,0) as visit_loan_docTC,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'loan_docs-TC' limit 1) as visit_loan_docTC_timestamp,

if(sum(if(t.page='loan_docs_submit-ARB',1,0))>0,1,0) as completed_loan_doc, 
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'loan_docs_submit-ARB' limit 1) as completed_loan_doc_timestamp,

-- if(sum(if(t.page='user_dashboard_RAL_submit_LF2',1,0))>0 ,min(t.lead_sequence_id),max(t.lead_sequence_id)) as lead_sequence_id,
-- (select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'create_password_submit' limit 1) as created_password_timestamp,

if(sum(if(t.page='user_bankverification',1,0))>0,1,0) as Visit_BV,
(select max(m.created_datetime) from dwh.fct_web_tracking m where m.user_id = t.user_id and m.page = 'user_bankverification' limit 1) as Visit_BV_timestamp,


### adding fields from code sent status table

a.phone_number as code_sent_number,
a.first_code_sent_timestamp,
a.final_code_sent_timestamp,
a.NEW as count_code_NEW,
a.SENT as count_code_SENT,
a.EXPIRED as count_code_EXPIRED,
a.code_expired_timestamp_final,
a.VERIFIED as count_code_VERIFIED,
a.code_verified_timestamp,


ai.is_phone_verification_skipped,


### adding phone info change table

aa.customer_change_phone_info,
aa.customer_change_phone_info_timestamp



from dwh.fct_web_tracking t  

left join ### adding code sent status table

(SELECT 
pw.user_id,
pw.phone_number,
min(pw.`created_datetime`) as first_code_sent_timestamp,
max(pw.`created_datetime`) as final_code_sent_timestamp, 
sum(CASE WHEN pw.status = 'NEW' THEN 1 ELSE 0 END) AS NEW, 

sum(CASE WHEN pw.status = 'VERIFIED' THEN 1 ELSE 0 END) AS VERIFIED,
(select max(pww.verified_datetime) from webapi.user_one_time_password pww where pww.user_id = pw.user_id and pww.status = 'VERIFIED' limit 1) as code_verified_timestamp,

sum(CASE WHEN pw.status = 'SENT' THEN 1 ELSE 0 END) AS SENT,

sum(CASE WHEN pw.status = 'EXPIRED' THEN 1 ELSE 0 END) AS EXPIRED,
(select max(pww.expired_datetime) from webapi.user_one_time_password pww where pww.user_id = pw.user_id and pww.status = 'EXPIRED' limit 1) as code_expired_timestamp_final

FROM webapi.user_one_time_password pw
where id> 0 and pw.created_datetime>= 2022-12-31
group by  pw.user_id, pw.phone_number) a on a.user_id = t.user_id

left join webapi.user_application_info ai on ai.user_id= t.user_id 

left join ### adding customer info change table
(SELECT 
cid.customer_id,
if(Sum(if(cid.var_name in ('homephone', 'cellphone', 'altphone','alt_phone','empphone','otherphone') and cid.new_value IS NOT NULL,1,0))>0,1,0) as customer_change_phone_info,
(select max(m.change_date) from jaglms.lms_customer_info_delta m where m.customer_id = cid.customer_id and m.var_name in ('homephone', 'cellphone', 'altphone','alt_phone','empphone','otherphone') and cid.new_value IS NOT NULL limit 1) as customer_change_phone_info_timestamp
FROM jaglms.lms_customer_info_delta cid
where id> 0 and cid.change_date>= '2022-12-31 00:00:00' -- and customer_id =2990248
group by  cid.customer_id) aa
on aa.customer_id = t.customer_id

where t.user_name in 
            (select distinct t2.user_name
            from dwh.fct_web_tracking t2
            where t2.created_datetime>= '2022-12-31 00:00:00'  
            and t2.user_name not like '%moneykey.com' -- and t.user_id in (4052602,4051939,4052710, 4053956,4051529)
            group by t2.user_name, t2.page)
            
group by t.user_id 