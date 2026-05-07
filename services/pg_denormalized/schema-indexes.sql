SET maintenance_work_mem = '16GB';
SET max_parallel_maintenance_workers = 16;
SET max_parallel_workers = 32;

CREATE INDEX IF NOT EXISTS idx_jsonb_hashtags
ON tweets_jsonb
USING GIN ((data #> '{entities,hashtags}') jsonb_path_ops);

CREATE INDEX IF NOT EXISTS idx_jsonb_extended_hashtags
ON tweets_jsonb
USING GIN ((data #> '{extended_tweet,entities,hashtags}') jsonb_path_ops);

CREATE INDEX IF NOT EXISTS idx_jsonb_text_search
ON tweets_jsonb
USING GIN (
    to_tsvector(
        'english',
        COALESCE(data #>> '{extended_tweet,full_text}', data->>'text')
    )
);

CREATE INDEX IF NOT EXISTS idx_jsonb_lang
ON tweets_jsonb ((data->>'lang'));
