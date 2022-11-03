Komento panimon luonnille:
```
brewery = Brewery.new name:"Brew Dog", year:2007
brewery.save
```
Komennot oluiden luonnille:
```
beer = Beer.new name:"Punk IPA", style: "IPA"
beer.save
beer = Beer,new name:"Nanny State", style:"lowalcohol"
beer.save
```

#<Beer:0x00007fe3b7714948
 id: 16,
 name: "Nanny State",
 style: "lowalcohol",
 brewery_id: 5,
 created_at: Sun, 16 Oct 2022 20:46:28.651362000 UTC +00:00,
 updated_at: Sun, 16 Oct 2022 20:46:28.651362000 UTC +00:00>
**irb(main):024:0> b = Beer.find_by name: "Punk IPA"**
  Beer Load (0.4ms)  SELECT "beers".* FROM "beers" WHERE "beers"."name" = ? LIMIT ?  [["name", "Punk IPA"], ["LIMIT", 1]]
#<Beer:0x00007fe3bccc5770
...
**irb(main):025:0> b.ratings.create score: 10**
  TRANSACTION (0.1ms)  begin transaction
  Rating Create (1.4ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 10], ["beer_id", 15], ["created_at", "2022-10-16 20:47:20.819424"], ["updated_at", "2022-10-16 20:47:20.819424"]]
  TRANSACTION (14.7ms)  commit transaction
=>
#<Rating:0x00007fe3bc087f80
 id: 4,
 score: 10,
 updated_at: Sun, 16 Oct 2022 20:47:26.198996000 UTC +00:00>
**irb(main):027:0> b.ratings.create score: 30**
  TRANSACTION (0.1ms)  begin transaction
  Rating Create (1.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["]
  TRANSACTION (14.5ms)  commit transaction
=>
#<Rating:0x00007fe3b7757928
 id: 6,
 score: 30,
 beer_id: 15,
 created_at: Sun, 16 Oct 2022 20:47:31.094785000 UTC +00:00,
 updated_at: Sun, 16 Oct 2022 20:47:31.094785000 UTC +00:00>
**irb(main):028:0> b = Beer.find_by name: "Nanny State"**
  Beer Load (0.2ms)  SELECT "beers".* FROM "beers" WHERE "beers"."name" = ? LIMIT ?  [["name", "Nanny State"], ["LIMIT", 1]]
#<Beer:0x00007fe3bc294828
...
**irb(main):029:0> b.ratings.create score: 15**
  TRANSACTION (0.1ms)  begin transaction
  Rating Create (1.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 15], ["beer_id", 16], ["created_at", "2022-10-16 20:47:50.508153"], ["updated_at", "2022-10-16 20:47:50.508153"]]
  TRANSACTION (15.0ms)  commit transaction
=>
#<Rating:0x00007fe3b7d07968
 id: 7,
 score: 15,
  Rating Create (1.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 25], ["beer_id", 16], ["created_at", "2022-10-16 20:47:57.445173"], ["updated_at", "2022-10-16 20:47:57.445173"]]
  TRANSACTION (16.0ms)  commit transaction
=>
**irb(main):030:0> b.ratings.create score: 25**
#<Rating:0x00007fe3b76e4018
 id: 9,
 score: 25,
 beer_id: 16,
 created_at: Sun, 16 Oct 2022 20:47:57.445173000 UTC +00:00,
 updated_at: Sun, 16 Oct 2022 20:47:57.445173000 UTC +00:00>
 
 (Konsolissa ei jostain syystä näkynyt enää kaikkia komentoja, joten osa tähän lisätty jälkeenpäin.)
