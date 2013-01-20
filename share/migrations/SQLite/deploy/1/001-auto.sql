-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Thu Jan 17 21:11:20 2013
-- 

;
BEGIN TRANSACTION;
--
-- Table: editions
--
CREATE TABLE editions (
  edition_id INTEGER PRIMARY KEY NOT NULL,
  title varchar(200) NOT NULL,
  edition_date date NOT NULL,
  header text,
  footer text
);
--
-- Table: section_types
--
CREATE TABLE section_types (
  edition_type_id INTEGER PRIMARY KEY NOT NULL,
  label varchar(80) NOT NULL
);
CREATE UNIQUE INDEX label_unique ON section_types (label);
--
-- Table: tags
--
CREATE TABLE tags (
  tag_id INTEGER PRIMARY KEY NOT NULL,
  label varchar(80) NOT NULL
);
CREATE UNIQUE INDEX unique_label ON tags (label);
--
-- Table: edition_sections
--
CREATE TABLE edition_sections (
  edition_section_id INTEGER PRIMARY KEY NOT NULL,
  edition_id int NOT NULL,
  section_type_id int NOT NULL,
  header text,
  rank int NOT NULL DEFAULT 50,
  FOREIGN KEY (edition_id) REFERENCES editions(edition_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (section_type_id) REFERENCES section_types(edition_type_id)
);
CREATE INDEX edition_sections_idx_edition_id ON edition_sections (edition_id);
CREATE INDEX edition_sections_idx_section_type_id ON edition_sections (section_type_id);
--
-- Table: articles
--
CREATE TABLE articles (
  article_id INTEGER PRIMARY KEY NOT NULL,
  title varchar(200) NOT NULL,
  url varchar(200) NOT NULL,
  publication_date date,
  description text,
  bitly_url varchar(200),
  edition_section_id int,
  FOREIGN KEY (edition_section_id) REFERENCES edition_sections(edition_section_id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX articles_idx_edition_section_id ON articles (edition_section_id);
--
-- Table: article_tags
--
CREATE TABLE article_tags (
  article_tag_id INTEGER PRIMARY KEY NOT NULL,
  article_id int NOT NULL,
  tag_id int NOT NULL,
  FOREIGN KEY (article_id) REFERENCES articles(article_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
);
CREATE INDEX article_tags_idx_article_id ON article_tags (article_id);
CREATE INDEX article_tags_idx_tag_id ON article_tags (tag_id);
COMMIT;
