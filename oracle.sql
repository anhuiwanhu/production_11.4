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





create table ls_oa_mail_tj as
select  a.emp_id,count(*) cnt
from OA_MAIL_USER a 
where a.notread = 1 and a.mailstatus in(0,1,3,5)
group by a.emp_id;
commit;

update oa_system_remind remind
set remind.newmail = (
select nvl(b.cnt,0)
from ls_oa_mail_tj b
where remind.userid = b.emp_id);
commit;

update oa_system_remind remind
set remind.newmail = 0
where remind.newmail is null;
commit;

drop table ls_oa_mail_tj;
commit;


CREATE OR REPLACE TRIGGER trigger_oa_mail_user
AFTER DELETE OR INSERT OR UPDATE ON oa_mail_user
for each row
BEGIN
IF INSERTING THEN
--INSERT触发
   IF :new.NOTREAD = 1 THEN
      IF :new.mailstatus = 1 and :new.mail_id is not null THEN
         update oa_system_remind t set t.newmail = t.newmail+1 where t.userid = :new.emp_id;
      END IF;
   END IF;
ELSIF UPDATING THEN
--UPDATE触发
   IF :new.mailstatus = 4 THEN
      IF :old.mailstatus != 4 and :old.mailstatus != 2 and :old.NOTREAD = 1 THEN
         update oa_system_remind t set t.newmail = t.newmail-1 where t.userid = :new.emp_id;
      END IF;
   ELSIF :new.mailstatus != 4 THEN
     IF :new.NOTREAD = 1 and :old.NOTREAD = 0 and :old.mailstatus != 2 THEN
        update oa_system_remind t set t.newmail = t.newmail+1 where t.userid = :new.emp_id;
     ELSIF :new.NOTREAD = 0 and :old.NOTREAD = 1 and :old.mailstatus != 2 THEN
        update oa_system_remind t set t.newmail = t.newmail-1 where t.userid = :new.emp_id;
     END IF;
     --非删除操作，且文件未读
     IF :new.NOTREAD = 1 and :old.NOTREAD = 1 THEN
       --移动到废件箱-1
       IF :old.mailstatus != 2 and :new.mailstatus = 2 THEN
         update oa_system_remind t set t.newmail = t.newmail-1 where t.userid = :new.emp_id;
       --移出废件箱+1
       ELSIF :new.mailstatus != 2 and :old.mailstatus = 2 THEN
         update oa_system_remind t set t.newmail = t.newmail+1 where t.userid = :new.emp_id;
       END IF;
     END IF;
     
   END IF;
ELSIF DELETING THEN
--DELETE触发
   IF :old.NOTREAD = 1 and :old.mailstatus != 4 and :old.mailstatus != 2 THEN
          update oa_system_remind t set t.newmail = t.newmail-1 where t.userid = :old.emp_id;
   END IF;
END IF;
END;
/

update OA_EVO_INFO set IMGUPLOADSHOWNAME = 'logo.png',IMGUPLOADSAVENAME='201610801920.png' where uploadType ='1080*1920';                       
commit;         
update OA_EVO_INFO set IMGUPLOADSHOWNAME = 'logo.png',IMGUPLOADSAVENAME='20167201280.png' where uploadType ='720*1280';                     
commit;         
update OA_EVO_INFO set IMGUPLOADSHOWNAME = 'logo.png',IMGUPLOADSAVENAME='2016480854.png' where uploadType = '480*845';                       
commit;          
update OA_EVO_INFO set IMGUPLOADSHOWNAME = 'logo.png',IMGUPLOADSAVENAME='20167501334.png' where uploadType ='750*1334';                     
commit;        
update OA_EVO_INFO set IMGUPLOADSHOWNAME = 'logo.png',IMGUPLOADSAVENAME='201612422208.png' where uploadType = '1242*2208';                       
commit; 
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.08_SP_20160418','11.4.0.08',sysdate);
commit;





alter table SYS_CORP_SET add relactionId varchar2(20) ;
comment on column SYS_CORP_SET.relactionId
  is '关联ID';
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.09_SP_20160423','11.4.0.09',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.10_SP_20160427','11.4.0.10',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.11_SP_20160429','11.4.0.11',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.12_SP_20160505','11.4.0.12',sysdate);
commit;





alter table SYS_CORP_SET add last_relactionId varchar2(20) ;
comment on column SYS_CORP_SET.last_relactionId  is '最近一次同步所使用的关联ID';
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.13_SP_20160510','11.4.0.13',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.14_SP_20160519','11.4.0.14',sysdate);
commit;