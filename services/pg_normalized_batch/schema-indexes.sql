SET maintenance_work_mem = '16GB';
SET max_parallel_maintenance_workers = 16;
SET max_parallel_workers = 32;

CREATE INDEX IF NOT EXISTS idx_tweet_tags_tag ON tweet_tags(tag);
CREATE INDEX IF NOT EXISTS idx_tweet_tags_id_tweets ON tweet_tags(id_tweets);
CREATE INDEX IF NOT EXISTS idx_tweets_lang ON tweets(lang);
CREATE INDEX IF NOT EXISTS idx_tweets_text_gin ON tweets USING GIN (to_tsvector('english', text));

CREATE INDEX IF NOT EXISTS idx_tweets_id_tweets ON tweets(id_tweets);
CREATE INDEX IF NOT EXISTS idx_tweet_tags_tag_id ON tweet_tags(tag, id_tweets);
CREATE INDEX IF NOT EXISTS idx_tweet_tags_id_tag ON tweet_tags(id_tweets, tag);
