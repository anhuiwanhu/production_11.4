create table OA_SYSTEM_USERFINGERSET(
  userid number(20),
  userAccount varchar2(100),
  FORBIDMODULE varchar2(200)   
);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.4.0.01_SP_20160223','11.4.0.01',sysdate);
commit;