DROP TABLE IF EXISTS packages;
DROP TABLE IF EXISTS versions;
DROP TABLE IF EXISTS releases;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS stages;


CREATE TABLE stages (
  stage       TEXT    NOT NULL PRIMARY KEY
);
INSERT INTO stages VALUES ('dev');
INSERT INTO stages VALUES ('test');
INSERT INTO stages VALUES ('prod');


CREATE TABLE categories (
  category    INTEGER NOT NULL PRIMARY KEY,
  description TEXT    NOT NULL
);
INSERT INTO categories VALUES (0, 'Hidden');
INSERT INTO categories VALUES (1, 'PostgreSQL');
INSERT INTO categories VALUES (2, 'Extensions');
INSERT INTO categories VALUES (3, 'Servers');
INSERT INTO categories VALUES (4, 'Applications');
INSERT INTO categories VALUES (5, 'Connectors');
INSERT INTO categories VALUES (6, 'Frameworks');


CREATE TABLE projects (
  project   	 TEXT    NOT NULL PRIMARY KEY,
  category  	 INTEGER NOT NULL,
  port      	 INTEGER NOT NULL,
  depends   	 TEXT    NOT NULL,
  start_order    INTEGER NOT NULL,
  homepage_url   TEXT    NOT NULL,
  short_desc     TEXT    NOT NULL,
  FOREIGN KEY (category) REFERENCES categories(category)
);
INSERT INTO projects VALUES
  ('hub', 0, 0, 'hub', 0, 'http://bigsql.org', 'Pretty Good CLI');
INSERT INTO projects VALUES
  ('pg', 1, 5432, 'hub', 1, 'http://postgresql.org', 'Advanced RDBMS');
INSERT INTO projects VALUES
  ('plprofiler', 2, 0, 'hub', 0, 'https://bitbucket.org/openscg/plprofiler', 'PLpg/SQL Profiler');
INSERT INTO projects VALUES
  ('postgis', 2, 0, 'hub', 0, 'http://postgis.net', 'PostGIS Geospatial');
INSERT INTO projects VALUES
  ('slony', 2, 0, 'hub', 0, 'http://slony.info', 'Slony Replication System');
INSERT INTO projects VALUES
  ('cassandra_fdw', 2, 0, 'hub', 0, 'http://cassandrafdw.org', 'Cassandra FDW');
INSERT INTO projects VALUES
  ('hadoop_fdw', 2, 0, 'hub', 0, 'http://hadoopfdw.org', 'Hadoop FDW');
INSERT INTO projects VALUES
  ('oracle_fdw', 2, 0, 'hub', 0, 'https://github.com/laurenz/oracle_fdw', 'Oracle FDW');
INSERT INTO projects VALUES
  ('mysql_fdw', 2, 0, 'hub', 0, 'https://github.com/EnterpriseDB/mysql_fdw', 'MySQL FDW');
INSERT INTO projects VALUES
  ('tds_fdw', 2, 0, 'hub', 0, 'https://github.com/tds-fdw/tds_fdw', 'TDS (Sybase and MS SQL) FDW');
INSERT INTO projects VALUES
  ('orafce', 2, 0, 'hub', 0, 'https://github.com/orafce/orafce', 'Oracle Compatible Functions');
INSERT INTO projects VALUES
  ('plv8', 2, 0, 'hub', 0, 'https://github.com/plv8/plv8', 'Javascript Procedural Language');
INSERT INTO projects VALUES
  ('pljava', 2, 0, 'hub', 0, 'https://github.com/tada/pljava', 'Java Procedural Language');
INSERT INTO projects VALUES
  ('pgtsql', 2, 0, 'hub', 0, 'https://bitbucket.org/openscg/pgtsql', 'Sybase and MS SQL Compatibiliy');
INSERT INTO projects VALUES
  ('bam', 3, 8050, 'hub', 0, '', 'BigSQL Manager');
INSERT INTO projects VALUES
  ('pgbouncer', 3, 6543, 'hub', 2, 'http://pgbouncer.github.io', 'Connection Pooler');
INSERT INTO projects VALUES
  ('consul', 3, 8500, 'hub', 1, 'http://consul.io', 'Service discovery');
INSERT INTO projects VALUES
  ('pgstudio', 3, 8765, 'java', 3, 'http://postgresqlstudio.org', 'Web-based Development');
INSERT INTO projects VALUES
  ('hadoop', 3, 50010, 'java', 7, 'http://hadoop.apache.org', 'Distributed Framework');
INSERT INTO projects VALUES
  ('zookeeper', 3, 2181, 'java', 6, 'http://zookeeper.apache.org', 'Cluster Coordinator');
INSERT INTO projects VALUES
  ('cassandra', 3, 7000, 'java', 4, 'http://cassandra.apache.org', 'Multi-master/Multi-datacenter');
INSERT INTO projects VALUES
  ('spark', 3, 7077, 'java', 5, 'http://spark.apache.org', 'Speedy Distributed Data Access');
INSERT INTO projects VALUES
  ('hive', 3, 10000, 'java', 8, 'http://hive.apache.org', 'Hadoop SQL Queries');
INSERT INTO projects VALUES
  ('pgha', 3, 1234, 'perl', 3, 'http://www.bigsql.org/se/pgha', 'High Availability');
INSERT INTO projects VALUES
  ('tomcat', 3, 8080, 'java', 3, 'http://tomcat.apache.org', 'Java Servlets & JSPs');

INSERT INTO projects VALUES
  ('pgadmin', 4, 1, 'hub', 0, 'http://pgadmin.org', 'Desktop Development Environment');
INSERT INTO projects VALUES
  ('pgbadger', 4, 0, 'perl', 0, 'https://github.com/dalibo/pgbadger', 'Fast Log Analyzer');
INSERT INTO projects VALUES
  ('backrest', 4, 0, 'perl', 0, 'http://www.pgbackrest.org', 'Reliable Backup & Restore');
INSERT INTO projects VALUES
  ('ora2pg', 4, 0, 'perl', 0, 'http://ora2pg.darold.net/', 'Oracle migration toolkit');
INSERT INTO projects VALUES
  ('birt', 4, 0, 'java', 0, 'http://projects.eclipse.org/projects/birt', 'Business Intelligence & Reporting Tools');

INSERT INTO projects VALUES
  ('python', 6, 0, 'hub', 0, 'http://python.org', 'Python programming language');
INSERT INTO projects VALUES
  ('perl', 6, 0, 'hub', 0, 'http://perl.org', 'Perl programming language');
INSERT INTO projects VALUES
  ('tcl', 6, 0, 'hub', 0, 'http://tcl.tk', 'Tcl programming language');
INSERT INTO projects VALUES
  ('java', 6, 0, 'hub', 0, 'http://openjdk.java.net', 'Java Runtime Environment');


CREATE TABLE releases (
  component TEXT NOT NULL PRIMARY KEY,
  project   TEXT NOT NULL,
  sup_plat  TEXT NOT NULL,
  doc_url   TEXT NOT NULL,
  stage     TEXT NOT NULL,
  FOREIGN KEY (project) REFERENCES projects(project),
  FOREIGN KEY (stage)   REFERENCES stages(stage)
);
INSERT INTO releases VALUES
  ('hub',        'hub',      '',        '', 'prod');
INSERT INTO releases VALUES
  ('pg92',       'pg',       '',        'http://www.postgresql.org/docs/9.2/', 'prod');
INSERT INTO releases VALUES
  ('pg93',       'pg',       '',        'http://www.postgresql.org/docs/9.3/', 'prod');
INSERT INTO releases VALUES
  ('pg94',       'pg',       '',        'http://www.postgresql.org/docs/9.4/', 'prod');
INSERT INTO releases VALUES
  ('pg95',       'pg',       '',        'http://www.postgresql.org/docs/9.5/', 'prod');
INSERT INTO releases VALUES
  ('pg96',       'pg',       '',        'http://www.postgresql.org/docs/9.6/', 'prod');
INSERT INTO releases VALUES
  ('pgha2',      'pgha',     'linux64', '', 'prod');
INSERT INTO releases VALUES
  ('pgadmin3',   'pgadmin',  '',        'http://www.pgadmin.org/docs/1.22/index.html', 'prod');
INSERT INTO releases VALUES
  ('pgadmin4',   'pgadmin',  '',        'https://www.pgadmin.org/docs4/dev/index.html', 'prod');
INSERT INTO releases VALUES
  ('cassandra30','cassandra','', 'http://docs.datastax.com/en/cassandra/3.0/cassandra/cassandraAbout.html', 'prod');
INSERT INTO releases VALUES
  ('tomcat8','tomcat','', 'http://tomcat.apache.org/tomcat-8.0-doc/index.html', 'prod');
INSERT INTO releases VALUES
  ('spark16',    'spark',    'linux64', 'http://spark.apache.org/news/spark-1-6-0-released.html', 'prod');
INSERT INTO releases VALUES
  ('hadoop26',   'hadoop',   'linux64', '', 'prod');
INSERT INTO releases VALUES
  ('hive2',      'hive',     'linux64', '', 'prod');
INSERT INTO releases VALUES
  ('zookeeper34','zookeeper','linux64', '', 'prod');
INSERT INTO releases VALUES
  ('pgstudio2',  'pgstudio', '', '', 'prod');
INSERT INTO releases VALUES
  ('pgbouncer17','pgbouncer','', 'https://pgbouncer.github.io/usage.html', 'prod');
INSERT INTO releases VALUES
  ('consul',     'consul',   '', 'http://consul.io/docs', 'test');
INSERT INTO releases VALUES
  ('pgbadger',   'pgbadger', '', 'https://github.com/dalibo/pgbadger/blob/master/doc/pgBadger.pod', 'prod');
INSERT INTO releases VALUES
  ('backrest',   'backrest', '', 'http://www.pgbackrest.org', 'prod');
INSERT INTO releases VALUES
  ('ora2pg',     'ora2pg',   '', 'http://ora2pg.darold.net/documentation.html', 'prod');
INSERT INTO releases VALUES
  ('python2',    'python',   '', '', 'prod');
INSERT INTO releases VALUES
  ('perl5',      'perl',     '', '', 'prod');
INSERT INTO releases VALUES
  ('tcl86',      'tcl',      '', '', 'prod');
INSERT INTO releases VALUES
  ('java8',      'java',     '', '', 'prod');
INSERT INTO releases VALUES
  ('bam2',       'bam',      '', '', 'prod');
INSERT INTO releases VALUES
  ('plprofiler3-pg96', 'plprofiler', '', 'https://bitbucket.org/openscg/plprofiler', 'prod');
INSERT INTO releases VALUES
  ('plprofiler3-pg95', 'plprofiler', '', 'https://bitbucket.org/openscg/plprofiler', 'prod');
INSERT INTO releases VALUES
  ('cassandra_fdw3-pg95', 'cassandra_fdw', '', '', 'prod');
INSERT INTO releases VALUES
  ('hadoop_fdw2-pg96', 'hadoop_fdw', '', '', 'prod');
INSERT INTO releases VALUES
  ('hadoop_fdw2-pg95', 'hadoop_fdw', '', '', 'prod');
INSERT INTO releases VALUES
  ('hadoop_fdw2-pg94', 'hadoop_fdw', '', '', 'prod');
INSERT INTO releases VALUES
  ('slony22-pg96',   'slony',   '', 'http://slony.info/documentation/2.2/index.html', 'prod');
INSERT INTO releases VALUES
  ('slony22-pg95',   'slony',   '', 'http://slony.info/documentation/2.2/index.html', 'prod');
INSERT INTO releases VALUES
  ('slony22-pg94',   'slony',   '', 'http://slony.info/documentation/2.2/index.html', 'prod');
INSERT INTO releases VALUES
  ('slony22-pg93',   'slony',   '', 'http://slony.info/documentation/2.2/index.html', 'prod');
INSERT INTO releases VALUES
  ('slony22-pg92',   'slony',   '', 'http://slony.info/documentation/2.2/index.html', 'prod');
INSERT INTO releases VALUES
  ('postgis23-pg96', 'postgis', '', 'http://postgis.net/docs/manual-2.3', 'prod');
INSERT INTO releases VALUES
  ('postgis23-pg95', 'postgis', '', 'http://postgis.net/docs/manual-2.3', 'prod');
INSERT INTO releases VALUES
  ('postgis22-pg96', 'postgis', '', 'http://postgis.net/docs/manual-2.2', 'prod');
INSERT INTO releases VALUES
  ('postgis22-pg95', 'postgis', '', 'http://postgis.net/docs/manual-2.2', 'prod');
INSERT INTO releases VALUES
  ('postgis22-pg94', 'postgis', '', 'http://postgis.net/docs/manual-2.2', 'prod');
INSERT INTO releases VALUES
  ('postgis22-pg93', 'postgis', '', 'http://postgis.net/docs/manual-2.2', 'prod');
INSERT INTO releases VALUES
  ('postgis22-pg92', 'postgis', '', 'http://postgis.net/docs/manual-2.2', 'prod');
INSERT INTO releases VALUES
  ('birt', 'birt', '', 'http://eclipse.org/mars', 'prod');
INSERT INTO releases VALUES
  ('oracle_fdw1-pg96', 'oracle_fdw', '', 'https://github.com/laurenz/oracle_fdw', 'prod');
INSERT INTO releases VALUES
  ('oracle_fdw1-pg95', 'oracle_fdw', '', 'https://github.com/laurenz/oracle_fdw', 'prod');
INSERT INTO releases VALUES
  ('oracle_fdw1-pg94', 'oracle_fdw', '', 'https://github.com/laurenz/oracle_fdw', 'prod');
INSERT INTO releases VALUES
  ('oracle_fdw1-pg93', 'oracle_fdw', '', 'https://github.com/laurenz/oracle_fdw', 'prod');
INSERT INTO releases VALUES
  ('oracle_fdw1-pg92', 'oracle_fdw', '', 'https://github.com/laurenz/oracle_fdw', 'prod');
INSERT INTO releases VALUES
  ('mysql_fdw2-pg95', 'mysql_fdw', '', 'https://github.com/EnterpriseDB/mysql_fdw', 'prod');
INSERT INTO releases VALUES
  ('mysql_fdw2-pg94', 'mysql_fdw', '', 'https://github.com/EnterpriseDB/mysql_fdw', 'prod');
INSERT INTO releases VALUES
  ('mysql_fdw2-pg93', 'mysql_fdw', '', 'https://github.com/EnterpriseDB/mysql_fdw', 'prod');
INSERT INTO releases VALUES
  ('tds_fdw1-pg95', 'tds_fdw', '', 'https://github.com/tds-fdw/tds_fdw', 'prod');
INSERT INTO releases VALUES
  ('tds_fdw1-pg94', 'tds_fdw', '', 'https://github.com/tds-fdw/tds_fdw', 'prod');
INSERT INTO releases VALUES
  ('tds_fdw1-pg93', 'tds_fdw', '', 'https://github.com/tds-fdw/tds_fdw', 'prod');
INSERT INTO releases VALUES
  ('tds_fdw1-pg92', 'tds_fdw', '', 'https://github.com/tds-fdw/tds_fdw', 'prod');
INSERT INTO releases VALUES
  ('orafce3-pg96', 'orafce', '', 'https://github.com/orafce/orafce', 'prod');
INSERT INTO releases VALUES
  ('orafce3-pg95', 'orafce', '', 'https://github.com/orafce/orafce', 'prod');
INSERT INTO releases VALUES
  ('orafce3-pg94', 'orafce', '', 'https://github.com/orafce/orafce', 'prod');
INSERT INTO releases VALUES
  ('orafce3-pg93', 'orafce', '', 'https://github.com/orafce/orafce', 'prod');
INSERT INTO releases VALUES
  ('orafce3-pg92', 'orafce', '', 'https://github.com/orafce/orafce', 'prod');
INSERT INTO releases VALUES
  ('plv814-pg96', 'plv8', '', 'https://github.com/plv8/plv8', 'prod');
INSERT INTO releases VALUES
  ('plv814-pg95', 'plv8', '', 'https://github.com/plv8/plv8', 'prod');
INSERT INTO releases VALUES
  ('plv814-pg94', 'plv8', '', 'https://github.com/plv8/plv8', 'prod');
INSERT INTO releases VALUES
  ('plv815-pg96', 'plv8', '', 'https://github.com/plv8/plv8', 'prod');
INSERT INTO releases VALUES
  ('plv815-pg95', 'plv8', '', 'https://github.com/plv8/plv8', 'prod');
INSERT INTO releases VALUES
  ('plv815-pg94', 'plv8', '', 'https://github.com/plv8/plv8', 'prod');
INSERT INTO releases VALUES
  ('plv815-pg93', 'plv8', '', 'https://github.com/plv8/plv8', 'prod');
INSERT INTO releases VALUES
  ('plv815-pg92', 'plv8', '', 'https://github.com/plv8/plv8', 'prod');
INSERT INTO releases VALUES
  ('pljava15-pg95', 'pljava', '', 'https://github.com/tada/pljava', 'prod');
INSERT INTO releases VALUES
  ('pljava15-pg94', 'pljava', '', 'https://github.com/tada/pljava', 'prod');
INSERT INTO releases VALUES
  ('pljava15-pg93', 'pljava', '', 'https://github.com/tada/pljava', 'prod');
INSERT INTO releases VALUES
  ('pljava15-pg92', 'pljava', '', 'https://github.com/tada/pljava', 'prod');
INSERT INTO releases VALUES
  ('pgtsql9-pg95', 'pgtsql', '', 'https://bitbucket.org/openscg/pgtsql', 'prod');
INSERT INTO releases VALUES
  ('pgtsql9-pg94', 'pgtsql', '', 'https://bitbucket.org/openscg/pgtsql', 'prod');


CREATE TABLE packages (
  component     TEXT    NOT NULL,
  os            TEXT    NOT NULL,
  version       TEXT    NOT NULL,
  release_date  DATE    NOT NULL,
  PRIMARY KEY (component, os),
  FOREIGN KEY (component) REFERENCES releases(component)
);
INSERT INTO packages VALUES ('pg92', 'el7', '9.2.18-1', '20161020');
INSERT INTO packages VALUES ('pg93', 'el7', '9.3.14-1', '20161020');
INSERT INTO packages VALUES ('pg94', 'el7', '9.4.9-1',  '20161020');
INSERT INTO packages VALUES ('pg95', 'el7', '9.5.4-1',  '20161020');
INSERT INTO packages VALUES ('pg96', 'el7', '9.6.0-1',  '20161020');


CREATE TABLE versions (
  component     TEXT    NOT NULL,
  version       TEXT    NOT NULL,
  platform      TEXT    NOT NULL,
  rel_notes_url TEXT	NOT NULL,
  is_current    INTEGER NOT NULL,
  release_date  DATE    NOT NULL,
  parent        TEXT    NOT NULL,
  PRIMARY KEY (component, version),
  FOREIGN KEY (component) REFERENCES releases(component)
);

INSERT INTO versions VALUES
 ('hub', '3.0.1',       '', '', 1, '20161027', '');
INSERT INTO versions VALUES
 ('hub', '3.0.0',       '', '', 0, '20161020', '');
INSERT INTO versions VALUES
 ('hub', '2.8.6',       '', '', 0, '20160929', '');
INSERT INTO versions VALUES
 ('hub', '2.8.5',       '', '', 0, '20160915', '');
INSERT INTO versions VALUES
 ('hub', '2.8.4',       '', '', 0, '20160901', '');
INSERT INTO versions VALUES
 ('hub', '2.8.3',       '', '', 0, '20160818', '');
INSERT INTO versions VALUES
 ('hub', '2.8.2',       '', '', 0, '20160811', '');
INSERT INTO versions VALUES
 ('hub', '2.8.0',       '', '', 0, '20160721', '');
INSERT INTO versions VALUES
 ('hub', '2.7.0',       '', '', 0, '20160701', '');
INSERT INTO versions VALUES
 ('hub', '2.6.7',       '', '', 0, '20160616', '');
INSERT INTO versions VALUES
 ('hub', '2.6.6',       '', '', 0, '20160603', '');
INSERT INTO versions VALUES
 ('hub', '2.6.5',       '', '', 0, '20160523', '');
INSERT INTO versions VALUES
 ('hub', '2.6.4',       '', '', 0, '20160512', '');
INSERT INTO versions VALUES
 ('hub', '2.6.3',       '', '', 0, '20160512', '');
INSERT INTO versions VALUES
 ('hub', '2.6.2',       '', '', 0, '20160415', '');
INSERT INTO versions VALUES
 ('hub', '2.6.1',       '', '', 0, '20160405', '');
INSERT INTO versions VALUES
 ('hub', '2.6.0',       '', '', 0, '20160330', '');
INSERT INTO versions VALUES
 ('hub', '2.5.2',       '', '', 0, '20160328', '');

INSERT INTO versions VALUES
 ('bam2', '1.6.3', '', '', 1, '20161027', '');
INSERT INTO versions VALUES
 ('bam2', '1.6.2', '', '', 0, '20160915', '');
INSERT INTO versions VALUES
 ('bam2', '1.6.1', '', '', 0, '20160811', '');
INSERT INTO versions VALUES
 ('bam2', '1.6.0', '', '', 0, '20160721', '');
INSERT INTO versions VALUES
 ('bam2', '1.5.0', '', '', 0, '20160701', '');
INSERT INTO versions VALUES
 ('bam2', '1.4.2', '', '', 0, '20160603', '');
INSERT INTO versions VALUES
 ('bam2', '1.4.1', '', '', 0, '20160523', '');
INSERT INTO versions VALUES
 ('bam2', '1.4.0', '', '', 0, '20160512', '');
INSERT INTO versions VALUES
 ('bam2', '1.3.1', '', '', 0, '20160415', '');
INSERT INTO versions VALUES
 ('bam2', '1.2.0', '', '', 0, '20160405', '');

INSERT INTO versions VALUES
 ('slony22-pg96',   '2.2.5-2', 'linux64',               'http://slony.info',  1, '20160901', 'pg96');

INSERT INTO versions VALUES
 ('slony22-pg95',   '2.2.5-2', 'linux64',               'http://slony.info',  1, '20160616', 'pg95');
INSERT INTO versions VALUES
 ('slony22-pg95',   '2.2.5-1', 'linux64',               'http://slony.info',  0, '20160607', 'pg95');

INSERT INTO versions VALUES
 ('slony22-pg94',   '2.2.5-2', 'linux64',               'http://slony.info',  1, '20160616', 'pg94');
INSERT INTO versions VALUES
 ('slony22-pg94',   '2.2.5-1', 'linux64',               'http://slony.info',  0, '20160607', 'pg94');

INSERT INTO versions VALUES
 ('slony22-pg93',   '2.2.5-2', 'linux64',               'http://slony.info',  1, '20160616', 'pg93');
INSERT INTO versions VALUES
 ('slony22-pg93',   '2.2.5-1', 'linux64',               'http://slony.info',  0, '20160607', 'pg93');

INSERT INTO versions VALUES
 ('slony22-pg92',   '2.2.5-2', 'linux64',               'http://slony.info',  1, '20160616', 'pg92');
INSERT INTO versions VALUES
 ('slony22-pg92',   '2.2.5-1', 'linux64',               'http://slony.info',  0, '20160607', 'pg92');

INSERT INTO versions VALUES
 ('plprofiler3-pg96', '3.0-1', 'linux64, osx64, win64', 'https://bitbucket.org/openscg/plprofiler',  1, '20161008', 'pg96');
INSERT INTO versions VALUES
 ('plprofiler3-pg95', '3.0-1', 'linux64, osx64, win64', 'https://bitbucket.org/openscg/plprofiler',  1, '20161008', 'pg95');

INSERT INTO versions VALUES
 ('cassandra_fdw3-pg95', '3.0.0-1', 'linux64, osx64, win64', 'http://cassandrafdw.org',  1, '20160603', 'pg95');

INSERT INTO versions VALUES
 ('hadoop_fdw2-pg96', '2.5.0-1', 'linux64, osx64, win64', 'http://hadoopfdw.org',  1, '20160901', 'pg96');
INSERT INTO versions VALUES
 ('hadoop_fdw2-pg95', '2.5.0-1', 'linux64, osx64, win64', 'http://hadoopfdw.org',  1, '20160701', 'pg95');
INSERT INTO versions VALUES
 ('hadoop_fdw2-pg94', '2.5.0-1', 'linux64, osx64, win64', 'http://hadoopfdw.org',  1, '20160701', 'pg94');

INSERT INTO versions VALUES
 ('hadoop_fdw2-pg95', '2.1.0-1', 'linux64, osx64, win64', 'http://hadoopfdw.org',  0, '20160603', 'pg95');
INSERT INTO versions VALUES
 ('hadoop_fdw2-pg94', '2.1.0-1', 'linux64, osx64, win64', 'http://hadoopfdw.org',  0, '20160603', 'pg94');

INSERT INTO versions VALUES
  ('oracle_fdw1-pg96', '1.5.0-1', 'linux64, win64', 'https://github.com/laurenz/oracle_fdw',  1, '20160901', 'pg96');
INSERT INTO versions VALUES
  ('oracle_fdw1-pg95', '1.5.0-1', 'linux64, win64', 'https://github.com/laurenz/oracle_fdw',  1, '20160901', 'pg95');

INSERT INTO versions VALUES
  ('oracle_fdw1-pg95', '1.4.0-1', 'linux64, win64', 'https://github.com/laurenz/oracle_fdw',  0, '20160701', 'pg95');
INSERT INTO versions VALUES
  ('oracle_fdw1-pg94', '1.4.0-1', 'linux64, win64', 'https://github.com/laurenz/oracle_fdw',  1, '20160701', 'pg94');
INSERT INTO versions VALUES
  ('oracle_fdw1-pg93', '1.4.0-1', 'linux64, win64', 'https://github.com/laurenz/oracle_fdw',  1, '20160701', 'pg93');
INSERT INTO versions VALUES
  ('oracle_fdw1-pg92', '1.4.0-1', 'linux64, win64', 'https://github.com/laurenz/oracle_fdw',  1, '20160701', 'pg92');

INSERT INTO versions VALUES
  ('mysql_fdw2-pg95', '2.1.2-1', 'linux64', 'https://github.com/EnterpriseDB/mysql_fdw',  1, '20160701', 'pg95');
INSERT INTO versions VALUES
  ('mysql_fdw2-pg94', '2.1.2-1', 'linux64', 'https://github.com/EnterpriseDB/mysql_fdw',  1, '20160701', 'pg94');
INSERT INTO versions VALUES
  ('mysql_fdw2-pg93', '2.1.2-1', 'linux64', 'https://github.com/EnterpriseDB/mysql_fdw',  1, '20160701', 'pg93');

INSERT INTO versions VALUES
  ('tds_fdw1-pg95', '1.0.7-1', 'linux64, win64', 'https://github.com/tds-fdw/tds_fdw',  1, '20160701', 'pg95');
INSERT INTO versions VALUES
  ('tds_fdw1-pg94', '1.0.7-1', 'linux64, win64', 'https://github.com/tds-fdw/tds_fdw',  1, '20160701', 'pg94');
INSERT INTO versions VALUES
  ('tds_fdw1-pg93', '1.0.7-1', 'linux64, win64', 'https://github.com/tds-fdw/tds_fdw',  1, '20160701', 'pg93');
INSERT INTO versions VALUES
  ('tds_fdw1-pg92', '1.0.7-1', 'linux64, win64', 'https://github.com/tds-fdw/tds_fdw',  1, '20160701', 'pg92');

INSERT INTO versions VALUES
  ('orafce3-pg96', '3.3.1-1', 'linux64, osx64, win64', 'https://github.com/orafce/orafce',  1, '20160923', 'pg96');
INSERT INTO versions VALUES
  ('orafce3-pg95', '3.3.1-1', 'linux64, osx64, win64', 'https://github.com/orafce/orafce',  1, '20160923', 'pg95');
INSERT INTO versions VALUES
  ('orafce3-pg94', '3.3.1-1', 'linux64, osx64, win64', 'https://github.com/orafce/orafce',  1, '20160923', 'pg94');
INSERT INTO versions VALUES
  ('orafce3-pg93', '3.3.1-1', 'linux64, osx64, win64', 'https://github.com/orafce/orafce',  1, '20160923', 'pg93');
INSERT INTO versions VALUES
  ('orafce3-pg92', '3.3.1-1', 'linux64, osx64, win64', 'https://github.com/orafce/orafce',  1, '20160923', 'pg92');

INSERT INTO versions VALUES
  ('orafce3-pg96', '3.3.0-1', 'linux64, osx64, win64', 'https://github.com/orafce/orafce',  0, '20160901', 'pg96');
INSERT INTO versions VALUES
  ('orafce3-pg95', '3.3.0-1', 'linux64, osx64, win64', 'https://github.com/orafce/orafce',  0, '20160701', 'pg95');
INSERT INTO versions VALUES
  ('orafce3-pg94', '3.3.0-1', 'linux64, osx64, win64', 'https://github.com/orafce/orafce',  0, '20160701', 'pg94');
INSERT INTO versions VALUES
  ('orafce3-pg93', '3.3.0-1', 'linux64, osx64, win64', 'https://github.com/orafce/orafce',  0, '20160701', 'pg93');
INSERT INTO versions VALUES
  ('orafce3-pg92', '3.3.0-1', 'linux64, osx64, win64', 'https://github.com/orafce/orafce',  0, '20160701', 'pg92');

INSERT INTO versions VALUES
  ('plv814-pg96', '1.4.8-1', 'linux64', 'https://github.com/plv8/plv8',  1, '20160901', 'pg96');
INSERT INTO versions VALUES
  ('plv814-pg95', '1.4.8-1', 'linux64', 'https://github.com/plv8/plv8',  1, '20160701', 'pg95');
INSERT INTO versions VALUES
  ('plv814-pg94', '1.4.8-1', 'linux64', 'https://github.com/plv8/plv8',  1, '20160701', 'pg94');
INSERT INTO versions VALUES
  ('plv814-pg93', '1.4.8-1', 'linux64', 'https://github.com/plv8/plv8',  1, '20160701', 'pg93');
INSERT INTO versions VALUES
  ('plv814-pg92', '1.4.8-1', 'linux64', 'https://github.com/plv8/plv8',  1, '20160701', 'pg92');

INSERT INTO versions VALUES
  ('plv815-pg95', '1.5.3-1', 'osx64', 'https://github.com/plv8/plv8',  1, '20160701', 'pg95');
INSERT INTO versions VALUES
  ('plv815-pg94', '1.5.3-1', 'osx64', 'https://github.com/plv8/plv8',  1, '20160701', 'pg94');
INSERT INTO versions VALUES
  ('plv815-pg93', '1.5.3-1', 'osx64', 'https://github.com/plv8/plv8',  1, '20160701', 'pg93');
INSERT INTO versions VALUES
  ('plv815-pg92', '1.5.3-1', 'osx64', 'https://github.com/plv8/plv8',  1, '20160701', 'pg92');

INSERT INTO versions VALUES
  ('pljava15-pg95', '1.5.0-1', 'linux64, osx64, win64', 'https://github.com/tada/pljava',  1, '20160701', 'pg95');
INSERT INTO versions VALUES
  ('pljava15-pg94', '1.5.0-1', 'linux64, osx64, win64', 'https://github.com/tada/pljava',  1, '20160701', 'pg94');
INSERT INTO versions VALUES
  ('pljava15-pg93', '1.5.0-1', 'linux64, osx64, win64', 'https://github.com/tada/pljava',  1, '20160701', 'pg93');
INSERT INTO versions VALUES
  ('pljava15-pg92', '1.5.0-1', 'linux64, osx64, win64', 'https://github.com/tada/pljava',  1, '20160701', 'pg92');

INSERT INTO versions VALUES
  ('pgtsql9-pg95', '9.5-1', 'linux64, osx64, win64', 'https://bitbucket.org/openscg/pgtsql',  1, '20160701', 'pg95');
INSERT INTO versions VALUES
  ('pgtsql9-pg94', '9.5-1', 'linux64, osx64, win64', 'https://bitbucket.org/openscg/pgtsql',  1, '20160701', 'pg94');

INSERT INTO versions VALUES
 ('postgis23-pg96', '2.3.0-1', 'linux64, osx64, win64', 'http://postgis.net', 1, '20161008', 'pg96');
INSERT INTO versions VALUES
 ('postgis23-pg95', '2.3.0-1', 'linux64, osx64, win64', 'http://postgis.net', 1, '20161008', 'pg95');

INSERT INTO versions VALUES
 ('postgis22-pg96', '2.2.3-1', 'linux64, osx64, win64', 'http://postgis.net', 1, '20161027', 'pg96');
INSERT INTO versions VALUES
 ('postgis22-pg96', '2.2.2-2', 'linux64, osx64, win64', 'http://postgis.net', 0, '20160901', 'pg96');
INSERT INTO versions VALUES
 ('postgis22-pg95', '2.2.3-1', 'linux64, osx64, win64', 'http://postgis.net', 1, '20161027', 'pg95');
INSERT INTO versions VALUES
 ('postgis22-pg95', '2.2.2-2', 'linux64, osx64, win64', 'http://postgis.net', 0, '20160607', 'pg95');
INSERT INTO versions VALUES
 ('postgis22-pg94', '2.2.3-1', 'linux64, osx64, win64', 'http://postgis.net', 1, '20161027', 'pg94');
INSERT INTO versions VALUES
 ('postgis22-pg94', '2.2.2-2', 'linux64, osx64, win64', 'http://postgis.net', 0, '20160607', 'pg94');
INSERT INTO versions VALUES
 ('postgis22-pg93', '2.2.3-1', 'linux64, osx64, win64', 'http://postgis.net', 1, '20161027', 'pg93');
INSERT INTO versions VALUES
 ('postgis22-pg93', '2.2.2-2', 'linux64, osx64, win64', 'http://postgis.net', 0, '20160607', 'pg93');
INSERT INTO versions VALUES
 ('postgis22-pg92', '2.2.3-1', 'linux64, osx64, win64', 'http://postgis.net', 1, '20161027', 'pg92');
INSERT INTO versions VALUES
 ('postgis22-pg92', '2.2.2-2', 'linux64, osx64, win64', 'http://postgis.net', 0, '20160607', 'pg92');
INSERT INTO versions VALUES
 ('postgis22-pg95', '2.2.2', 'linux64, osx64, win64', 'http://postgis.net', 0, '20160512', 'pg95');
INSERT INTO versions VALUES
 ('postgis22-pg94', '2.2.2', 'linux64, osx64, win64', 'http://postgis.net', 0, '20160512', 'pg94');
INSERT INTO versions VALUES
 ('postgis22-pg93', '2.2.2', 'linux64, osx64, win64', 'http://postgis.net', 0, '20160512', 'pg93');
INSERT INTO versions VALUES
 ('postgis22-pg92', '2.2.2', 'linux64, osx64, win64', 'http://postgis.net', 0, '20160512', 'pg92');

INSERT INTO versions VALUES
 ('pg96', '9.6.1-1','linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6-1html', 1, '20161027', '');
INSERT INTO versions VALUES
 ('pg96', '9.6.0-1b','linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6-0.html', 0, '20161020', '');
INSERT INTO versions VALUES
 ('pg96', '9.6.0-1', 'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6-0.html', 0, '20160929', '');
INSERT INTO versions VALUES
 ('pg96', '9.6rc1-1a','linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6rc1.html', 0, '20160915', '');
INSERT INTO versions VALUES
 ('pg96', '9.6beta4-2','linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6beta4.html', 0, '20160818', '');
INSERT INTO versions VALUES
 ('pg96', '9.6beta4-1','linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6beta4.html', 0, '20160811', '');
INSERT INTO versions VALUES
 ('pg96', '9.6beta3-1a','linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6beta3.html', 0, '20160811', '');
INSERT INTO versions VALUES
 ('pg96', '9.6beta3-1','linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6beta3.html', 0, '20160721', '');
INSERT INTO versions VALUES
 ('pg96', '9.6beta2-5','linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6beta2.html', 0, '20160701', '');
INSERT INTO versions VALUES
 ('pg96', '9.6beta2-1','linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6beta2.html', 0, '20160623', '');
INSERT INTO versions VALUES
 ('pg96', '9.6beta1-4a','linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6beta1.html', 0, '20160616', '');
INSERT INTO versions VALUES
 ('pg96', '9.6beta1-4', 'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6beta1.html', 0, '20160603', '');
INSERT INTO versions VALUES
 ('pg96', '9.6beta1-3', 'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6beta1.html', 0, '20160523', '');
INSERT INTO versions VALUES
 ('pg96', '9.6beta1-2', 'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6beta1.html', 0, '20160512', '');
INSERT INTO versions VALUES
 ('pg96', '9.6beta1-1', 'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.6/static/release-9-6beta1.html', 0, '20160512', '');

INSERT INTO versions VALUES
 ('pg95', '9.5.5-1',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.5/static/release-9-5-5.html', 1, '20161027', '');
INSERT INTO versions VALUES
 ('pg95', '9.5.4-2a',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.5/static/release-9-5-4.html', 0, '20160915', '');
INSERT INTO versions VALUES
 ('pg95', '9.5.4-2',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.5/static/release-9-5-4.html', 0, '20160818', '');
INSERT INTO versions VALUES
 ('pg95', '9.5.4-1',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.5/static/release-9-5-4.html', 0, '20160811', '');
INSERT INTO versions VALUES
 ('pg95', '9.5.3-5',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.5/static/release-9-5-3.html', 0, '20160701', '');
INSERT INTO versions VALUES
 ('pg95', '9.5.3-4a',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.5/static/release-9-5-3.html', 0, '20160616', '');
INSERT INTO versions VALUES
 ('pg95', '9.5.3-4',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.5/static/release-9-5-3.html', 0, '20160603', '');
INSERT INTO versions VALUES
 ('pg95', '9.5.3-3',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.5/static/release-9-5-3.html', 0, '20160523', '');
INSERT INTO versions VALUES
 ('pg95', '9.5.3-2',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.5/static/release-9-5-3.html', 0, '20160512', '');
INSERT INTO versions VALUES
 ('pg95', '9.5.3-1',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.5/static/release-9-5-3.html', 0, '20160512', '');
INSERT INTO versions VALUES
 ('pg95', '9.5.2-2',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.5/static/release-9-5-2.html', 0, '20160415', '');
INSERT INTO versions VALUES
 ('pg95', '9.5.2-1',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.5/static/release-9-5-2.html', 0, '20160331', '');
INSERT INTO versions VALUES
 ('pg95', '9.5.1-3',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.5/static/release-9-5-1.html', 0, '20160328', '');

INSERT INTO versions VALUES
 ('pg94', '9.4.10-1',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.4/static/release-9-4-10.html', 1, '20161027', '');
INSERT INTO versions VALUES
 ('pg94', '9.4.9-2a',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.4/static/release-9-4-9.html', 0, '20160915', '');
INSERT INTO versions VALUES
 ('pg94', '9.4.9-2',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.4/static/release-9-4-9.html', 0, '20160818', '');
INSERT INTO versions VALUES
 ('pg94', '9.4.9-1',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.4/static/release-9-4-9.html', 0, '20160811', '');
INSERT INTO versions VALUES
 ('pg94', '9.4.8-5',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.4/static/release-9-4-8.html', 0, '20160701', '');
INSERT INTO versions VALUES
 ('pg94', '9.4.8-4a',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.4/static/release-9-4-8.html', 0, '20160616', '');
INSERT INTO versions VALUES
 ('pg94', '9.4.8-4',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.4/static/release-9-4-8.html', 0, '20160603', '');
INSERT INTO versions VALUES
 ('pg94', '9.4.8-3',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.4/static/release-9-4-8.html', 0, '20160523', '');
INSERT INTO versions VALUES
 ('pg94', '9.4.8-2',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.4/static/release-9-4-8.html', 0, '20160512', '');
INSERT INTO versions VALUES
 ('pg94', '9.4.8-1',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.4/static/release-9-4-8.html', 0, '20160512', '');
INSERT INTO versions VALUES
 ('pg94', '9.4.7-2',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.4/static/release-9-4-7.html', 0, '20160415', '');
INSERT INTO versions VALUES
 ('pg94', '9.4.7-1',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.4/static/release-9-4-7.html', 0, '20160331', '');
INSERT INTO versions VALUES
 ('pg94', '9.4.6-3',    'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.4/static/release-9-4-6.html', 0, '20160328', '');

INSERT INTO versions VALUES
 ('pg93', '9.3.15-1',  'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.3/static/release-9-3-15.html', 1, '20161027', '');
INSERT INTO versions VALUES
 ('pg93', '9.3.14-2a',  'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.3/static/release-9-3-14.html', 0, '20160915', '');
INSERT INTO versions VALUES
 ('pg93', '9.3.14-2',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.3/static/release-9-3-14.html', 0, '20160818', '');
INSERT INTO versions VALUES
 ('pg93', '9.3.14-1',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.3/static/release-9-3-14.html', 0, '20160811', '');
INSERT INTO versions VALUES
 ('pg93', '9.3.13-5',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.3/static/release-9-3-13.html', 0, '20160701', '');
INSERT INTO versions VALUES
 ('pg93', '9.3.13-4a',  'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.3/static/release-9-3-13.html', 0, '20160616', '');
INSERT INTO versions VALUES
 ('pg93', '9.3.13-4',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.3/static/release-9-3-13.html', 0, '20160603', '');
INSERT INTO versions VALUES
 ('pg93', '9.3.13-3',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.3/static/release-9-3-13.html', 0, '20160523', '');
INSERT INTO versions VALUES
 ('pg93', '9.3.13-2',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.3/static/release-9-3-13.html', 0, '20160512', '');
INSERT INTO versions VALUES
 ('pg93', '9.3.13-1',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.3/static/release-9-3-13.html', 0, '20160512', '');
INSERT INTO versions VALUES
 ('pg93', '9.3.12-2',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.3/static/release-9-3-12.html', 0, '20160415', '');
INSERT INTO versions VALUES
 ('pg93', '9.3.12-1',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.3/static/release-9-3-12.html', 0, '20160331', '');
INSERT INTO versions VALUES
 ('pg93', '9.3.11-3',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.3/static/release-9-3-11.html', 0, '20160328', '');

INSERT INTO versions VALUES
 ('pg92', '9.2.19-1',  'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.2/static/release-9-2-19.html', 1, '20161027', '');
INSERT INTO versions VALUES
 ('pg92', '9.2.18-2a',  'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.2/static/release-9-2-18.html', 0, '20160915', '');
INSERT INTO versions VALUES
 ('pg92', '9.2.18-2',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.2/static/release-9-2-18.html', 0, '20160818', '');
INSERT INTO versions VALUES
 ('pg92', '9.2.18-1',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.2/static/release-9-2-18.html', 0, '20160811', '');
INSERT INTO versions VALUES
 ('pg92', '9.2.17-5',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.2/static/release-9-2-17.html', 0, '20160701', '');
INSERT INTO versions VALUES
 ('pg92', '9.2.17-4a',  'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.2/static/release-9-2-17.html', 0, '20160616', '');
INSERT INTO versions VALUES
 ('pg92', '9.2.17-4',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.2/static/release-9-2-17.html', 0, '20160603', '');
INSERT INTO versions VALUES
 ('pg92', '9.2.17-3',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.2/static/release-9-2-17.html', 0, '20160523', '');
INSERT INTO versions VALUES
 ('pg92', '9.2.17-2',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.2/static/release-9-2-17.html', 0, '20160512', '');
INSERT INTO versions VALUES
 ('pg92', '9.2.17-1',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.2/static/release-9-2-17.html', 0, '20160512', '');
INSERT INTO versions VALUES
 ('pg92', '9.2.16-2',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.2/static/release-9-2-16.html', 0, '20160415', '');
INSERT INTO versions VALUES
 ('pg92', '9.2.16-1',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.2/static/release-9-2-16.html', 0, '20160331', '');
INSERT INTO versions VALUES
 ('pg92', '9.2.15-3',   'linux64, osx64, win64', 'http://www.postgresql.org/docs/9.2/static/release-9-2-15.html', 0, '20160328', '');

INSERT INTO versions VALUES
 ('python2',    '2.7.11-4',    'win64',  'https://docs.python.org/2.7/whatsnew/2.7.html', 1, '20160118', '');
INSERT INTO versions VALUES
 ('python2',    '2.7.12-1',    'win64',  'https://docs.python.org/2.7/whatsnew/2.7.html', 0, '20161020', '');

INSERT INTO versions VALUES
 ('perl5',      '5.20.3.3',     'win64',  'http://perldoc.perl.org/5.20.2/index.html', 1, '20160314', '');

INSERT INTO versions VALUES
 ('tcl86',      '8.6.4-1',     'win64',    'http://tcl.tk/doc/', 1, '20160311', '');

INSERT INTO versions VALUES
 ('java8',      '8u92',         'linux64, osx64, win64', 'http://www.oracle.com/technetwork/java/javase/8u92-relnotes-2949471.html', 1, '20160701', '');
INSERT INTO versions VALUES
 ('java8',      '8u74',         'linux64, osx64, win64', 'http://www.oracle.com/technetwork/java/javase/8u74-relnotes-2879024.html', 0, '20160314', '');

INSERT INTO versions VALUES
 ('birt',       '4.5.0',        'linux64, osx64, win64', 'http://projects.eclipse.org/projects/birt', 1, '20160512', '');

INSERT INTO versions VALUES
 ('pgha2',     '2.1b',         '',               '', 1, '20151217', '');

INSERT INTO versions VALUES
 ('pgadmin3',   '1.23.0a',   'win64, osx64',     '', 1, '20161020', '');
INSERT INTO versions VALUES
 ('pgadmin3',   '1.22.1',    'win64, osx64',     '', 0, '20160314', '');

INSERT INTO versions VALUES
 ('pgadmin4',   '1.0',       'win64, osx64',     '', 1, '20161008', '');
INSERT INTO versions VALUES
 ('pgadmin4',   '1.0rc1',    'win64, osx64',     '', 0, '20160903', '');

INSERT INTO versions VALUES
 ('pgstudio2',  '2.0.1-2',        '',       '', 1, '20160323', '');

INSERT INTO versions VALUES
 ('ora2pg',     '17.5',         '',     'http://ora2pg.darold.net/news.html', 1, '20161027', '');
INSERT INTO versions VALUES
 ('ora2pg',     '17.4',         '',     'http://ora2pg.darold.net/news.html', 0, '20160512', '');
INSERT INTO versions VALUES
 ('ora2pg',     '17.3',         '',     'http://ora2pg.darold.net/news.html', 0, '20160326', '');

INSERT INTO versions VALUES
 ('pgbouncer17',  '1.7.2-1a',   'linux64', '', 1, '20161008', '');
INSERT INTO versions VALUES
 ('pgbouncer17',  '1.7.2-1',    'linux64', '', 0, '20160412', '');

INSERT INTO versions VALUES
 ('consul',       '0.6.4',      'linux64, osx64, win64', '', 1, '20160320', '');

INSERT INTO versions VALUES
 ('pgbadger',   '9.0',          '',             '', 1, '20160903', '');
INSERT INTO versions VALUES
 ('pgbadger',   '8.3',          '',             '', 0, '20160903', '');
INSERT INTO versions VALUES
 ('pgbadger',   '8.2',          '',             '', 0, '20160811', '');
INSERT INTO versions VALUES
 ('pgbadger',   '8.1',          '',             '', 0, '20160512', '');
INSERT INTO versions VALUES
 ('pgbadger',   '8.0',          '',             '', 0, '20160228', '');

INSERT INTO versions VALUES
 ('backrest',   '1.09',         '',             '', 1, '20161020', '');
INSERT INTO versions VALUES
 ('backrest',   '1.08',         '',             '', 0, '20160923', '');
INSERT INTO versions VALUES
 ('backrest',   '1.06',         '',             '', 0, '20160903', '');
INSERT INTO versions VALUES
 ('backrest',   '1.05',         '',             '', 0, '20160811', '');
INSERT INTO versions VALUES
 ('backrest',   '1.03',         '',             '', 0, '20160705', '');
INSERT INTO versions VALUES
 ('backrest',   '1.02',         '',             '', 0, '20160603', '');
INSERT INTO versions VALUES
 ('backrest',   '1.01',         '',             '', 0, '20160523', '');
INSERT INTO versions VALUES
 ('backrest',   '1.00',         '',             '', 0, '20160512', '');
INSERT INTO versions VALUES
 ('backrest',   '0.92',         '',             '', 0, '20160412', '');
INSERT INTO versions VALUES
 ('backrest',   '0.91',         '',             '', 0, '20160326', '');

INSERT INTO versions VALUES
 ('cassandra30',  '3.0.8',      '',             '', 1, '20160901', '');
INSERT INTO versions VALUES
 ('cassandra30',  '3.0.6',      '',             '', 0, '20160616', '');
INSERT INTO versions VALUES
 ('cassandra30',  '3.0.4',      '',             '', 0, '20160314', '');

INSERT INTO versions VALUES
 ('tomcat8',      '8.5.4',      '',             '', 1, '20160901', '');
INSERT INTO versions VALUES
 ('tomcat8',      '8.0.35',     '',             '', 0, '20160616', '');
INSERT INTO versions VALUES
 ('tomcat8',      '8.0.33',     '',             '', 0, '20160330', '');

INSERT INTO versions VALUES
 ('spark16',  '1.6.1',          '',             '', 1, '20160316', '');

INSERT INTO versions VALUES
 ('hadoop26',  '2.6.4',         '',             '', 1, '20160214', '');

INSERT INTO versions VALUES
 ('hive2',  '2.0.1',            '',             '', 1, '20160616', '');
INSERT INTO versions VALUES
 ('hive2',  '2.0.0',            '',             '', 0, '20160316', '');

INSERT INTO versions VALUES
 ('zookeeper34',  '3.4.8',      '',             '', 1, '20160330', '');
