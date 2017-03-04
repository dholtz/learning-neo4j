using periodic commit 10000
load csv from "https://raw.githubusercontent.com/dholtz/learning-neo4j/master/Marvel-graph.txt" as line
fieldterminator ' '
with head(line) as charId, tail(line) as rels
MATCH (from:Character {characterId:toInt(charId)})
unwind rels as otherCharId
MATCH (to:Character {characterId:toInt(otherCharId)})
CREATE (from)-[:STARRED_WITH]->(to);
