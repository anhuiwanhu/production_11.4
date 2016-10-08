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