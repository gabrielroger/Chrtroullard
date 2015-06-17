require "sqlite3"

db = SQLite3::Database.new "chartroullard.db"

rows = db.execute <<-SQL
  create table articles (
    id integer primary key,
    titre varchar(100),
    article text,
    rubrique int
  );
SQL