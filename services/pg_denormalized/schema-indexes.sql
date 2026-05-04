CREATE INDEX idx_hashtag ON tweets_jsonb USING GIN (
    (data -> 'entities' -> 'hashtags' -> 'text')
);

CREATE INDEX idx_extended ON tweets_jsonb USING GIN (
    (data -> 'extended_tweet' -> 'entities' -> 'hashtags' -> 'text')
);

CREATE INDEX idx_lang ON tweets_jsonb (
    (data ->> 'lang')
);

CREATE INDEX idx_text ON tweets_jsonb USING GIN (
    to_tsvector('english', COALESCE(
            data -> 'extended_tweet' ->> 'full_text', data ->> 'text'
    ))
);

CREATE INDEX idx_id ON tweets_jsonb ((data ->> 'id'));
