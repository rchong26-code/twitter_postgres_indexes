SET max_parallel_maintenance_workers = 60;
SET max_parallel_workers = 60;
SET maintenance_work_mem TO '6GB';

CREATE INDEX tags_on_id_idx ON tweet_tags (tag, id_tweets);
CREATE INDEX tags_idx ON tweet_tags (tag);
CREATE INDEX id_lang_idx ON tweets (id_tweets, lang);
CREATE INDEX lang_idx ON tweets (lang);
CREATE INDEX corona_idx_gini ON tweets USING GIN(to_tsvector('english', text)) WHERE lang = 'en';

