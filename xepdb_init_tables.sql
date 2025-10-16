/* Formatted on 15/10/2025 0:08:14 (QP5 v5.215.12089.38647) */
  SELECT *
    FROM tab
ORDER BY 1 DESC;

  SELECT owner, object_name, object_type
    FROM all_objects
   WHERE object_name LIKE 'XT%'
ORDER BY 3, 2;

DROP TABLE xt_user;
DROP SEQUENCE xt_user_seq;

CREATE TABLE xt_user
(
    id           NUMBER,
    username     VARCHAR2 (15 CHAR),
    password     VARCHAR2 (150 CHAR),
    created_at   DATE,
    updated_at   DATE,
    created_by   NUMBER
);

DROP TABLE xt_role;

CREATE TABLE xt_role
(
    id            NUMBER,
    description   VARCHAR2 (30 CHAR),
    active        NUMBER
);

DROP TABLE xt_privilege;
DROP SEQUENCE xt_privilege_seq;

CREATE TABLE xt_privilege
(
    id            NUMBER,
    name          VARCHAR2 (30 CHAR),
    description   VARCHAR2 (100 CHAR)
);

DROP TABLE xt_module;

CREATE TABLE xt_module
(
    id            NUMBER,
    name          VARCHAR2 (30 CHAR),
    description   VARCHAR2 (100 CHAR),
    active        NUMBER
);

DROP TABLE xt_module_role;
DROP SEQUENCE xt_module_role_seq;
DROP TRIGGER xt_module_role_trg;

CREATE TABLE xt_module_role
(
    id           NUMBER,
    id_module    NUMBER,
    id_role      NUMBER,
    keterangan   VARCHAR2 (100 CHAR)
);

DROP TABLE xt_menu;

CREATE TABLE xt_menu
(
    id          NUMBER,
    title       VARCHAR2 (50 CHAR),
    link_url    VARCHAR2 (175 CHAR),
    id_module   NUMBER,
    is_parent   NUMBER,
    parent_id   NUMBER,
    sequence    NUMBER,
    filename    VARCHAR2 (100 CHAR),
    icon        VARCHAR2 (255 CHAR)
);

DROP TABLE xt_user_role;
DROP SEQUENCE xt_user_role_seq;
DROP TRIGGER xt_user_role_trg;

CREATE TABLE xt_user_role
(
    id            NUMBER,
    id_user       NUMBER,
    id_role       NUMBER,
    is_default    NUMBER,
    description   VARCHAR2 (100 CHAR),
    --start_access date,
    --end_access date,
    created_at    DATE,
    created_by    NUMBER
);

DROP TABLE xt_role_privilege;
DROP SEQUENCE xt_role_privilege_seq;
DROP TRIGGER xt_role_privilege_trg;

CREATE TABLE xt_role_privilege
(
    id             NUMBER,
    id_role        NUMBER,
    id_privilege   NUMBER,
    description    VARCHAR2 (100 CHAR),
    start_access   DATE,
    end_access     DATE,
    created_at     DATE,
    updated_at     DATE,
    created_by     NUMBER,
    updated_by     NUMBER
);

DROP TABLE xt_ortu;
DROP SEQUENCE xt_ortu_seq;

CREATE TABLE xt_ortu
(
    id                NUMBER,
    nik               VARCHAR2 (16 CHAR),
    nama              VARCHAR2 (50 CHAR),
    alamat_domisili   VARCHAR2 (50 CHAR),
    kelurahan         VARCHAR2 (35 CHAR),
    kecamatan         VARCHAR2 (35 CHAR),
    kota              VARCHAR2 (35 CHAR),
    telepon           VARCHAR2 (14 CHAR),
    email             VARCHAR2 (35 CHAR)
);

DROP TABLE xt_siswa;

CREATE TABLE xt_siswa
(
    nisn              VARCHAR2 (10 CHAR),
    nama_siswa        VARCHAR2 (50 CHAR),
    nik               VARCHAR2 (16 CHAR),
    tanggal_lahir     DATE,
    tempat_lahir      VARCHAR2 (30 CHAR),
    alamat_domisili   VARCHAR2 (50 CHAR),
    kelurahan         VARCHAR2 (35 CHAR),
    kecamatan         VARCHAR2 (35 CHAR),
    kota              VARCHAR2 (35 CHAR),
    telepon           VARCHAR2 (14 CHAR),
    id_ortu           NUMBER,
    status            VARCHAR2 (15 CHAR)
);

DROP TABLE xt_pegawai;

CREATE TABLE xt_pegawai
(
    id               NUMBER,
    nip              VARCHAR2 (18 CHAR),
    nama             VARCHAR2 (50 CHAR),
    tanggal_lahir    DATE,
    tempat_lahir     DATE,
    status_pegawai   VARCHAR2 (15 CHAR)
);

DROP TABLE xt_presensi_pegawai;
DROP SEQUENCE xt_presensi_pegawai_seq;

CREATE TABLE xt_presensi_pegawai
(
    id               NUMBER,
    id_pegawai       VARCHAR2 (10 CHAR),
    status_absensi   CHAR (1 CHAR),
    clock_in         DATE,
    clock_out        DATE,
    keterangan       VARCHAR2 (100 CHAR)
);