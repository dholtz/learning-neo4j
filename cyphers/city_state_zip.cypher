using periodic commit 10000

fieldterminator ','
with head(line) as charId, tail(line) as rels
MATCH (from:Character {characterId:toInt(charId)})
unwind rels as otherCharId
MATCH (to:Character {characterId:toInt(otherCharId)})
CREATE (from)-[:STARRED_WITH]->(to);


using periodic commit 10000
load csv with headers from "https://raw.githubusercontent.com/dholtz/learning-neo4j/master/us_city_state_zip.csv" as line
fieldterminator ','
merge (:State {
  abbr: line.state
  });

create index on :State(abbr);


using periodic commit 10000
load csv with headers from "https://raw.githubusercontent.com/dholtz/learning-neo4j/master/us_city_state_zip.csv" as line
fieldterminator ','
merge (:County {
  name: line.county_name
  });

create index on :County(name);

using periodic commit 10000
load csv with headers from "https://raw.githubusercontent.com/dholtz/learning-neo4j/master/us_city_state_zip.csv" as line
fieldterminator ','
merge (:City {
  name: line.city
  });

create index on :City(name);



using periodic commit 10000
load csv with headers from "https://raw.githubusercontent.com/dholtz/learning-neo4j/master/us_city_state_zip.csv" as line
fieldterminator ','
merge (:ZipCode {
  zip: line.zip
  });

create index on :ZipCode(zip);
