create index on :State(abbr);

using periodic commit 10000
load csv with headers from "https://raw.githubusercontent.com/dholtz/learning-neo4j/master/us_city_state_zip.csv" as line
fieldterminator ','
create (:State {
  abbr: line.state
  });


create index on :County(name);

using periodic commit 10000
load csv with headers from "https://raw.githubusercontent.com/dholtz/learning-neo4j/master/us_city_state_zip.csv" as line
fieldterminator ','
with line
where line.county_name is not null
create (c:County {
  name: line.county_name
  });


create index on :City(name);

using periodic commit 10000
load csv with headers from "https://raw.githubusercontent.com/dholtz/learning-neo4j/master/us_city_state_zip.csv" as line
fieldterminator ','
with line
where line.city is not null
create (:City {
  name: line.city
  });



create index on :ZipCode(zip);

using periodic commit 10000
load csv with headers from "https://raw.githubusercontent.com/dholtz/learning-neo4j/master/us_city_state_zip.csv" as line
fieldterminator ','
with line
where line.zip is not null
create (:ZipCode {
  zip: line.zip
  });



//https://en.wikipedia.org/wiki/County_(United_States)
using periodic commit 1000
load csv with headers from "https://raw.githubusercontent.com/dholtz/learning-neo4j/master/us_city_state_zip.csv" as line
fieldterminator ','
MATCH (c:County {name: line.county_name})
MATCH (s:State {abbr: line.state})
CREATE (c)-[:REGION_OF]->(s)
limit 1000;



// 
// Davids-iMac:logs davidholtzhouser$ tail -f debug.log
// 	at io.netty.util.concurrent.DefaultPromise.setFailure(DefaultPromise.java:120)
// 	at io.netty.channel.DefaultChannelPromise.setFailure(DefaultChannelPromise.java:87)
// 	at io.netty.channel.AbstractChannelHandlerContext.safeExecute(AbstractChannelHandlerContext.java:1021)
// 	at io.netty.channel.AbstractChannelHandlerContext.close(AbstractChannelHandlerContext.java:621)
// 	at io.netty.channel.AbstractChannelHandlerContext.close(AbstractChannelHandlerContext.java:476)
// 	at io.netty.channel.DefaultChannelPipeline.close(DefaultChannelPipeline.java:964)
// 	at io.netty.channel.AbstractChannel.close(AbstractChannel.java:234)
// 	at org.neo4j.bolt.v1.runtime.BoltStateMachine.close(BoltStateMachine.java:291)
// 	at org.neo4j.bolt.v1.runtime.concurrent.RunnableBoltWorker.run(RunnableBoltWorker.java:115)
// 	at java.lang.Thread.run(Thread.java:745)
//
//
//   java.lang.OutOfMemoryError: Java heap space
//   2017-03-10 14:45:44.272+0000 ERROR Fatal, worker for session '7917c345-633d-4b48-baaa-3ae0d0352526' crashed. Please contact your support representative if you are unable to resolve this. Java heap space
//   java.lang.OutOfMemoryError: Java heap space
//   2017-03-10 14:45:44.272+0000 WARN  Unexpected thread death: {} in {}
//   java.lang.OutOfMemoryError: Java heap space
//   Exception in thread "qtp514834046-439" java.lang.OutOfMemoryError: Java heap space
//   java.lang.OutOfMemoryError: Java heap space
//   2017-03-10 14:45:44.273+0000 WARN   Java heap space
//   java.lang.OutOfMemoryError: Java heap space
