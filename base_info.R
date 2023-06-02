


league <-
  list(
    DRAKE = structure(
      list(
        artist = c("VRSS", "Arcy Drive",
                   "DNL", "Keiran Ivy", "KHI INFINITE"),
        artist_code = c(
          "1o963gG7zP39nwOenqzPg2",
          "7o1TBmx7Ube5h2Czlam84O",
          "7aXH52JKx39Q5PprJmFxXu",
          "0wzHzFNLOLex8psv09KqNK",
          "6wthNkb9tOcsMdNtrHI5vs"
        ),
        baseline = c(1690, 141332, 10323,
                     23428, 426971)
      ),
      class = "data.frame",
      row.names = c(NA,-5L)
    ),
    GUT = structure(
      list(
        artist = c("BXB LOVE", "Mike Sabbath",
                   "Louis Millne", "Ogi", "Mochakk"),
        artist_code = c(
          "03k90jclqTrew2X2DFnRCC",
          "3UTCjjwxYJioyA39EX6ciu",
          "6oVWsUniV39LusFsC7axlb",
          "60nDKjd690Luygtd3Fm0Cu",
          "0rTh1tAdrEbdKZBTiiAQSo"
        ),
        baseline = c(1051, 177982, 129320,
                     227880, 826429)
      ),
      class = "data.frame",
      row.names = c(NA,-5L)
    ),
    GRAHAM = structure(
      list(
        artist = c(
          "BBiche",
          "Theo Kandel",
          "Anna Bates",
          "Peark & The Oysters",
          "Zinadelphia"
        ),
        artist_code = c(
          "1m0M7J2El2DioTfule3L41",
          "0YEY41EVT9qE1IdDDDyF9q",
          "4JLqUtfyFvInfcLILCOIJx",
          "7ovvjgqrTeuMxbzIykUqDs",
          "2bTnGGWvuVQsMVyg31rmum"
        ),
        baseline = c(8774, 68423, 172806,
                     164653, 522497)
      ),
      class = "data.frame",
      row.names = c(NA,-5L)
    ),
    LIAM = structure(
      list(
        artist = c("Nico Champagne",
                   "Wa-FU", "HIGGO", "Semma Sole", "PCRC"),
        artist_code = c(
          "3aSb1wUqNgbzj9VTgYBhjY",
          "51miQgR4HHTo5kOwFCeyJo",
          "0f1qSxprIDtLaJfIaEJb64",
          "6bKkC8yidNL8j94vKjLysJ",
          "41Nu7NgAj9rJxjj7JDuXrV"
        ),
        baseline = c(353, 81884, 162736,
                     12793, 360087)
      ),
      class = "data.frame",
      row.names = c(NA,-5L)
    ),
    FELD = structure(
      list(
        artist = c("Cinya Khan",
                   "Flaujae", "Daoud", "YPC Nige", "jamesjamesjames"),
        artist_code = c(
          "7nv9u1rH0xrKytpgKfDKfz",
          "5IQcgEvxwvq8kwy4iWCiBC",
          "3e76yvk1gLZQhKZiUHkMsP",
          "13crAKmlVhj6yzOO9fuOmF",
          "0DqR5aQYPz1s2M3YbycLMJ"
        ),
        baseline = c(2745, 124864, 33168,
                     30521, 630692)
      ),
      class = "data.frame",
      row.names = c(NA,-5L)
    ),
    HOCH = structure(
      list(
        artist = c(
          "semiratuth",
          "Emanuel Satie",
          "MELT",
          "Murphys Law",
          "Ray Vaughan"
        ),
        artist_code = c(
          "6vjKiruwh9k8dDi1rYvI82",
          "3veg7sFGWTk62Ecwj6mzij",
          "0G7KI9I5BApiXc5Sqpyil9",
          "1q85MRE0aEF6NfZQdlMrl1",
          "4yYYCSCDUTypErQMZv5iSg"
        ),
        baseline = c(1248, 97818, 140738,
                     92716, 335847)
      ),
      class = "data.frame",
      row.names = c(NA,-5L)
    ),
    TRUES = structure(
      list(
        artist = c("Gibs", "DJ Chus",
                   "Crackazat", "Tiny Habits", "Mall Grab"),
        artist_code = c(
          "6UEqUjzkCgVcEgJ5avKeFv",
          "7kxOVclB0zQamtBR0syCrg",
          "2PagBkTVHoKFjuxtCJp3As",
          "2QYdqWGgRorVkA8cJMMdrn",
          "7yF6JnFPDzgml2Ytkyl5D7"
        ),
        baseline = c(4774, 248524, 211869,
                     195807, 780378)
      ),
      class = "data.frame",
      row.names = c(NA,-5L)
    ),
    LAM = structure(
      list(
        artist = c(
          "Mel 4ever",
          "FKA MASH",
          "Remmy Quinn",
          "Ben Sterling",
          "Justin Jay"
        ),
        artist_code = c(
          "7e34iWed5vSXh7wAoejlOJ",
          "6tooLez7Cq2bgY60m3TJMq",
          "6OQoRzjz71ofDCQa5OTlfq",
          "79uJoLQkQ621xZy7MyH4uL",
          "5k5eiijuHxrGwXp2Pz37GZ"
        ),
        baseline = c(4925, 166838, 33814, 55276, 309695)
      ),
      class = "data.frame",
      row.names = c(NA,-5L)
    )
  )

save(league, file = "league_baseline.Rda")


