## Run this script to tweet random quotes paired with
## random famous people from the account @quotemashup

## initialize connection to twitter app
library(twitteR)
consumer_key = "bN9YECN3sRJf0dCdFWG9onDfZ"
consumer_secret = "l51RWtguP12wafAPErfF3fXX7IHI7sdBKpCCIRGnaW1N6lrxDL"
access_token = "740480621319991297-K13XcAFIIzZ1S3hdY8Wv1st2lEPocYt"
access_secret = "aAl81qPhFdadxrGfgNuugzWzk52583ExhUUPgYXWPIUDd"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

library(rvest)
library(stringr)
# reads a list of famous people and cleans it up so just their name is in final list
famous_people <- read_html("http://www.biographyonline.net/people/famous-100.html")
famous_people.ol <- famous_people %>% html_nodes(css = "#p6641 > section > ol:nth-child(2)")
famous_people.li <- html_children(famous_people.ol)
famous_people.text <- html_text(famous_people.li)
just_names <- sub("\\(.*", "", famous_people.text)

# reads in famous quotes and cleans it to get it to its most concise form
famous_quotes <- read_html("http://www.cs.virginia.edu/~robins/quotes.html")
quotes <- famous_quotes %>% html_nodes(css = "body > dt:nth-child(n)") %>% html_text
quotes.clean <- str_replace_all(quotes, "\"", "")
quotes.cleaner <- str_replace_all(quotes.clean, "\n", "")
quotes.cleanest <- str_replace_all(quotes.cleaner, "\t", "")
noquote_quotes <- noquote(quotes.cleanest)
trim.trailing <- function (x) sub("\\s+$", "", x)
quotes <- trim.trailing(noquote_quotes)
quotes <- gsub("\\s+", " ", quotes)

# returns a randomly chosen tweet and matches it with a randomly chosen famous person
message <- str_trim(str_c(sample(quotes, 1), " - ", sample(just_names, 1)))

## Switch out these two lines depening on if we want a picture
tweet(message)
##tweet(message, mediaPath = '/Users/William/Desktop/filename')

quit(save = "no")
