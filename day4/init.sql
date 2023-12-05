DROP SCHEMA x CASCADE;
CREATE SCHEMA x;
CREATE TABLE x.staging (game_id text, input text);
--COPY x.staging from '/Users/matthewweitzel/projects/aoc-2023/day4/example' delimiter ':';
COPY x.staging from '/Users/matthewweitzel/projects/aoc-2023/day4/input' delimiter ':';

create table x.wins (game_id text, token text);
create table x.plays (game_id text, token text);

insert into x.plays
  select game_id, unnest(regexp_split_to_array(trim(both ' ' from played), E'\\s+')) as play from (
    select
      game_id,
      split_part(input, '|', 1) as winning,
      split_part(input, '|', 2) as played
    from x.staging
  ) as tmp_foo;

insert into x.wins
  select game_id, unnest(regexp_split_to_array(trim(both ' ' from winning), E'\\s+')) as play from (
    select
      game_id,
      split_part(input, '|', 1) as winning,
      split_part(input, '|', 2) as played
    from x.staging
  ) as tmp_foo;



select x.plays.game_id, count(x.plays.token) from x.plays inner join x.wins on x.plays.token = x.wins.token and x.plays.game_id = x.wins.game_id group by plays.game_id;
select x.plays.game_id, power(2, count(x.plays.token) - 1) from x.plays inner join x.wins on x.plays.token = x.wins.token and x.plays.game_id = x.wins.game_id group by plays.game_id; --order by x.plays.game_id asc;
select sum(pow) from (
  select power(2, count(x.plays.token) - 1) as pow from x.plays inner join x.wins on x.plays.token = x.wins.token and x.plays.game_id = x.wins.game_id group by plays.game_id
) as tmp;
