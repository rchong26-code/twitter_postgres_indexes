/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
WITH coronavirus_tweets AS (
    SELECT DISTINCT data
    FROM tweets_jsonb
    WHERE (data #> '{entities,hashtags}') @> '[{"text":"coronavirus"}]'::jsonb
       OR (data #> '{extended_tweet,entities,hashtags}') @> '[{"text":"coronavirus"}]'::jsonb
)
SELECT
    tag,
    count(*) AS count
FROM (
    SELECT DISTINCT
        data->>'id' AS id_tweets,
        '#' || (hashtag->>'text') AS tag
    FROM coronavirus_tweets
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
