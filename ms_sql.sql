create table OA_SYSTEM_USERFINGERSET
(       userid numeric(20),
	userAccount varchar(100),
	FORBIDMODULE varchar(200) 	
);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.01_SP_20160223','11.4.0.01',getdate());
go





create table OA_EVO_INFO (
id int  identity(1,1)  not null  PRIMARY KEY ,
imgDefaultName varchar(1000),
imgUploadShowName varchar(1000),
imgUploadSaveName varchar(1000),
domainId int,
createdEmp int,
createdOrg int,
uploadType varchar(100)
);
go

/**Sqlserver数据库初始化SQL**/
insert into OA_EVO_INFO values('logo.png','logo.png','logo.png',0,0,0,'480*845');
go
insert into OA_EVO_INFO values('logo.png','logo.png','logo.png',0,0,0,'720*1280');
go
insert into OA_EVO_INFO values('logo.png','logo.png','logo.png',0,0,0,'750*1334');
go
insert into OA_EVO_INFO values('logo.png','logo.png','logo.png',0,0,0,'1080*1920');
go
insert into OA_EVO_INFO values('logo.png','logo.png','logo.png',0,0,0,'1242*2208');
go
insert into oa_allattach (FILENAME,FILESIZE,SUB_FOLDER)values('201610801920.png',11264,'201603');
go
insert into oa_allattach (FILENAME,FILESIZE,SUB_FOLDER)values('20167201280.png',7782.9,'201603');
go
insert into oa_allattach (FILENAME,FILESIZE,SUB_FOLDER)values('2016480854.png',5734.9,'201603');
go
insert into oa_allattach (FILENAME,FILESIZE,SUB_FOLDER)values('20167501334.png',8017.92,'201603');
go
insert into oa_allattach (FILENAME,FILESIZE,SUB_FOLDER)values('201612422208.png',13414.8,'201603');
go
ALTER TABLE OA_CUSTMENU DROP COLUMN  mobileId;
go
DROP TABLE [ezoffice].[OA_CUSTMENU_CURMOBILE]
GO
CREATE TABLE [ezoffice].[OA_CUSTMENU_CURMOBILE] (
[mobileId] NUMERIC(20) identity(1,1) not null PRIMARY KEY,
[mobileMenuCode] varchar(1000),
[mobileMenuName] varchar(2000),
[mobileMenuDisplayName] varchar(2000),
[mobileMenuOrder] int,
[mobileMenuScope] varchar(3000) ,
[mobileMenuScopeIds] varchar(3000) ,
[mobileMenuIsUse] varchar(200) ,
[domainId] int ,
[createdEmp] int ,
[createdOrg] int ,
[Img1showName] nvarchar(1000) ,
[Img2showName] nvarchar(1000) ,
[Img3showName] nvarchar(1000) ,
[Img4showName] nvarchar(1000) ,
[Img5showName] nvarchar(1000) ,
[Img6showName] nvarchar(1000) ,
[Img7showName] nvarchar(1000) ,
[Img8showName] nvarchar(1000) ,
[Img9showName] nvarchar(1000) ,
[Img10showName] nvarchar(1000) ,
[Img1saveName] nvarchar(1000) ,
[Img2saveName] nvarchar(1000) ,
[Img3saveName] nvarchar(1000) ,
[Img4saveName] nvarchar(1000) ,
[Img5saveName] nvarchar(1000) ,
[Img6saveName] nvarchar(1000) ,
[Img7saveName] nvarchar(1000) ,
[Img8saveName] nvarchar(1000) ,
[Img9saveName] nvarchar(1000) ,
[Img10saveName] nvarchar(1000) ,
[imgName] nvarchar(1000) ,
[isSystem] nvarchar(200) ,
[cusMenuId] numeric(10) 
);
GO

INSERT INTO [OA_CUSTMENU_CURMOBILE] VALUES ('workflow', '流程', '流程', 0, '', '', '1', 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'desk_flow.png', '1', NULL);
GO
INSERT INTO [OA_CUSTMENU_CURMOBILE] VALUES ('innermail', '邮件', '邮件', 0, '', '', '1', 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'desk_mail.png', '1', NULL);
GO
INSERT INTO [OA_CUSTMENU_CURMOBILE] VALUES ('information', '信息', '信息', 1, '', '', '1', 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'desk_information.png', '1', NULL);
GO
INSERT INTO [OA_CUSTMENU_CURMOBILE] VALUES ('documentmanager', '公文', '公文', 0, '', '', '1', 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'desk_gov.png', '1', NULL);
GO
INSERT INTO [OA_CUSTMENU_CURMOBILE] VALUES ('weibo', '微博', '微博', 0, '', '', '1', -1, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'desk_microblog.png', '1', NULL);
GO
INSERT INTO [OA_CUSTMENU_CURMOBILE] VALUES ('forum', '论坛', '论坛', 0, '', '', '1', 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'desk_forum.png', '1', NULL);
GO
INSERT INTO [OA_CUSTMENU_CURMOBILE] VALUES ('workmanager_calendar', '日程', '日程', 0, '', '', '1', -1, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'desk_schedule.png', '1', NULL);
GO
INSERT INTO [OA_CUSTMENU_CURMOBILE] VALUES ('workmanager_workreport', '汇报', '汇报', 1, '', '', '1', 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'desk_report.png', '1', NULL);
GO
INSERT INTO [OA_CUSTMENU_CURMOBILE] VALUES ('workmanager_linkman_inner', '内部联系人', '联系人', 0, '', '', '1', -1, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'desk_person.png', '1', NULL);
GO
INSERT INTO [OA_CUSTMENU_CURMOBILE] VALUES ('workmanager_worklog', '日志', '日志', 0, '', '', '1', 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'desk_log.png', '1', NULL);
GO
INSERT INTO [OA_CUSTMENU_CURMOBILE] VALUES ('phone_meeting', '电话会议', '电话会议', 0, '', '', '1', -1, '', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'desk_phonemeet.png', '1', NULL);
GO
ALTER TABLE OA_CUSTMENU ADD mobileId NUMERIC(20);
go
update org_employee set ischangepwd=0 where useraccounts in('sys','admin','security');
go
ALTER TABLE OA_CUSTMENU ADD mobileId NUMERIC(20);
go
alter table ORG_DOMAIN add oa_vkey varchar(200) ;
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.02_SP_20160301','11.4.0.02',getdate());
go





create table EVO_WORK_ATTENDANCE
(
  id             NUMERIC(20) IDENTITY(1,1) primary key  not null,
  domain         NVARCHAR(20),
  empid          NVARCHAR(20),
  empname        NVARCHAR(50),
  createorgid    NVARCHAR(20),
  sign_date      NVARCHAR(20),
  map_position   NVARCHAR(200),
  sign_status    NVARCHAR(1)
);
go
alter table EZ_FLOW_HI_PROCINST alter column WHIR_DEALING_USERS nvarchar(1000);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.03_SP_20160314','11.4.0.03',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.04_SP_20160322','11.4.0.04',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.05_SP_20160328','11.4.0.05',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.06_SP_20160405','11.4.0.06',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.07_SP_20160408','11.4.0.07',getdate());
go





select a.emp_id,count(*) cnt
into ls_oa_mail_tj
from OA_MAIL_USER a 
where a.notread = 1 and a.mailstatus in(0,1,3,5)
group by a.emp_id;
go

update oa_system_remind
set newmail = (
select cnt
from ls_oa_mail_tj
where userid = emp_id);
go

update oa_system_remind
set newmail = 0
where newmail is null;
go


drop table ls_oa_mail_tj;
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [ezoffice].[trigger_oa_mail_user_update] on [ezoffice].[OA_MAIL_USER] after update
as
declare 
@newNotread numeric(20),
@newMailId numeric(20),
@newMailStatus numeric(20),
@oldNotread numeric(20),
@oldMailId numeric(20),
@oldMailStatus numeric(20),
@newEmpId numeric(20),
@oldEmpId numeric(20)
select @newNotread=notread,@newMailId=mail_id,@newMailStatus=mailstatus,@newEmpid=emp_id from Inserted
select @oldNotread=notread,@oldMailId=mail_id,@oldMailStatus=mailstatus,@oldEmpid=emp_id from Deleted
if (@newNotread = 1 and @oldNotread = 0 and @oldMailStatus <> 2)
	begin
		if(@oldMailStatus = 1 and (@newMailStatus = 10 or @newMailStatus = 11))
			update oa_system_remind set newmail = newmail-1 where userid = @newEmpid;
		else
		if(@newMailStatus = 1 and @oldMailStatus <> 1)
			update oa_system_remind set newmail = newmail+1 where userid = @newEmpid;
		else
		if(@newMailStatus <> 1 and @oldMailStatus = 1)
			update oa_system_remind set newmail = newmail-1 where userid = @newEmpid;
		else
		if(@oldNotread <> 1)
			update oa_system_remind set newmail = newmail+1 where userid = @newEmpid;
	end
else
if(@newNotread <> 1 and @oldNotread = 1 and @oldMailStatus <> 2)
	update oa_system_remind set newmail = newmail-1 where userid = @newEmpid;
else
--未读邮件移入移出废件箱
if(@newNotread = 1 and @oldNotread = 1 and @newMailStatus <> 4)
	begin
		--移动到废件箱
		if(@oldMailStatus <> 2 and @newMailStatus = 2)
			update oa_system_remind set newmail = newmail-1 where userid = @newEmpid;
		else
		--移出废件箱
		if(@oldMailStatus = 2 and @newMailStatus <> 2)
			update oa_system_remind set newmail = newmail+1 where userid = @newEmpid;
	end
else

--修改部分
if(@newMailStatus = 4 and @oldMailStatus <> 4 and @oldMailStatus <> 2 and @oldNotread = 1)
	update oa_system_remind set newmail = newmail-1 where userid = @newEmpid;


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER trigger [ezoffice].[trigger_oa_mail_user_delete] on [ezoffice].[OA_MAIL_USER] after delete
as
declare 
@oldNotread numeric(20),
@oldMailId numeric(20),
@oldMailStatus numeric(20),
@oldEmpId numeric(20)
select @oldNotread=notread,@oldMailId=mail_id,@oldMailStatus=mailstatus,@oldEmpid=emp_id from Deleted
if @oldNotread = 1 and @oldMailStatus <> 4 and @oldMailStatus <> 2
          update oa_system_remind set newmail = newmail-1 where userid = @oldEmpid;


update OA_EVO_INFO set IMGUPLOADSHOWNAME = 'logo.png',IMGUPLOADSAVENAME='201610801920.png' where uploadType ='1080*1920';                       
go         
update OA_EVO_INFO set IMGUPLOADSHOWNAME = 'logo.png',IMGUPLOADSAVENAME='20167201280.png' where uploadType ='720*1280';                     
go           
update OA_EVO_INFO set IMGUPLOADSHOWNAME = 'logo.png',IMGUPLOADSAVENAME='2016480854.png' where uploadType = '480*845';                       
go           
update OA_EVO_INFO set IMGUPLOADSHOWNAME = 'logo.png',IMGUPLOADSAVENAME='20167501334.png' where uploadType ='750*1334';                     
go         
update OA_EVO_INFO set IMGUPLOADSHOWNAME = 'logo.png',IMGUPLOADSAVENAME='201612422208.png' where uploadType = '1242*2208';                       
go

insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.08_SP_20160418','11.4.0.08',getdate());
go






alter table SYS_CORP_SET add relactionId varchar(20) ;
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [ezoffice].[trigger_oa_mail_user_delete] on [ezoffice].[OA_MAIL_USER] after delete
as
update oa_system_remind  set newmail = newmail-(select COUNT(*) from Deleted 	where notread = 1   and mailstatus<>4  and mailstatus<>2 and userid = emp_id) where exists(select 1 from Deleted where notread = 1  and mailstatus<>4  and mailstatus<>2  and userid = emp_id);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.09_SP_20160423','11.4.0.09',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.10_SP_20160427','11.4.0.10',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.11_SP_20160429','11.4.0.11',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.12_SP_20160505','11.4.0.12',getdate());
go





alter table SYS_CORP_SET add last_relactionId varchar(20) ;
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.13_SP_20160510','11.4.0.13',getdate());
go





update ezoffice.HR_RPT_INIT_FIELD set VAL_SOURCE='ezoffice.FN_DATEDIFF_SYS(''month'', a.EMPFIREDATE)' WHERE SHOW_NAME='工龄';
go
update ezoffice.HR_RPT_INIT_FIELD set VAL_SOURCE='ezoffice.FN_DATEDIFF_SYS(''month'', a.INTOCOMPANYDATE)' WHERE SHOW_NAME='本单位工龄';
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.14_SP_20160519','11.4.0.14',getdate());
go





delete from  ez_secu_pagelist  where    list_type=3  and   secu_url='/officeserverservlet';
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.15_SP_20160529','11.4.0.15',getdate());
go





alter table GJ_STOCK ADD tongBu varchar(20)  default '00';
go
ALTER  TABLE  OA_BOARDROOMAPPLY  ADD  MEETINGATTENDANCE  NUMERIC(2);
GO
ALTER  TABLE  OA_BOARDROOMAPPLY  ADD  ATTENDANCETYPE  NUMERIC(2);
GO
ALTER  TABLE  OA_BOARDROOMAPPLY  ADD  QRCODE  NVARCHAR(200);
GO
ALTER  TABLE  OA_BOARDROOM_EXECUTESTATUS  ADD  ATTENDANCESTATUS  NUMERIC(2);
GO
alter table oa_boardroom_meetingtime add  createdate nvarchar(20);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.16_SP_20160606','11.4.0.16',getdate());
go





alter table oa_boardroomapply add  signstate nvarchar(1);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.17_SP_20160620','11.4.0.17',getdate());
go





update oa_custmenu_curmobile set domainid=-1 where mobilemenuname='日志';
go

alter table Org_domain add oa_PDF varchar(1) ;
go

create table gov_pdffilename (
  pdfid       numeric(20) identity(1,1),
  workid      numeric(20),
  pdfpzr      nvarchar(200),
  pdfpzsj     datetime,
  pdfpzhj     nvarchar(200),
  pdfzhxgsj   datetime,
  pdfrealname nvarchar(500),
  pdfsavename nvarchar(500),
  pdfgwlx     nvarchar(5),
  pdfsfpz     nvarchar(5),
  pdfwjjmc    nvarchar(100),
  recordid    numeric(20)
);
go

alter table oa_boardroomapply add  signuser nvarchar(4000) ;
go
alter table oa_boardroomapply add  unsignuser nvarchar(4000) ;
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.18_SP_20160703','11.4.0.18',getdate());
go






INSERT INTO EZ_SECU_PAGELIST(SECU_URL,LIST_TYPE) VALUES ('/officeserverservlet',3);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.19_SP_20160715','11.4.0.19',getdate());
go





alter table ez_form add  editorType nvarchar(50) ;
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.20_SP_20160730','11.4.0.20',getdate());
go





update ez_form set editorType=1 where editorType is null or editorType='';
go

alter table OA_THEMEOPTION add OPTIONSCORE_BACK Numeric(7,3);
go
UPDATE OA_THEMEOPTION SET OPTIONSCORE_BACK = OPTIONSCORE ;
go
update OA_THEMEOPTION set OPTIONSCORE = null;
go
alter table OA_THEMEOPTION alter COLUMN  OPTIONSCORE Numeric(7,3);
go
UPDATE OA_THEMEOPTION SET OPTIONSCORE = OPTIONSCORE_BACK ;
go
alter table OA_THEMEOPTION drop column OPTIONSCORE_BACK;
go
alter table oa_mailinterior add cloudcontrol numeric(1,0);
go

insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.21_SP_20160813','11.4.0.21',getdate());
go





insert into ez_secu_pagelist (secu_url, client_url, list_type, createtime) values ('/modules/subsidiary/ezcard/ordersIfExistResult.jsp', '', 1, getdate());
go
insert into ez_secu_pagelist (secu_url, client_url, list_type, createtime) values ('/modules/subsidiary/ezcard/ordersIfExistResult.jsp', '', 3, getdate());
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.22_SP_20160827','11.4.0.22',getdate());
go





alter table union_task alter column REMIDTYPE VARCHAR(200);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.23_SP_20160911','11.4.0.23',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.24_SP_20160914','11.4.0.24',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.25_SP_20160924','11.4.0.25',getdate());
go



insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.26_SP_20161015','11.4.0.26',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.27_SP_20161029','11.4.0.27',getdate());
go






insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.28_SP_20161113','11.4.0.28',getdate());
go




insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.29_SP_20161128','11.4.0.29',getdate());
go





update wf_oa_relatefield set field_table_displayname = '人员表(系统)' where field_table_displayname='人员表(系统))';
go
insert into  EZ_SECU_PAGELIST(SECU_URL,LIST_TYPE)values('/OpenFromMobile',1);
go
insert into  EZ_SECU_PAGELIST(SECU_URL,LIST_TYPE)values('/OpenFromMobile',3);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.30_SP_20170311','11.4.0.30',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.31_SP_20170327','11.4.0.31',getdate());
go






insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.32_SP_20170414','11.4.0.32',getdate());
go






insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.4.0.33_SP_20170508','11.4.0.33',getdate());
go