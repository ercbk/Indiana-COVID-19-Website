# Post tweets with updated charts


# necessary for github actions
token_stuff_e <- Sys.getenv(c("APPNAMEE", "APIKEYE", "APISECRETE", "ACCESSTOKENE", "ACCESSSECRETE"))

rt_tok_e <- rtweet::create_token(
   app = token_stuff_e[[1]],
   consumer_key = token_stuff_e[[2]],
   consumer_secret = token_stuff_e[[3]],
   access_token = token_stuff_e[[4]],
   access_secret = token_stuff_e[[5]],
   set_renv = FALSE)

token_stuff_f <- Sys.getenv(c("APPNAMEF", "APIKEYF", "APISECRETF", "ACCESSTOKENF", "ACCESSSECRETF"))

rt_tok_f <- rtweet::create_token(
   app = token_stuff_f[[1]],
   consumer_key = token_stuff_f[[2]],
   consumer_secret = token_stuff_f[[3]],
   access_token = token_stuff_f[[4]],
   access_secret = token_stuff_f[[5]],
   set_renv = FALSE)


suppressPackageStartupMessages(suppressWarnings(library(dplyr)))

tweet_id <- rtweet::get_timeline("StateHealthIN",
                                 n = 150,
                                 token = rt_tok_e) %>% 
      tidyr::separate(col = "created_at", into = c("date", "time"), sep = " ") %>% 
      mutate(date = lubridate::as_date(date),
             time = hms::as_hms(time)) %>%
      select(date, status_id, text) %>% 
      filter(stringr::str_detect(text, pattern = "latest #COVID19 case information") | stringr::str_detect(text, pattern = "positive cases")) %>% 
      filter(date == lubridate::today()) %>% 
      pull(status_id)

# get plot paths, names, and dates
png_files <- tibble::tibble(paths = fs::dir_ls(glue::glue("{rprojroot::find_rstudio_root_file()}/tracker/plots"))) %>% 
      mutate(
            chart = stringr::str_extract(paths,
                                         pattern = "[a-z]*-[a-z]*-[a-z]*"),
            date = stringr::str_extract(paths,
                                        pattern = "[0-9]{4}-[0-9]{2}-[0-9]{2}") %>%
                  as.Date()
            ) %>%
      group_by(chart) %>% 
      filter(date == max(date)) %>% 
      ungroup()

random_pic <- sample(c(1,2,3,4,6,7,9,10), size = 1)
fixed_pics <- c(5, 8)
lineup <- c(fixed_pics, random_pic)

pngs <- png_files %>%
      slice(lineup) %>% 
      pull(paths)


msg <- glue::glue("@StateHealthIN More charts and analysis at
                  https://github.com/ercbk/Indiana-COVID-19-Tracker")

msg_e <- glue::glue("Indiana COVID-19 Tracker noon update. More charts and analysis at
                  https://github.com/ercbk/Indiana-COVID-19-Tracker #rstats")

msg_f <- glue::glue("Indiana COVID-19 Tracker noon update. More charts and analysis at
                  https://github.com/ercbk/Indiana-COVID-19-Tracker")


rtweet::post_tweet(msg,
           in_reply_to_status_id = tweet_id,
           media = pngs,
           token = rt_tok_e)

rtweet::post_tweet(msg_e,
           media = pngs,
           token = rt_tok_e)

rtweet::post_tweet(msg_f,
           media = pngs,
           token = rt_tok_f)