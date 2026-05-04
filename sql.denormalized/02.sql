SELECT tag, count(*) as count
FROM(
    SELECT DISTINCT  data->>'id' as id_tweets,  '#' || (jsonb_array_elements(data->'entities'->'hashtags' || coalesce(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text') as tag
    from tweets_jsonb
    where data->'entities'->'hashtags' @@ '$[*].text == "coronavirus"' 
    OR data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
)t
GROUP BY tag
ORDER BY count DESC, tag
limit 1000;
