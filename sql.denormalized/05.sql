/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */
WITH coronavirus_text_tweets AS (
    SELECT data
    FROM tweets_jsonb
    WHERE data->>'lang' = 'en'
      AND to_tsvector(
            'english',
            COALESCE(data #>> '{extended_tweet,full_text}', data->>'text')
          ) @@ to_tsquery('english', 'coronavirus')
)
SELECT
    tag,
    count(*) AS count
FROM (
    SELECT DISTINCT
        data->>'id' AS id_tweets,
        '#' || (hashtag->>'text') AS tag
    FROM coronavirus_text_tweets
    CROSS JOIN LATERAL jsonb_array_elements(
        COALESCE(
            data #> '{extended_tweet,entities,hashtags}',
            data #> '{entities,hashtags}',
            '[]'::jsonb
        )
    ) AS hashtag
    WHERE hashtag->>'text' IS NOT NULL
) t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;
