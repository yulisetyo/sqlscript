ALTER TABLE USERKUR.UMKM_T_PROYEKSI
 DROP PRIMARY KEY CASCADE;

DROP TABLE USERKUR.UMKM_T_PROYEKSI CASCADE CONSTRAINTS;

CREATE TABLE USERKUR.UMKM_T_PROYEKSI
(
  ID          NUMBER                            NOT NULL,
  KODE_BANK   VARCHAR2(3 BYTE)                  NOT NULL,
  TAHUN       VARCHAR2(4 BYTE)                  NOT NULL,
  BULAN       VARCHAR2(2 BYTE)                  NOT NULL,
  NO_SURAT    VARCHAR2(50 BYTE)                 NOT NULL,
  TGL_SURAT   DATE                              NOT NULL,
  NILAI       NUMBER                            NOT NULL,
  CREATED_AT  DATE                              DEFAULT sysdate,
  UPDATED_AT  DATE                              DEFAULT sysdate,
  NO_SP2D     VARCHAR2(15 BYTE)                 NOT NULL,
  STATUS      NUMBER,
  NMFILE      VARCHAR2(255 BYTE),
  KET         VARCHAR2(4000 CHAR),
  NONTPN      VARCHAR2(255 CHAR),
  TGNTPN      DATE,
  SETORAN     NUMBER,
  NMFILE1     VARCHAR2(255 CHAR)
)
TABLESPACE KUR
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE UNIQUE INDEX USERKUR.UMKM_T_PROYEKSI_PK ON USERKUR.UMKM_T_PROYEKSI
(ID)
LOGGING
TABLESPACE KUR
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX USERKUR.UMKM_T_PROYEKSI_U01 ON USERKUR.UMKM_T_PROYEKSI
(KODE_BANK, TAHUN, BULAN)
LOGGING
TABLESPACE KUR
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE OR REPLACE TRIGGER USERKUR.UMKM_T_PROYEKSI_TG
before insert ON USERKUR.UMKM_T_PROYEKSI
for each row
begin
	select UMKM_T_PROYEKSI_SEQ.NEXTVAL
	into :new.ID
	from dual;
end;
/


ALTER TABLE USERKUR.UMKM_T_PROYEKSI ADD (
  CONSTRAINT UMKM_T_PROYEKSI_PK
  PRIMARY KEY
  (ID)
  USING INDEX USERKUR.UMKM_T_PROYEKSI_PK
  ENABLE VALIDATE,
  CONSTRAINT UMKM_T_PROYEKSI_U01
  UNIQUE (KODE_BANK, TAHUN, BULAN)
  USING INDEX USERKUR.UMKM_T_PROYEKSI_U01
  ENABLE VALIDATE);

ALTER TABLE USERKUR.UMKM_T_PROYEKSI ADD (
  CONSTRAINT UMKM_T_PROYEKSI_R01 
  FOREIGN KEY (NO_SP2D) 
  REFERENCES USERKUR.UMKM_T_SP2D (NO_SP2D)
  ENABLE VALIDATE,
  CONSTRAINT UMKM_T_PROYEKSI_R02 
  FOREIGN KEY (KODE_BANK) 
  REFERENCES USERKUR.UMKM_R_LJK (KD_PENYALUR)
  ENABLE VALIDATE);
