CREATE TABLE IF NOT EXISTS guild (
       id BIGINT PRIMARY KEY,
       markov_on BOOLEAN NOT NULL DEFAULT false,
       tag_prefix_on BOOLEAN NOT NULL DEFAULT false,
       commands_from BIGINT NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS message (
       id BIGINT PRIMARY KEY,
       guild_id BIGINT NOT NULL REFERENCES guild (id) ON DELETE CASCADE,
       user_id BIGINT NOT NULL,
       msg VARCHAR(2000) NOT NULL,
       created_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS "prefix" (
       id BIGSERIAL PRIMARY KEY,
       guild_id BIGINT NOT NULL REFERENCES guild (id) ON DELETE CASCADE,
       pre VARCHAR(2000) NOT NULL,
       UNIQUE (guild_id, pre)
);


CREATE TABLE IF NOT EXISTS reminder (
       id BIGSERIAL PRIMARY KEY,
       user_id BIGINT NOT NULL,
       channel_id BIGINT NOT NULL,
       text VARCHAR(2000) NOT NULL,
       started TIMESTAMP NOT NULL,
       "when" TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS tag (
       id BIGSERIAL PRIMARY KEY,
       author_id BIGINT NOT NULL,
       guild_id BIGINT NOT NULL REFERENCES guild (id) ON DELETE CASCADE,
       "key" VARCHAR(2000) NOT NULL,
       text VARCHAR(2000) NOT NULL,
       UNIQUE (guild_id, "key")
);

CREATE INDEX IF NOT EXISTS ON "message" ("guild_id", "user_id");
CREATE INDEX IF NOT EXISTS ON "prefix" ("guild_id");
CREATE INDEX IF NOT EXISTS ON "reminder" ("when" ASC);
CREATE INDEX IF NOT EXISTS ON "tag" ("key", "guild_id");
