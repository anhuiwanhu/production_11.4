create table OA_SYSTEM_USERFINGERSET(
  userid number(20),
  userAccount varchar2(100),
  FORBIDMODULE varchar2(200)   
);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.01_SP_20160223','11.4.0.01',sysdate);
commit;





delete from OA_CUSTMENU_CURMOBILE;
commit;
insert into OA_CUSTMENU_CURMOBILE(mobileId,mobileMenuCode,mobileMenuName,mobileMenuDisplayName,mobileMenuOrder,
mobileMenuScope,mobileMenuScopeIds,mobileMenuIsUse,domainId,createdEmp,createdOrg,imgName,isSystem) 
values(hibernate_sequence.nextval,'workflow','流程','流程','0','','','1','0','','0','desk_flow.png','1');
commit;
insert into OA_CUSTMENU_CURMOBILE(mobileId,mobileMenuCode,mobileMenuName,mobileMenuDisplayName,mobileMenuOrder,
mobileMenuScope,mobileMenuScopeIds,mobileMenuIsUse,domainId,createdEmp,createdOrg,imgName,isSystem) 
values(hibernate_sequence.nextval,'innermail','邮件','邮件','0','','','1','0','','0','desk_mail.png','1');
commit;
insert into OA_CUSTMENU_CURMOBILE(mobileId,mobileMenuCode,mobileMenuName,mobileMenuDisplayName,
mobileMenuOrder,mobileMenuScope,mobileMenuScopeIds,mobileMenuIsUse,domainId,createdEmp,
createdOrg,imgName,isSystem) values(hibernate_sequence.nextval,'information','信息','信息','0','','','1','0','','0','desk_information.png','1');
commit;
insert into OA_CUSTMENU_CURMOBILE(mobileId,mobileMenuCode,mobileMenuName,mobileMenuDisplayName,mobileMenuOrder,
mobileMenuScope,mobileMenuScopeIds,mobileMenuIsUse,domainId,createdEmp,createdOrg,imgName,isSystem) 
values(hibernate_sequence.nextval,'documentmanager','公文','公文','0','','','1','0','','0','desk_gov.png','1');
commit;
insert into OA_CUSTMENU_CURMOBILE(mobileId,mobileMenuCode,mobileMenuName,mobileMenuDisplayName,mobileMenuOrder,
mobileMenuScope,mobileMenuScopeIds,mobileMenuIsUse,domainId,createdEmp,createdOrg,imgName,isSystem) 
values(hibernate_sequence.nextval,'weibo','微博','微博','0','','','1','0','','0','desk_microblog.png','1');
commit;
insert into OA_CUSTMENU_CURMOBILE(mobileId,mobileMenuCode,mobileMenuName,mobileMenuDisplayName,mobileMenuOrder,
mobileMenuScope,mobileMenuScopeIds,mobileMenuIsUse,domainId,createdEmp,createdOrg,imgName,isSystem) 
values(hibernate_sequence.nextval,'forum','论坛','论坛','0','','','1','0','','0','desk_forum.png','1');
commit;
insert into OA_CUSTMENU_CURMOBILE(mobileId,mobileMenuCode,mobileMenuName,mobileMenuDisplayName,mobileMenuOrder,
mobileMenuScope,mobileMenuScopeIds,mobileMenuIsUse,domainId,createdEmp,createdOrg,imgName,isSystem) 
values(hibernate_sequence.nextval,'workmanager_calendar','日程','日程','0','','','1','0','','0','desk_schedule.png','1');
commit;
insert into OA_CUSTMENU_CURMOBILE(mobileId,mobileMenuCode,mobileMenuName,mobileMenuDisplayName,mobileMenuOrder,
mobileMenuScope,mobileMenuScopeIds,mobileMenuIsUse,domainId,createdEmp,createdOrg,imgName,isSystem) 
values(hibernate_sequence.nextval,'workmanager_workreport','汇报','汇报','0','','','1','0','','0','desk_report.png','1');
commit;
insert into OA_CUSTMENU_CURMOBILE(mobileId,mobileMenuCode,mobileMenuName,mobileMenuDisplayName,mobileMenuOrder,
mobileMenuScope,mobileMenuScopeIds,mobileMenuIsUse,domainId,createdEmp,createdOrg,imgName,isSystem) 
values(hibernate_sequence.nextval,'workmanager_linkman_inner','内部联系人','联系人','0','','','1','0','','0','desk_person.png','1');
commit;
insert into OA_CUSTMENU_CURMOBILE(mobileId,mobileMenuCode,mobileMenuName,mobileMenuDisplayName,mobileMenuOrder,
mobileMenuScope,mobileMenuScopeIds,mobileMenuIsUse,domainId,createdEmp,createdOrg,imgName,isSystem) 
values(hibernate_sequence.nextval,'workmanager_worklog','日志','日志','0','','','1','0','','0','desk_log.png','1');
commit;
create table OA_EVO_INFO (
id NUMBER(10) primary key not null,
imgDefaultName varchar2(1000),
imgUploadShowName varchar2(1000),
imgUploadSaveName varchar2(1000),
domainId NUMBER(10),
createdEmp NUMBER(10),
createdOrg NUMBER(10),
uploadType varchar2(100)
);
commit;

insert into OA_EVO_INFO values(hibernate_sequence.nextval,'logo.png','logo.png','logo.png',0,0,0,'480*845');
commit;
insert into OA_EVO_INFO values(hibernate_sequence.nextval,'logo.png','logo.png','logo.png',0,0,0,'720*1280');
commit;
insert into OA_EVO_INFO values(hibernate_sequence.nextval,'logo.png','logo.png','logo.png',0,0,0,'750*1334');
commit;
insert into OA_EVO_INFO values(hibernate_sequence.nextval,'logo.png','logo.png','logo.png',0,0,0,'1080*1920');
commit;
insert into OA_EVO_INFO values(hibernate_sequence.nextval,'logo.png','logo.png','logo.png',0,0,0,'1242*2208');
commit;
insert into oa_allattach (FILENAME,FILESIZE,SUB_FOLDER)values('201610801920.png',11264,'201603');
commit;
insert into oa_allattach (FILENAME,FILESIZE,SUB_FOLDER)values('20167201280.png',7782.9,'201603');
commit;
insert into oa_allattach (FILENAME,FILESIZE,SUB_FOLDER)values('2016480854.png',5734.9,'201603');
commit;
insert into oa_allattach (FILENAME,FILESIZE,SUB_FOLDER)values('20167501334.png',8017.92,'201603');
commit;
insert into oa_allattach (FILENAME,FILESIZE,SUB_FOLDER)values('201612422208.png',13414.8,'201603');
commit;
update org_employee set ischangepwd=0 where useraccounts in('sys','admin','security');
commit;
alter table ORG_DOMAIN add oa_vkey varchar2(200) ;
commit;
comment on column ORG_DOMAIN.oa_vkey
  is 'webservice密码';
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.02_SP_20160301','11.4.0.02',sysdate);
commit;





create table EVO_WORK_ATTENDANCE
(
  id             NUMBER(20) primary key  not null,
  domain         VARCHAR2(20),
  empid          VARCHAR2(20),
  empname        VARCHAR2(50),
  createorgid    VARCHAR2(20),
  sign_date      VARCHAR2(20),
  map_position   VARCHAR2(200),
  sign_status    VARCHAR2(1)
);
commit;

comment on column EVO_WORK_ATTENDANCE.domain
  is '域ID';
commit;
comment on column EVO_WORK_ATTENDANCE.empid
  is '用户ID';
commit;
comment on column EVO_WORK_ATTENDANCE.empname
  is '用户名';
commit;
comment on column EVO_WORK_ATTENDANCE.createorgid
  is '组织ID';
commit;
comment on column EVO_WORK_ATTENDANCE.sign_date
  is '签到日期';
commit;
comment on column EVO_WORK_ATTENDANCE.map_position
  is '定位地址';
commit;
comment on column EVO_WORK_ATTENDANCE.sign_status
  is '签到状态';
commit;

alter table EZ_FLOW_HI_PROCINST modify WHIR_DEALING_USERS varchar2(1000);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.03_SP_20160314','11.4.0.03',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.04_SP_20160322','11.4.0.04',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.05_SP_20160328','11.4.0.05',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.06_SP_20160405','11.4.0.06',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.07_SP_20160408','11.4.0.07',sysdate);
commit;