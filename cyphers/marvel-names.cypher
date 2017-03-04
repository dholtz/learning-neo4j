load csv from "https://raw.githubusercontent.com/dholtz/learning-neo4j/master/Marvel-names.txt" as line
fieldterminator ' '
create (:Character {
  characterId: toInt(line[0]),
  name: line[1]
  });

create index on :Character(characterId);
