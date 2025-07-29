--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Homebrew)
-- Dumped by pg_dump version 15.13 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: curify
--

CREATE SCHEMA auth;

ALTER SCHEMA auth OWNER TO curify;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: curify
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO curify;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: curify
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO curify;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: curify
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO curify;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: curify
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO curify;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: curify
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO curify;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: curify
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO curify;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: curify
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO curify;

--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: curify
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO curify;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: curify
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO curify;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: curify
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO curify;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: curify
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO curify;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: curify
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO curify;

--
-- Name: accounttype; Type: TYPE; Schema: public; Owner: curify
--

CREATE TYPE public.accounttype AS ENUM (
    'PAY_AS_YOU_GO',
    'SUBSCRIPTION'
);


ALTER TYPE public.accounttype OWNER TO curify;

--
-- Name: audiooption; Type: TYPE; Schema: public; Owner: curify
--

CREATE TYPE public.audiooption AS ENUM (
    'ORIGINAL',
    'AI_AUDIO',
    'original',
    'dubbed',
    'premium'
);


ALTER TYPE public.audiooption OWNER TO curify;

--
-- Name: planname; Type: TYPE; Schema: public; Owner: curify
--

CREATE TYPE public.planname AS ENUM (
    'FREE',
    'PRO',
    'ENTERPRISE'
);


ALTER TYPE public.planname OWNER TO curify;

--
-- Name: projectstatus; Type: TYPE; Schema: public; Owner: curify
--

CREATE TYPE public.projectstatus AS ENUM (
    'STARTED',
    'PREPROCESSING',
    'TRANSCRIBING',
    'TRANSLATING',
    'DUBBING',
    'COMPLETED',
    'FAILED'
);


ALTER TYPE public.projectstatus OWNER TO curify;

--
-- Name: subtitleformat; Type: TYPE; Schema: public; Owner: curify
--

CREATE TYPE public.subtitleformat AS ENUM (
    'NONE',
    'SOURCE',
    'TARGET',
    'BILINGUAL',
    'target',
    'none',
    'source',
    'bilingual'
);


ALTER TYPE public.subtitleformat OWNER TO curify;

--
-- Name: transactiontype; Type: TYPE; Schema: public; Owner: curify
--

CREATE TYPE public.transactiontype AS ENUM (
    'CREDIT_PURCHASE',
    'SUBSCRIPTION_PAYMENT',
    'USAGE_DEDUCTION'
);


ALTER TYPE public.transactiontype OWNER TO curify;

--
-- Name: video_active_status; Type: TYPE; Schema: public; Owner: curify
--

CREATE TYPE public.video_active_status AS ENUM (
    'Active',
    'Deleted'
);


ALTER TYPE public.video_active_status OWNER TO curify;

--
-- Name: videostatus; Type: TYPE; Schema: public; Owner: curify
--

CREATE TYPE public.videostatus AS ENUM (
    'UPLOADED',
    'PREPROCESSING',
    'TRANSCRIBING',
    'TRANSLATING',
    'DUBBING',
    'COMPLETED',
    'FAILED'
);


ALTER TYPE public.videostatus OWNER TO curify;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: curify
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO curify;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: curify
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO curify;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: curify
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO curify;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: curify
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO curify;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: curify
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO curify;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: curify
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO curify;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: curify
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO curify;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: curify
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO curify;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: curify
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO curify;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: curify
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO curify;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: curify
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: curify
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO curify;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: curify
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: curify
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO curify;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: curify
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: curify
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO curify;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: curify
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO curify;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: curify
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO curify;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: curify
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: curify
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO curify;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: curify
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO curify;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: curify
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO curify;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: curify
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO curify;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: curify
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO curify;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: curify
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO curify;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: curify
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO curify;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: curify
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO curify;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: curify
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO curify;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: curify
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO curify;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: curify
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO curify;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: curify
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO curify;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: curify
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO curify;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: curify
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO curify;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: curify
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO curify;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: curify
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO curify;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: curify
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO curify;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: curify
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO curify;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: curify
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO curify;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: curify
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO curify;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: curify
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO curify;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: curify
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO curify;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: curify
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO curify;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO curify;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO curify;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO curify;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO curify;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO curify;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO curify;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO curify;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO curify;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO curify;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: curify
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.refresh_tokens_id_seq OWNER TO curify;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: curify
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO curify;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO curify;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO curify;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO curify;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO curify;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO curify;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: curify
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO curify;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: project; Type: TABLE; Schema: public; Owner: curify
--

CREATE TABLE public.project (
    project_id character varying NOT NULL,
    name character varying(255) NOT NULL,
    user_id integer NOT NULL,
    description character varying(500),
    model_used character varying,
    status public.projectstatus,
    erase_original_subtitles boolean DEFAULT false NOT NULL,
    subtitles_enabled public.subtitleformat DEFAULT 'target'::public.subtitleformat NOT NULL,
    audio_option public.audiooption DEFAULT 'dubbed'::public.audiooption NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    video_duration_seconds double precision,
    cost_credits double precision,
    video_id character varying,
    job_settings_raw jsonb,
    runtime_params jsonb,
    model_version character varying,
    run_id character varying,
    is_production boolean DEFAULT true,
    project_duration_minutes double precision,
    allow_lip_syncing boolean DEFAULT false NOT NULL,
    translated_runtime_params jsonb,
    final_video_blob_path text
);


ALTER TABLE public.project OWNER TO curify;

--
-- Name: project_project_id_seq; Type: SEQUENCE; Schema: public; Owner: curify
--

CREATE SEQUENCE public.project_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_project_id_seq OWNER TO curify;

--
-- Name: project_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: curify
--

ALTER SEQUENCE public.project_project_id_seq OWNED BY public.project.project_id;


--
-- Name: project_segment_annotation; Type: TABLE; Schema: public; Owner: curify
--

CREATE TABLE public.project_segment_annotation (
    segment_id integer NOT NULL,
    project_id character varying NOT NULL,
    line_number integer NOT NULL,
    original_annotated character varying,
    speaker_annotated character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.project_segment_annotation OWNER TO curify;

--
-- Name: projectsegment; Type: TABLE; Schema: public; Owner: curify
--

CREATE TABLE public.projectsegment (
    segment_id integer NOT NULL,
    project_id character varying NOT NULL,
    line_number integer NOT NULL,
    start double precision NOT NULL,
    "end" double precision NOT NULL,
    original character varying,
    translated character varying,
    speaker character varying,
    post_edited character varying,
    speed double precision,
    target_duration double precision,
    aligned_start double precision,
    aligned_end double precision,
    transcribed_scribe character varying,
    transcribed_ocr character varying,
    transcribed_fused character varying,
    speaker_scribe character varying,
    speaker_pyannote character varying,
    speaker_fused character varying,
    "translated_GPT" character varying,
    "translated_Azure" character varying,
    translated_fused character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    video_id character varying,
    original_updated text,
    translated_updated text
);


ALTER TABLE public.projectsegment OWNER TO curify;

--
-- Name: projectsegment_id_seq; Type: SEQUENCE; Schema: public; Owner: curify
--

CREATE SEQUENCE public.projectsegment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projectsegment_id_seq OWNER TO curify;

--
-- Name: projectsegment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: curify
--

ALTER SEQUENCE public.projectsegment_id_seq OWNED BY public.projectsegment.segment_id;


--
-- Name: subscription; Type: TABLE; Schema: public; Owner: curify
--

CREATE TABLE public.subscription (
    subscription_id integer NOT NULL,
    user_id integer NOT NULL,
    plan_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    plan_name character varying(100)
);


ALTER TABLE public.subscription OWNER TO curify;

--
-- Name: subscription_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: curify
--

CREATE SEQUENCE public.subscription_subscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_subscription_id_seq OWNER TO curify;

--
-- Name: subscription_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: curify
--

ALTER SEQUENCE public.subscription_subscription_id_seq OWNED BY public.subscription.subscription_id;


--
-- Name: transaction; Type: TABLE; Schema: public; Owner: curify
--

CREATE TABLE public.transaction (
    transaction_id integer NOT NULL,
    user_id integer NOT NULL,
    transaction_type public.transactiontype,
    amount double precision NOT NULL,
    currency character varying(3) NOT NULL,
    transaction_date timestamp without time zone NOT NULL,
    description character varying(1024),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    project_id character varying(255)
);


ALTER TABLE public.transaction OWNER TO curify;

--
-- Name: transaction_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: curify
--

CREATE SEQUENCE public.transaction_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_transaction_id_seq OWNER TO curify;

--
-- Name: transaction_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: curify
--

ALTER SEQUENCE public.transaction_transaction_id_seq OWNED BY public.transaction.transaction_id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: curify
--

CREATE TABLE public."user" (
    user_id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255),
    username character varying(100),
    google_id character varying(255),
    account_type public.accounttype,
    current_credits double precision NOT NULL,
    subscription_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    first_name character varying(100),
    last_name character varying(100)
);


ALTER TABLE public."user" OWNER TO curify;

--
-- Name: user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: curify
--

CREATE SEQUENCE public.user_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_user_id_seq OWNER TO curify;

--
-- Name: user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: curify
--

ALTER SEQUENCE public.user_user_id_seq OWNED BY public."user".user_id;


--
-- Name: video; Type: TABLE; Schema: public; Owner: curify
--

CREATE TABLE public.video (
    video_id character varying NOT NULL,
    user_id integer NOT NULL,
    original_filename character varying(255),
    stored_filename character varying(255),
    original_language character varying(10),
    video_duration_seconds double precision,
    completed_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_youtube_upload boolean DEFAULT false,
    local_storage_path character varying(512),
    blob_storage_url character varying(512),
    thumbnail_blob_path character varying(512),
    project_id uuid,
    blob_url text,
    width integer,
    height integer,
    display_aspect_ratio text,
    aspect_ratio_numeric double precision,
    frame_rate double precision,
    video_codec text,
    original_source_url character varying(512),
    video_status character varying(50) DEFAULT 'Active'::character varying NOT NULL
);


ALTER TABLE public.video OWNER TO curify;

--
-- Name: video_video_id_seq; Type: SEQUENCE; Schema: public; Owner: curify
--

CREATE SEQUENCE public.video_video_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_video_id_seq OWNER TO curify;

--
-- Name: video_video_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: curify
--

ALTER SEQUENCE public.video_video_id_seq OWNED BY public.video.video_id;


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: curify
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO curify;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: curify
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO curify;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: curify
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO curify;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: curify
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: curify
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO curify;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: curify
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: curify
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO curify;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: curify
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO curify;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: curify
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: curify
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO curify;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: curify
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO curify;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: project project_id; Type: DEFAULT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.project ALTER COLUMN project_id SET DEFAULT nextval('public.project_project_id_seq'::regclass);


--
-- Name: projectsegment segment_id; Type: DEFAULT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.projectsegment ALTER COLUMN segment_id SET DEFAULT nextval('public.projectsegment_id_seq'::regclass);


--
-- Name: subscription subscription_id; Type: DEFAULT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.subscription ALTER COLUMN subscription_id SET DEFAULT nextval('public.subscription_subscription_id_seq'::regclass);


--
-- Name: transaction transaction_id; Type: DEFAULT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.transaction ALTER COLUMN transaction_id SET DEFAULT nextval('public.transaction_transaction_id_seq'::regclass);


--
-- Name: user user_id; Type: DEFAULT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public."user" ALTER COLUMN user_id SET DEFAULT nextval('public.user_user_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: curify
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: curify
--

COPY public.project (project_id, name, user_id, description, model_used, status, erase_original_subtitles, subtitles_enabled, audio_option, created_at, updated_at, video_duration_seconds, cost_credits, video_id, job_settings_raw, runtime_params, model_version, run_id, is_production, project_duration_minutes, allow_lip_syncing, translated_runtime_params, final_video_blob_path) FROM stdin;
69_69_776ea5e8_71b6bbab	Test Project 5d90865c	69	A test project initiated via /translate endpoint.	\N	STARTED	f	target	dubbed	2025-06-18 15:30:13.440552	2025-06-18 15:30:13.440566	\N	\N	69_776ea5e8	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	\N	\N
70_70_bf0a2b41_9d6337bc	Test Project 2e1b9a44	70	A test project initiated via /translate endpoint.	\N	STARTED	f	target	dubbed	2025-06-18 15:36:11.636561	2025-06-18 15:36:11.636574	\N	\N	70_bf0a2b41	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	\N	\N
71_71_bde9f8f9_d61df661	Test Project d8f9363d	71	A test project initiated via /translate endpoint.	\N	STARTED	f	target	dubbed	2025-06-18 15:38:49.548491	2025-06-18 15:38:49.548505	\N	\N	71_bde9f8f9	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	\N	\N
73_73_97db6bb5_4d0ae935	Test Project fde7b339	73	A test project initiated via /translate endpoint.	\N	STARTED	f	target	dubbed	2025-06-18 16:03:52.375436	2025-06-18 16:03:52.375472	\N	\N	73_97db6bb5	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
74_74_07508506_08914282	Test Project 21efcb91	74	A test project initiated via /translate endpoint.	\N	STARTED	f	target	dubbed	2025-06-19 00:23:13.995063	2025-06-19 00:23:13.995078	\N	\N	74_07508506	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
75_75_5829e289_78d83eda	Test Project 1a2ef6f9	75	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-19 00:37:00.986213	2025-06-19 00:38:16.772077	\N	\N	75_5829e289	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
87_87_c1b873d0_ac5e1cf3	Test Project 374f5986	87	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-19 07:57:41.799989	2025-06-19 07:58:11.731904	\N	\N	87_c1b873d0	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
81_81_3dba7eaa_308e0d6f	Test Project 556922a1	81	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-19 04:17:09.277491	2025-06-19 04:17:23.666824	\N	\N	81_3dba7eaa	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
76_76_097ab2f6_8b9c6295	Test Project 0da71860	76	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-19 01:18:07.682049	2025-06-19 01:18:23.211006	\N	\N	76_097ab2f6	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
78_78_4e37fc2f_e53418a6	Test Project 7b249526	78	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-19 01:47:26.554881	2025-06-19 01:48:00.854993	\N	\N	78_4e37fc2f	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
77_77_4010ce97_8f2fbb30	Test Project 20f9bd14	77	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-19 01:30:24.327912	2025-06-19 01:30:42.654391	\N	\N	77_4010ce97	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
80_80_683ec245_6acb97bf	Test Project 4613f454	80	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-19 04:06:53.460021	2025-06-19 04:07:14.249917	\N	\N	80_683ec245	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
79_79_0fa34cba_b80d9ecd	Test Project 68a2d484	79	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-19 03:04:56.034534	2025-06-19 03:05:24.614894	\N	\N	79_0fa34cba	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
83_83_e82a5539_0b3ead73	Test Project b2ce361c	83	A test project initiated via /translate endpoint.	\N	TRANSLATING	f	target	dubbed	2025-06-19 05:02:30.504898	2025-06-19 05:02:46.764232	\N	\N	83_e82a5539	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
82_82_c0772ec8_80b754a6	Test Project 022c8716	82	A test project initiated via /translate endpoint.	\N	TRANSLATING	f	target	dubbed	2025-06-19 04:26:12.73117	2025-06-19 04:26:33.933129	\N	\N	82_c0772ec8	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
88_88_f4251d55_a51f53c3	Test Project 79dcbf34	88	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-20 11:36:13.012062	2025-06-20 11:36:54.773601	\N	\N	88_f4251d55	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
86_86_aa233465_700cefab	Test Project 550d3d47	86	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-19 06:20:30.475028	2025-06-19 06:20:59.261841	\N	\N	86_aa233465	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
90_90_ec3fe33c_ae099ac0	Test Project 41ee7d39	90	A test project initiated via /translate endpoint.	\N	STARTED	f	target	dubbed	2025-06-21 09:31:38.600782	2025-06-21 09:31:38.600782	\N	\N	90_ec3fe33c	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
91_91_eb46d0af_cee30204	Test Project 9fb994d5	91	A test project initiated via /translate endpoint.	\N	STARTED	f	target	dubbed	2025-06-21 09:37:35.085394	2025-06-21 09:37:35.085394	\N	\N	91_eb46d0af	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
89_89_9591c181_6880dbec	Test Project 0d088964	89	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-21 09:12:55.079719	2025-06-21 09:13:16.182544	\N	\N	89_9591c181	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
99_99_69ce7d0e_5c5d7cac	Test Project 975a000a	99	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-21 11:19:27.389046	2025-06-21 11:19:30.724156	\N	\N	99_69ce7d0e	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
92_92_d2990fe6_eef99401	Test Project 6b5d3e0e	92	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-21 09:44:48.796223	2025-06-21 09:45:13.184088	\N	\N	92_d2990fe6	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
95_95_34fab093_c363b445	Test Project fb63ce8a	95	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-21 10:34:55.238642	2025-06-21 10:35:13.936194	\N	\N	95_34fab093	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.3115595333333333	f	{}	\N
101_101_f8a12cf1_d7a5d019	Test Project 042491b8	101	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-21 11:33:45.532761	2025-06-21 11:34:09.659835	\N	\N	101_f8a12cf1	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.40206875	f	{}	\N
96_96_4192389e_ee1941a2	Test Project 9c0fd118	96	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-21 10:46:52.375215	2025-06-21 10:46:53.095242	\N	\N	96_4192389e	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
93_93_ac8ef27e_80683cce	Test Project 2fee3065	93	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-21 09:51:31.94525	2025-06-21 09:51:55.384625	\N	\N	93_ac8ef27e	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.3906161166666667	f	{}	\N
97_97_0aa27b5d_da4ee2d2	Test Project c7bd6156	97	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-21 11:10:53.503015	2025-06-21 11:10:56.956412	\N	\N	97_0aa27b5d	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
94_94_6ba89cc6_24b63c87	Test Project 604332e8	94	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-21 10:01:30.509349	2025-06-21 10:02:16.968143	\N	\N	94_6ba89cc6	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.7739645333333333	f	{}	\N
104_104_7cd6f15b_b061fe4f	Test Project d6ab8baa	104	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-21 11:56:10.579764	2025-06-21 11:56:45.128272	\N	\N	104_7cd6f15b	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
98_98_be0a9341_9196417f	Test Project e70db3b9	98	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-21 11:16:12.063793	2025-06-21 11:16:14.670253	\N	\N	98_be0a9341	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
100_100_2926b74e_95703d32	Test Project 81a3a92c	100	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-21 11:22:31.194613	2025-06-21 11:23:12.048985	\N	\N	100_2926b74e	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.68086475	f	{}	\N
103_103_ed2069d1_3b821b9b	Test Project 67101e32	103	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-21 11:53:59.51772	2025-06-21 11:54:19.802526	\N	\N	103_ed2069d1	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
105_105_7085656b_72ce6c35	Test Project eb00a837	105	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-21 12:03:29.290172	2025-06-21 12:04:07.50093	\N	\N	105_7085656b	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.6368009	f	{}	\N
102_102_2a2de07e_6ce6d8f1	Test Project c3a8d031	102	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-21 11:44:42.28078	2025-06-21 11:45:03.504426	\N	\N	102_2a2de07e	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.3536883833333333	f	{}	\N
107_107_5657f936_574683fb	Test Project f6bdbc85	107	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-21 12:27:15.876462	2025-06-21 12:27:58.495476	\N	\N	107_5657f936	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.7102729833333333	f	{}	\N
106_106_829c1404_8e409b86	Test Project 21fd2cca	106	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-21 12:18:16.827746	2025-06-21 12:18:58.074596	\N	\N	106_829c1404	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.6873965666666667	f	{}	\N
108_108_b70b407d_7eebad7d	Test Project d4e76711	108	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-22 11:12:56.434519	2025-06-22 11:12:57.121402	\N	\N	108_b70b407d	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
110_110_25043c17_a7012e43	Test Project 530b32da	110	A test project initiated via /translate endpoint.	\N	TRANSLATING	f	target	dubbed	2025-06-22 11:43:21.624875	2025-06-22 11:43:41.092844	\N	\N	110_25043c17	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
109_109_d8908252_e27f5354	Test Project 501ec90d	109	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-22 11:34:23.232705	2025-06-22 11:35:07.568903	\N	\N	109_d8908252	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.7388946333333333	f	{}	\N
120_120_e1d75c5b_92ee114d	Test Project 5dd520ec	120	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-22 15:29:29.301768	2025-06-22 15:29:58.104932	\N	\N	120_e1d75c5b	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.47972205	f	{}	\N
111_111_b04b04a2_f10e1932	Test Project 823dafda	111	A test project initiated via /translate endpoint.	\N	TRANSLATING	f	target	dubbed	2025-06-22 11:52:15.68225	2025-06-22 11:52:36.515235	\N	\N	111_b04b04a2	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
114_114_6321e91e_6efd2959	Test Project dfe9addc	114	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-22 14:30:27.907036	2025-06-22 14:31:28.926881	\N	\N	114_6321e91e	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.0169021333333332	f	{}	\N
112_112_d6205c32_f8aa9479	Test Project cb1e8796	112	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-22 12:02:52.175501	2025-06-22 13:28:36.142156	\N	\N	112_d6205c32	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	85.73263848333333	f	{}	\N
117_117_68d05114_d9ac76ef	Test Project 88d75c60	117	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-22 14:58:27.067388	2025-06-22 14:59:07.11992	\N	\N	117_68d05114	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.6674412166666667	f	{}	\N
115_115_190acb2c_7664c4b5	Test Project c68fa075	115	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-22 14:33:31.999373	2025-06-22 14:35:01.386068	\N	\N	115_190acb2c	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.4896981333333335	f	{}	\N
113_113_25d7e4db_e7620a9f	Test Project 88c9b7c2	113	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-22 13:48:27.5016	2025-06-22 13:49:25.695744	\N	\N	113_25d7e4db	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.96984735	f	{}	\N
119_119_eae00ff0_42d4c3d9	Test Project 59dbf715	119	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-22 15:09:57.396895	2025-06-22 15:10:53.295673	\N	\N	119_eae00ff0	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.9315965666666667	f	{}	\N
122_122_c1d22b22_a58320d8	Test Project fb4c3491	122	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-22 15:45:11.908857	2025-06-22 15:47:40.216329	\N	\N	122_c1d22b22	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
116_116_355ce257_db103ffc	Test Project 0e09b31e	116	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-22 14:48:06.698036	2025-06-22 14:48:38.586363	\N	\N	116_355ce257	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.5314223666666666	f	{}	\N
118_118_0273d2b7_8f53ad49	Test Project 4ef517e6	118	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-22 15:07:05.253286	2025-06-22 15:07:47.962387	\N	\N	118_0273d2b7	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.7117697833333333	f	{}	\N
121_121_2d7e1583_3dea4bff	Test Project 6735da95	121	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-22 15:34:10.274935	2025-06-22 15:36:33.497676	\N	\N	121_2d7e1583	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	2.3869500500000003	f	{}	\N
125_125_bfe44d53_08ca936a	Test Project 84f633b8	125	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-22 16:21:41.402037	2025-06-22 16:24:03.57178	\N	\N	125_bfe44d53	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
123_123_847375a5_1e70cac9	Test Project 02ecf145	123	A test project initiated via /translate endpoint.	\N	TRANSLATING	f	target	dubbed	2025-06-22 15:55:14.243978	2025-06-22 15:55:34.722994	\N	\N	123_847375a5	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
124_124_5cf8e425_f471b51d	Test Project bea52be0	124	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-22 16:01:48.953651	2025-06-22 16:04:05.192015	\N	\N	124_5cf8e425	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
126_126_45d422a0_d895bad8	Test Project 679665b2	126	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-22 16:26:37.658391	2025-06-22 16:28:47.180277	\N	\N	126_45d422a0	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
127_127_15829f35_747de7d7	Test Project aacebda3	127	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-22 16:42:34.6699	2025-06-22 16:44:42.700747	\N	\N	127_15829f35	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
128_128_460efb81_4c420524	Test Project 81cf398d	128	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-22 16:51:02.395061	2025-06-22 16:53:15.500663	\N	\N	128_460efb81	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
129_129_ffdcb0d5_dffdb208	Test Project 4ffad2cb	129	A test project initiated via /translate endpoint.	\N	TRANSLATING	f	target	dubbed	2025-06-22 17:15:23.863752	2025-06-22 17:15:44.153557	\N	\N	129_ffdcb0d5	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
133_133_71181108_472353e7	Test Project a9810ed6	133	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-22 17:34:58.465891	2025-06-22 17:37:08.939349	\N	\N	133_71181108	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	2.1744632666666663	f	{}	\N
130_130_52f15816_d51d5ea7	Test Project b90205e2	130	A test project initiated via /translate endpoint.	\N	TRANSLATING	f	target	dubbed	2025-06-22 17:20:56.284938	2025-06-22 17:21:14.265274	\N	\N	130_52f15816	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
131_131_95378eba_736b080d	Test Project f7d3031c	131	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-22 17:23:28.966849	2025-06-22 17:25:58.410926	\N	\N	131_95378eba	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
132_132_b3f45a8d_e3af3682	Test Project a2420ca5	132	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-22 17:28:29.753243	2025-06-22 17:30:43.866644	\N	\N	132_b3f45a8d	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	2.2351549	f	{}	\N
196_196_f8b106c0_5d3840b3	Test Project cf828680	196	A test project initiated via /translate endpoint.	\N	TRANSLATING	f	target	dubbed	2025-07-01 03:18:22.811087	2025-07-01 03:18:43.935835	\N	\N	196_f8b106c0	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
147_147_1d667e50_d14245c2	Test Project 2bce302f	147	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-25 04:57:23.801449	2025-06-25 04:59:52.007376	\N	\N	147_1d667e50	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	2.4700609333333334	f	{}	\N
166_166_7a9be842_977697cc	TrumpTarrifs_cn_edited	166		\N	COMPLETED	f	target	dubbed	2025-07-11 03:41:30.412735	2025-07-11 03:41:57.369889	\N	\N	166_7a9be842	{"audio_option": "original", "speaker_count": 0, "source_language": "default", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "none", "erase_original_subtitles": false}	{}	\N	\N	t	0.4492408	f	{}	projects/166/166_166_7a9be842_977697cc/video_current.mp4
167_167_15fd9fee_e48f5500	Test Project 99c9f682	167	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-25 08:08:54.37142	2025-06-25 08:09:42.934215	\N	\N	167_15fd9fee	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.8089206833333333	f	{}	\N
202_202_62ebfd84_6209205f	Test Project 10dc376d	202	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-01 09:56:53.559622	2025-07-01 10:05:12.699917	\N	\N	202_62ebfd84	{"audio_option": "original", "speaker_count": null, "source_language": "en", "target_language": "zh-cn", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	8.31892855	f	{}	projects/202/202_202_62ebfd84_6209205f/video_current.mp4
215_215_e09ac43d_cdf5f13a	Test Project a4d821bc	215	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-07-02 05:05:58.567271	2025-07-02 05:34:43.95013	\N	\N	215_e09ac43d	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.4472803	f	{}	projects/215/215_215_e09ac43d_cdf5f13a/video_current.mp4
209_209_20f8d395_0598a840	Test Project 5b231c23	209	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 04:00:42.309511	2025-07-02 04:01:07.201472	\N	\N	209_20f8d395	{"audio_option": "original", "speaker_count": null, "source_language": "en", "target_language": "zh-cn", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.4148140833333333	f	{}	projects/209/209_209_20f8d395_0598a840/video_current.mp4
242_242_c7de0590_054d5b94	loveJourney_en_in	242		\N	PREPROCESSING	f	target	dubbed	2025-07-09 08:11:58.356032	2025-07-09 08:11:58.398169	\N	\N	242_c7de0590	{"audio_option": "premium", "speaker_count": 0, "source_language": "default", "target_language": "zh-cn", "allow_lip_syncing": false, "subtitles_enabled": "bilingual", "erase_original_subtitles": false}	{}	\N	\N	t	\N	f	{}	\N
224_224_319993e2_3326be23	Test Project a2222164	224	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 10:24:32.784588	2025-07-02 10:25:34.260069	\N	\N	224_319993e2	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.02454925	f	{}	projects/224/224_224_319993e2_3326be23/video_current.mp4
169_169_6821aeaa_56843867	Test Project ad533036	169	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-26 07:24:01.149381	2025-06-26 07:24:37.715512	\N	\N	169_6821aeaa	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.60890445	f	{}	<coroutine object upload_file_to_blob at 0x7f7dda8e44c0>?se=2025-06-26T09%3A24%3A37Z&sp=r&sv=2025-05-05&sr=b&sig=cEx3V19DMSLoN9nPTIqxroGVwQpNLBy8EKzhlB4iWb4%3D
210_210_185eef1d_928908be	Test Project c5565341	210	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 04:02:49.973837	2025-07-02 04:03:15.284335	\N	\N	210_185eef1d	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.42179135	f	{}	projects/210/210_210_185eef1d_928908be/video_current.mp4
171_171_5129f1ba_ae0568ff	Test Project 2c086ec0	171	A test project initiated via /translate endpoint.	\N	STARTED	f	target	dubbed	2025-06-26 08:14:44.875423	2025-06-26 08:14:44.875423	\N	\N	171_5129f1ba	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
219_219_510641f4_540df1c5	Test Project a56c23da	219	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 08:14:24.144265	2025-07-02 08:15:25.554126	\N	\N	219_510641f4	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.02345215	f	{}	projects/219/219_219_510641f4_540df1c5/video_current.mp4
168_168_f5aa4a46_228940bb	Test Project 02d5a8ea	168	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-26 07:20:04.807278	2025-06-26 07:20:40.890514	\N	\N	168_f5aa4a46	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.6007747	f	{}	<coroutine object upload_file_to_blob at 0x7f7d827d0340>?se=2025-06-26T09%3A20%3A40Z&sp=r&sv=2025-05-05&sr=b&sig=npVJzYLOiBqO2hKszlXhBusHRpAH%2B3QC/%2BegUIKv7R0%3D
170_170_d62cddd8_a71539a4	Test Project f923eb7b	170	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-26 07:42:49.32067	2025-06-26 07:43:24.747541	\N	\N	170_d62cddd8	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.5890303166666667	f	{}	<coroutine object upload_file_to_blob at 0x7f8744a08c40>?se=2025-06-26T09%3A43%3A24Z&sp=r&sv=2025-05-05&sr=b&sig=TIrl6if4fyNaMofGj8bIKFuqB5oSQ5TDv7dQBrfLJSg%3D
242_242_0863b968_48c64d84	test_video	242		\N	PREPROCESSING	f	target	dubbed	2025-07-09 10:06:12.137574	2025-07-09 10:06:12.180274	\N	\N	242_0863b968	{"audio_option": "premium", "speaker_count": 0, "source_language": "default", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "bilingual", "erase_original_subtitles": false}	{}	\N	\N	t	\N	f	{}	\N
225_225_1cc1a481_1527e1c2	Test Project 63a9bc65	225	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 10:32:15.689678	2025-07-02 10:33:17.305765	\N	\N	225_1cc1a481	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.0268703333333333	f	{}	projects/225/225_225_1cc1a481_1527e1c2/video_current.mp4
166_166_3faae103_ca6c3ecd	Lark20250626-224118	166		\N	COMPLETED	f	target	dubbed	2025-07-11 03:56:27.815531	2025-07-11 03:56:57.389444	\N	\N	166_3faae103	{"audio_option": "original", "speaker_count": 0, "source_language": "default", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "none", "erase_original_subtitles": false}	{}	\N	\N	t	0.49285118333333333	f	{}	projects/166/166_166_3faae103_ca6c3ecd/video_current.mp4
211_211_f89736c8_a39bd6d6	Test Project c997c6bf	211	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 04:13:03.611133	2025-07-02 04:13:31.91033	\N	\N	211_f89736c8	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.47160015000000005	f	{}	projects/211/211_211_f89736c8_a39bd6d6/video_current.mp4
198_198_c45a799e_9fc7467e	Test Project f247783a	198	A test project initiated via /translate endpoint.	\N	TRANSLATING	f	target	dubbed	2025-07-01 07:00:56.25577	2025-07-01 07:02:06.458239	\N	\N	198_c45a799e	{"audio_option": "dubbed", "speaker_count": null, "source_language": "en", "target_language": "zh-cn", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
166_166_587fe583_0a819eed	TrumpTarrifs_cn_edited	166		\N	COMPLETED	f	target	dubbed	2025-07-11 04:02:02.987785	2025-07-11 04:02:03.155126	\N	\N	166_587fe583	{"audio_option": "original", "speaker_count": 0, "source_language": "default", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "none", "erase_original_subtitles": true}	{}	\N	\N	t	0.00273665	f	{}	projects/166/166_166_587fe583_0a819eed/video_current.mp4
172_172_be083c95_007d863f	Test Project 3d5c2c89	172	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-26 12:48:42.809616	2025-06-26 12:49:22.434088	\N	\N	172_be083c95	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.6597752	f	{}	<coroutine object upload_file_to_blob at 0x7fbb6906cec0>?se=2025-06-26T14%3A49%3A22Z&sp=r&sv=2025-05-05&sr=b&sig=gdOwVWsPkX%2BCABs9Vwo9%2BHYWino785biYd7sIoJ9Lbw%3D
220_220_473a124c_352f6a35	Test Project e558e22f	220	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 09:22:22.713184	2025-07-02 09:23:24.104509	\N	\N	220_473a124c	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.0231438166666667	f	{}	projects/220/220_220_473a124c_352f6a35/video_current.mp4
216_216_6d5663a6_fb280b9a	Test Project bfef7052	216	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-07-02 05:35:59.726942	2025-07-02 06:02:00.951123	\N	\N	216_6d5663a6	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.44738293333333334	f	{}	projects/216/216_216_6d5663a6_fb280b9a/video_current.mp4
173_173_c6269ac9_f885c40f	Test Project 3b6dfbbc	173	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-26 13:02:54.026134	2025-06-26 13:04:13.665326	\N	\N	173_c6269ac9	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.32670005	f	{}	<coroutine object upload_file_to_blob at 0x7fef01e18bc0>?se=2025-06-26T15%3A04%3A13Z&sp=r&sv=2025-05-05&sr=b&sig=IGBiIu7d6UXidrR002hs7nLTo29rVtg3FXPUdrxeq8M%3D
205_205_d8ca60df_e1d8e1b7	Test Project a0d6fdb8	205	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-07-02 03:38:11.297625	2025-07-02 03:38:11.807616	\N	\N	205_d8ca60df	{"audio_option": "original", "speaker_count": null, "source_language": "en", "target_language": "zh-cn", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
175_175_ce9724e3_dc46386a	Test Project 1c1bb988	175	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-26 14:05:37.905188	2025-06-26 14:06:19.093644	\N	\N	175_ce9724e3	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
174_174_9098c1d3_5f8b5704	Test Project 28f4ea59	174	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-26 13:15:25.779868	2025-06-26 13:16:22.839776	\N	\N	174_9098c1d3	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.9503710666666667	f	{}	<coroutine object upload_file_to_blob at 0x7f788cbf4d40>?se=2025-06-26T15%3A16%3A22Z&sp=r&sv=2025-05-05&sr=b&sig=mwCBBR34KRiEGfUacmEme8gPggXORSGG0YFivkKDACI%3D
176_176_fc9d65c6_36bfb4fd	Test Project a38aa844	176	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-26 14:27:09.181975	2025-06-26 14:27:51.866676	\N	\N	176_fc9d65c6	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
234_234_cffd70a1_d213f67a	Test Project 365b7689	234	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-08 07:51:03.567849	2025-07-08 07:52:05.074142	\N	\N	234_cffd70a1	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.02506135	f	{}	projects/234/234_234_cffd70a1_d213f67a/video_current.mp4
166_166_fa3713e1_d7579fe0	Lark20250626-224118	166		\N	COMPLETED	f	target	dubbed	2025-07-11 04:07:35.30727	2025-07-11 04:08:08.540844	\N	\N	166_fa3713e1	{"audio_option": "original", "speaker_count": 0, "source_language": "default", "target_language": "en", "allow_lip_syncing": true, "subtitles_enabled": "none", "erase_original_subtitles": false}	{}	\N	\N	t	\N	f	{}	\N
199_199_43e8226f_9b6abca2	Test Project 8cbebe67	199	A test project initiated via /translate endpoint.	\N	TRANSLATING	f	target	dubbed	2025-07-01 07:22:19.882601	2025-07-01 07:23:29.978829	\N	\N	199_43e8226f	{"audio_option": "dubbed", "speaker_count": null, "source_language": "en", "target_language": "zh-cn", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
177_177_ced6d062_340b436a	Test Project bc0163e0	177	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-26 14:33:23.719188	2025-06-26 14:34:09.719986	\N	\N	177_ced6d062	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.7660631999999999	f	{}	<coroutine object upload_file_to_blob at 0x7fc5c69c0d40>?se=2025-06-26T16%3A34%3A09Z&sp=r&sv=2025-05-05&sr=b&sig=sHS8tnqGF9lz%2Bm0OPD75PMgsSIH4Ns5SwzjpfJ1VzEs%3D
206_206_10e0e66b_a4b90c55	Test Project cffa698e	206	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-07-02 03:39:06.44277	2025-07-02 03:39:36.275122	\N	\N	206_10e0e66b	{"audio_option": "original", "speaker_count": null, "source_language": "en", "target_language": "zh-cn", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
212_212_a09faf66_99030364	Test Project 77acb291	212	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 04:20:33.554632	2025-07-02 04:20:59.81802	\N	\N	212_a09faf66	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.43767781666666666	f	{}	projects/212/212_212_a09faf66_99030364/video_current.mp4
179_179_4865820b_3a1d4072	Test Project b709ec88	179	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-27 08:44:02.871107	2025-06-27 08:44:40.959774	9.466667	\N	179_4865820b	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.6347544	f	{}	\N
239_239_edfd256e_7d7deafd	Test Project dbf0213b	239	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-08 09:53:35.180874	2025-07-08 09:54:36.750646	\N	\N	239_edfd256e	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.0261034833333333	f	{}	projects/239/239_239_edfd256e_7d7deafd/video_current.mp4
221_221_24470de5_8742e5b4	Test Project 40e0c177	221	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 09:29:28.594189	2025-07-02 09:30:30.07756	\N	\N	221_24470de5	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.0246817666666665	f	{}	projects/221/221_221_24470de5_8742e5b4/video_current.mp4
178_178_30a4b372_bfda9345	Test Project 3ab1877d	178	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-27 08:37:06.174824	2025-06-27 08:37:43.539561	9.466667	\N	178_30a4b372	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.6226958166666667	f	{}	\N
180_180_ecb3cea5_8a4f3727	Test Project 3194cb90	180	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-27 09:00:36.234824	2025-06-27 09:01:17.049935	9.466667	\N	180_ecb3cea5	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.6801627666666668	f	{}	\N
181_181_2e79af24_dc971dce	Test Project e20913dd	181	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-27 09:05:55.86613	2025-06-27 09:06:33.750132	9.466667	\N	181_2e79af24	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.63130625	f	{}	\N
207_207_66724aa8_11a8b544	Test Project 8cfc23ef	207	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-07-02 03:40:53.692447	2025-07-02 03:41:19.679881	\N	\N	207_66724aa8	{"audio_option": "original", "speaker_count": null, "source_language": "en", "target_language": "zh-cn", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
200_200_d1cb7783_fe628ab0	Test Project 083dc8d9	200	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-01 08:00:53.547361	2025-07-01 08:43:03.746416	\N	\N	200_d1cb7783	{"audio_option": "dubbed", "speaker_count": null, "source_language": "en", "target_language": "zh-cn", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	42.16989281666667	f	{}	projects/200/200_200_d1cb7783_fe628ab0/video_current.mp4
213_213_7cb09526_1febaed3	Test Project 774c1356	213	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 04:24:10.28279	2025-07-02 04:24:36.195941	\N	\N	213_7cb09526	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.4318342666666667	f	{}	projects/213/213_213_7cb09526_1febaed3/video_current.mp4
249_249_b8bf6681_a8df10b4	Test Project 415f54ab	249	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-11 10:57:04.957527	2025-07-11 10:58:06.440633	\N	\N	249_b8bf6681	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.02468005	f	{}	projects/249/249_249_b8bf6681_a8df10b4/video_current.mp4
242_242_ec31e69d_ab0f0d65	test_video	242		\N	COMPLETED	f	target	dubbed	2025-07-10 05:42:51.156103	2025-07-10 07:50:39.716727	\N	\N	242_ec31e69d	{"audio_option": "premium", "speaker_count": 0, "source_language": "default", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "bilingual", "erase_original_subtitles": false}	{}	\N	\N	t	127.8092643	f	{}	projects/242/242_242_ec31e69d_ab0f0d65/video_current.mp4
222_222_05247c17_4d9ccfcb	Test Project fe883b8c	222	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 09:48:57.616998	2025-07-02 09:49:59.100688	\N	\N	222_05247c17	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.02468295	f	{}	projects/222/222_222_05247c17_4d9ccfcb/video_current.mp4
182_182_deb7d2d4_d6f2fc73	Test Project 30f59d6a	182	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-30 03:35:30.797707	2025-06-30 03:36:22.540637	\N	\N	182_deb7d2d4	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
183_183_3fd6473f_7763306d	Test Project f67731c4	183	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-30 04:32:29.651028	2025-06-30 04:33:15.00839	\N	\N	183_3fd6473f	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
184_184_3b1fd7f0_a1399e5a	Test Project a01b888f	184	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-30 06:50:06.238235	2025-06-30 06:52:15.316062	\N	\N	184_3b1fd7f0	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
208_208_6bbc4333_1d69eb70	Test Project 65f20933	208	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-07-02 03:58:17.848313	2025-07-02 03:58:47.907278	\N	\N	208_6bbc4333	{"audio_option": "original", "speaker_count": null, "source_language": "en", "target_language": "zh-cn", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
217_217_d34aa897_6be18761	Test Project 0123b356	217	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 06:13:54.3933	2025-07-02 06:17:32.126684	\N	\N	217_d34aa897	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	3.62884175	f	{}	projects/217/217_217_d34aa897_6be18761/video_current.mp4
201_201_405e376c_e01c261c	Test Project 9d2914c5	201	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-01 09:17:20.323073	2025-07-01 09:26:48.284404	\N	\N	201_405e376c	{"audio_option": "original", "speaker_count": null, "source_language": "en", "target_language": "zh-cn", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	9.465980266666666	f	{}	projects/201/201_201_405e376c_e01c261c/video_current.mp4
214_214_c4a1ae3e_44296052	Test Project 79943744	214	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 04:41:22.308742	2025-07-02 04:41:48.731927	\N	\N	214_c4a1ae3e	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	0.44033336666666667	f	{}	projects/214/214_214_c4a1ae3e_44296052/video_current.mp4
192_192_a2cafd28_26845681	Test Project 40e84e8d	192	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-30 10:25:40.669167	2025-06-30 10:27:57.888192	\N	\N	192_a2cafd28	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	2.2868977	f	{}	projects/192/192_192_a2cafd28_26845681/video_current.mp4
185_185_c512f2ae_6c346bb8	Test Project e07aff37	185	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-30 09:22:55.610204	2025-06-30 09:24:56.36538	\N	\N	185_c512f2ae	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
223_223_d1845383_9fa1c2de	Test Project 230e727a	223	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-02 10:04:54.811987	2025-07-02 10:05:56.294001	\N	\N	223_d1845383	{"audio_option": "original", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.0246612333333334	f	{}	projects/223/223_223_d1845383_9fa1c2de/video_current.mp4
187_187_d6d6e8a4_982b2acc	Test Project 4bfc329e	187	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-30 10:02:31.640773	2025-06-30 10:05:00.653129	\N	\N	187_d6d6e8a4	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
186_186_97322cdc_4ad1db57	Test Project 4319fdb3	186	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-30 09:40:02.108747	2025-06-30 09:42:24.816687	\N	\N	186_97322cdc	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
188_188_faf9e0be_47f7b049	Test Project 4314b8b4	188	A test project initiated via /translate endpoint.	\N	FAILED	f	target	dubbed	2025-06-30 10:09:32.348109	2025-06-30 10:11:49.607902	\N	\N	188_faf9e0be	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	\N	f	{}	\N
191_191_b3fe8e4d_beeafd1a	Test Project dc4a3243	191	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-06-30 10:18:02.011144	2025-06-30 10:20:17.136424	\N	\N	191_b3fe8e4d	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	2.2520258500000003	f	{}	projects/191/191_191_b3fe8e4d_beeafd1a/video_current.mp4
242_242_1869cab9_b216095b	The Journey of Love for Mom	242		\N	PREPROCESSING	f	target	dubbed	2025-07-09 03:43:01.512234	2025-07-09 03:43:01.555179	\N	\N	242_1869cab9	{"audio_option": "premium", "speaker_count": 0, "source_language": "default", "target_language": "zh-cn", "allow_lip_syncing": false, "subtitles_enabled": "bilingual", "erase_original_subtitles": false}	{}	\N	\N	t	\N	f	{}	\N
193_193_7676ebb4_dc79ebeb	Test Project ccf592d5	193	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-01 01:26:06.944133	2025-07-01 01:28:24.567484	\N	\N	193_7676ebb4	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	2.2936798166666668	f	{}	projects/193/193_193_7676ebb4_dc79ebeb/video_current.mp4
166_166_cc467fe8_4c7bec7e	Lark20250626-224118	166		\N	COMPLETED	f	target	dubbed	2025-07-11 03:36:11.920938	2025-07-11 03:36:44.08059	\N	\N	166_cc467fe8	{"audio_option": "original", "speaker_count": 0, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "bilingual", "erase_original_subtitles": false}	{}	\N	\N	t	0.5359517833333334	f	{}	projects/166/166_166_cc467fe8_4c7bec7e/video_current.mp4
194_194_66645666_2b6545ff	Test Project 0819662c	194	A test project initiated via /translate endpoint.	\N	COMPLETED	f	target	dubbed	2025-07-01 01:47:42.254542	2025-07-01 01:49:36.779848	\N	\N	194_66645666	{"audio_option": "dubbed", "speaker_count": null, "source_language": "zh", "target_language": "en", "allow_lip_syncing": false, "subtitles_enabled": "target", "erase_original_subtitles": false}	{}	\N	\N	f	1.9086713166666667	f	{}	projects/194/194_194_66645666_2b6545ff/video_current.mp4
\.


--
-- Data for Name: project_segment_annotation; Type: TABLE DATA; Schema: public; Owner: curify
--

COPY public.project_segment_annotation (segment_id, project_id, line_number, original_annotated, speaker_annotated, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: projectsegment; Type: TABLE DATA; Schema: public; Owner: curify
--

COPY public.projectsegment (segment_id, project_id, line_number, start, "end", original, translated, speaker, post_edited, speed, target_duration, aligned_start, aligned_end, transcribed_scribe, transcribed_ocr, transcribed_fused, speaker_scribe, speaker_pyannote, speaker_fused, "translated_GPT", "translated_Azure", translated_fused, created_at, updated_at, video_id, original_updated, translated_updated) FROM stdin;
1	86_86_aa233465_700cefab	1	1.419	7.561	生命是如此美丽，自然界具有精致而复杂的结构，让成千上万的生物保持着微妙的平衡。	\N	speaker_0	\N	1.023	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-19 06:20:57.941859	2025-06-19 06:20:57.941877	86_aa233465	\N	\N
2	87_87_c1b873d0_ac5e1cf3	1	1.419	7.561	生命是如此美丽，自然界具有精致而复杂的结构，让成千上万的生物保持着微妙的平衡。	\N	speaker_0	\N	1.023	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-19 07:58:09.471068	2025-06-19 07:58:09.471087	87_c1b873d0	\N	\N
326	222_222_05247c17_4d9ccfcb	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 09:49:32.905477	2025-07-02 09:49:57.879984	222_05247c17	\N	Life is so beautiful.
137	180_180_ecb3cea5_8a4f3727	1	1.24	2.56	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-27 09:01:22.905111	2025-06-27 09:01:22.90514	180_ecb3cea5	\N	\N
138	180_180_ecb3cea5_8a4f3727	2	2.56	5.03	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-27 09:01:22.905896	2025-06-27 09:01:22.905914	180_ecb3cea5	\N	\N
139	180_180_ecb3cea5_8a4f3727	3	5.03	7.57	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-27 09:01:22.906196	2025-06-27 09:01:22.906212	180_ecb3cea5	\N	\N
149	193_193_7676ebb4_dc79ebeb	1	1.24	3.56	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 01:28:30.878809	2025-07-01 01:28:30.878834	193_7676ebb4	\N	\N
150	193_193_7676ebb4_dc79ebeb	2	3.56	7.41	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 01:28:30.879683	2025-07-01 01:28:30.879703	193_7676ebb4	\N	\N
151	193_193_7676ebb4_dc79ebeb	3	7.41	9.467	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 01:28:30.88	2025-07-01 01:28:30.880016	193_7676ebb4	\N	\N
18	168_168_f5aa4a46_228940bb	1	1.24	2.54	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 07:20:47.890239	2025-06-26 07:20:47.890268	168_f5aa4a46	\N	\N
19	168_168_f5aa4a46_228940bb	2	2.54	4.99	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 07:20:47.890832	2025-06-26 07:20:47.890849	168_f5aa4a46	\N	\N
20	168_168_f5aa4a46_228940bb	3	4.99	7.75	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 07:20:47.891126	2025-06-26 07:20:47.891142	168_f5aa4a46	\N	\N
21	169_169_6821aeaa_56843867	1	1.24	2.44	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 07:24:45.376695	2025-06-26 07:24:45.376723	169_6821aeaa	\N	\N
22	169_169_6821aeaa_56843867	2	2.44	4.91	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 07:24:45.377352	2025-06-26 07:24:45.377371	169_6821aeaa	\N	\N
23	169_169_6821aeaa_56843867	3	4.91	7.79	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 07:24:45.377675	2025-06-26 07:24:45.37769	169_6821aeaa	\N	\N
201	201_201_405e376c_e01c261c	14	30.439	32.48	Next is tornado caught in Kansas.	接下来是在堪萨斯州捕获的龙卷风。	speaker_0	Next is tornado caught in Kansas.	1.7	1.68	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.065461	2025-07-01 09:28:24.065473	201_405e376c	\N	\N
202	201_201_405e376c_e01c261c	15	36.439	38.9	It looked like it wasn't moving until it came running	它看起来好像没有动过，直到它开始运行	speaker_0	It looked like it wasn't moving until it came running	1.7	1.45	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.065708	2025-07-01 09:28:24.065721	201_405e376c	\N	\N
203	201_201_405e376c_e01c261c	16	38.979	39.679	towards you.	朝你。	speaker_0	towards you.	1.459	0.41	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.065952	2025-07-01 09:28:24.065965	201_405e376c	\N	\N
204	201_201_405e376c_e01c261c	17	39.719	41.939	Next is Hurricane Milton caught in Florida.	接下来是在佛罗里达州捕获的飓风米尔顿。	speaker_0	Next is Hurricane Milton caught in Florida.	1.7	1.71	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.066193	2025-07-01 09:28:24.066205	201_405e376c	\N	\N
205	201_201_405e376c_e01c261c	18	41.939	42.479	Tornado.	龙卷风。	speaker_2	Tornado.	1.299	0.62	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.066437	2025-07-01 09:28:24.066449	201_405e376c	\N	\N
206	201_201_405e376c_e01c261c	19	42.939	43.64	Tornado.	龙卷风。	speaker_2	Tornado.	1.243	0.64	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.066682	2025-07-01 09:28:24.066694	201_405e376c	\N	\N
207	201_201_405e376c_e01c261c	20	44.479	45.479	I told you guys.	我告诉过你们。	speaker_2	I told you guys.	1.55	0.9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.066918	2025-07-01 09:28:24.06693	201_405e376c	\N	\N
208	201_201_405e376c_e01c261c	21	45.84	48.86	This tornado is so fast and scary at the same time.	这场龙卷风既快速又可怕。	speaker_0	This tornado is so fast and scary at the same time.	1.7	1.09	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.067145	2025-07-01 09:28:24.067157	201_405e376c	\N	\N
209	201_201_405e376c_e01c261c	22	48.86	50.899	Next is tornado caught in Oklahoma.	接下来是在俄克拉荷马州捕获的龙卷风。	speaker_0	Next is tornado caught in Oklahoma.	1.7	1.81	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.067383	2025-07-01 09:28:24.067396	201_405e376c	\N	\N
210	201_201_405e376c_e01c261c	23	53.959	56.759	A tornado in the middle of the night means double fears,	半夜的龙卷风意味着双重恐惧，	speaker_0	A tornado in the middle of the night means double fears,	1.7	1.14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.067616	2025-07-01 09:28:24.067629	201_405e376c	\N	\N
211	201_201_405e376c_e01c261c	24	56.759	57.819	double everything.	加倍一切。	speaker_0	double everything.	1.626	0.62	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.067853	2025-07-01 09:28:24.067865	201_405e376c	\N	\N
216	202_202_62ebfd84_6209205f	5	8.539	10.9	But first, you'll have incredible luck tomorrow if	但首先，如果	speaker_0	But first, you'll have incredible luck tomorrow if	1.7	0.49	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.096089	2025-07-01 10:06:15.096105	202_62ebfd84	\N	\N
327	222_222_05247c17_4d9ccfcb	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 09:49:32.9059	2025-07-02 09:49:57.879989	222_05247c17	\N	Nature has a delicate and complex structure,
328	222_222_05247c17_4d9ccfcb	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 09:49:32.906107	2025-07-02 09:49:57.87999	222_05247c17	\N	Keep thousands of creatures in delicate balance.
30	170_170_d62cddd8_a71539a4	1	1.24	2.62	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 07:43:36.219069	2025-06-26 07:43:36.219096	170_d62cddd8	\N	\N
31	170_170_d62cddd8_a71539a4	2	2.62	4.89	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 07:43:36.219603	2025-06-26 07:43:36.219623	170_d62cddd8	\N	\N
32	170_170_d62cddd8_a71539a4	3	4.89	6.98	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 07:43:36.219923	2025-06-26 07:43:36.21994	170_d62cddd8	\N	\N
140	181_181_2e79af24_dc971dce	1	1.24	2.44	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-27 09:06:39.600605	2025-06-27 09:06:39.600633	181_2e79af24	\N	\N
141	181_181_2e79af24_dc971dce	2	2.44	4.91	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-27 09:06:39.601321	2025-06-27 09:06:39.601341	181_2e79af24	\N	\N
142	181_181_2e79af24_dc971dce	3	4.91	7.48	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-27 09:06:39.601957	2025-06-27 09:06:39.601992	181_2e79af24	\N	\N
152	194_194_66645666_2b6545ff	1	1.24	3.83	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 01:49:43.546289	2025-07-01 01:49:43.546318	194_66645666	\N	\N
153	194_194_66645666_2b6545ff	2	3.83	9.12	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 01:49:43.546699	2025-07-01 01:49:43.546714	194_66645666	\N	\N
154	194_194_66645666_2b6545ff	3	9.12	9.467	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 01:49:43.54695	2025-07-01 01:49:43.546964	194_66645666	\N	\N
164	200_200_d1cb7783_fe628ab0	1	0.099	1.759	These are the top five most dangerous tornadoes to	这些是前五名最危险的龙卷风	speaker_0	These are the top five most dangerous tornadoes to	1.7	1.07	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.532586	2025-07-01 08:44:24.53262	200_d1cb7783	\N	\N
165	200_200_d1cb7783_fe628ab0	2	1.759	2.699	ever strike the United States.	从来没有打击过美国。	speaker_0	ever strike the United States.	1.7	1.04	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.533456	2025-07-01 08:44:24.533474	200_d1cb7783	\N	\N
166	200_200_d1cb7783_fe628ab0	3	2.699	4.259	The last one happened once in a lifetime.	上一次发生在一生中一次。	speaker_0	The last one happened once in a lifetime.	1.7	1.05	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.533765	2025-07-01 08:44:24.533781	200_d1cb7783	\N	\N
167	200_200_d1cb7783_fe628ab0	4	4.259	5.629	Comment which one you think is the most terrifying.	评论你认为哪一个最可怕。	speaker_0	Comment which one you think is the most terrifying.	1.7	0.95	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.534062	2025-07-01 08:44:24.534077	200_d1cb7783	\N	\N
168	200_200_d1cb7783_fe628ab0	5	5.629	6.349	But first, you'll have incredible luck tomorrow if	但首先，如果	speaker_0	But first, you'll have incredible luck tomorrow if	1.7	0.49	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.534356	2025-07-01 08:44:24.534372	200_d1cb7783	\N	\N
169	200_200_d1cb7783_fe628ab0	6	6.349	7.769	you like and subscribe to my channel.	您喜欢并订阅我的频道。	speaker_0	you like and subscribe to my channel.	1.7	1.03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.534644	2025-07-01 08:44:24.534659	200_d1cb7783	\N	\N
170	200_200_d1cb7783_fe628ab0	7	7.769	9.589	First is tornado caught in Iowa.	首先是在爱荷华州捕获的龙卷风。	speaker_0	First is tornado caught in Iowa.	1.7	1.55	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.53493	2025-07-01 08:44:24.534945	200_d1cb7783	\N	\N
171	200_200_d1cb7783_fe628ab0	8	9.589	11.889	That tornado looked like a nightmare following you	那场龙卷风看起来就像一场噩梦跟着你	speaker_0	That tornado looked like a nightmare following you	1.7	1.37	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.535221	2025-07-01 08:44:24.535236	200_d1cb7783	\N	\N
172	200_200_d1cb7783_fe628ab0	9	11.889	12.589	into reality.	变为现实。	speaker_0	into reality.	1.451	0.69	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.53552	2025-07-01 08:44:24.535532	200_d1cb7783	\N	\N
173	200_200_d1cb7783_fe628ab0	10	12.589	14.289	Next is tornado caught in Lake City.	接下来是在湖城捕获的龙卷风。	speaker_0	Next is tornado caught in Lake City.	1.7	1.37	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.535773	2025-07-01 08:44:24.535787	200_d1cb7783	\N	\N
174	200_200_d1cb7783_fe628ab0	11	14.289	14.889	You have fear.	你有恐惧。	speaker_1	You have fear.	1.657	0.6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.536026	2025-07-01 08:44:24.536039	200_d1cb7783	\N	\N
175	200_200_d1cb7783_fe628ab0	12	14.889	15.849	Such a violent moment.	如此暴力的时刻。	speaker_0	Such a violent moment.	1.7	0.9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.536285	2025-07-01 08:44:24.536298	200_d1cb7783	\N	\N
329	222_222_05247c17_4d9ccfcb	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 09:50:05.798557	2025-07-02 09:50:05.798581	222_05247c17	\N	\N
330	222_222_05247c17_4d9ccfcb	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 09:50:05.798942	2025-07-02 09:50:05.798961	222_05247c17	\N	\N
331	222_222_05247c17_4d9ccfcb	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 09:50:05.799247	2025-07-02 09:50:05.799263	222_05247c17	\N	\N
131	178_178_30a4b372_bfda9345	1	1.24	2.56	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-27 08:37:49.933206	2025-06-27 08:37:49.933231	178_30a4b372	\N	\N
132	178_178_30a4b372_bfda9345	2	2.56	4.96	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-27 08:37:49.933773	2025-06-27 08:37:49.933791	178_30a4b372	\N	\N
133	178_178_30a4b372_bfda9345	3	4.96	7.79	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-27 08:37:49.934069	2025-06-27 08:37:49.934086	178_30a4b372	\N	\N
143	191_191_b3fe8e4d_beeafd1a	1	1.24	4.02	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-30 10:20:25.413689	2025-06-30 10:20:25.413713	191_b3fe8e4d	\N	\N
144	191_191_b3fe8e4d_beeafd1a	2	4.02	8.05	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-30 10:20:25.414424	2025-06-30 10:20:25.414442	191_b3fe8e4d	\N	\N
145	191_191_b3fe8e4d_beeafd1a	3	8.05	9.467	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-30 10:20:25.414735	2025-06-30 10:20:25.414751	191_b3fe8e4d	\N	\N
176	200_200_d1cb7783_fe628ab0	13	15.849	16.929	I hope everyone is okay.	我希望每个人都没事。	speaker_0	I hope everyone is okay.	1.7	1.13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.536532	2025-07-01 08:44:24.536544	200_d1cb7783	\N	\N
177	200_200_d1cb7783_fe628ab0	14	16.929	18.949	Next is tornado caught in Kansas.	接下来是在堪萨斯州捕获的龙卷风。	speaker_0	Next is tornado caught in Kansas.	1.7	1.68	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.536803	2025-07-01 08:44:24.536816	200_d1cb7783	\N	\N
178	200_200_d1cb7783_fe628ab0	15	18.949	21.299	It looked like it wasn't moving until it came running	它看起来好像没有动过，直到它开始运行	speaker_0	It looked like it wasn't moving until it came running	1.7	1.45	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.537059	2025-07-01 08:44:24.537072	200_d1cb7783	\N	\N
179	200_200_d1cb7783_fe628ab0	16	21.299	21.679	towards you.	朝你。	speaker_0	towards you.	1.459	0.41	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.537322	2025-07-01 08:44:24.537335	200_d1cb7783	\N	\N
180	200_200_d1cb7783_fe628ab0	17	21.679	24.179	Next is Hurricane Milton caught in Florida.	接下来是在佛罗里达州捕获的飓风米尔顿。	speaker_0	Next is Hurricane Milton caught in Florida.	1.7	1.71	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.537572	2025-07-01 08:44:24.537585	200_d1cb7783	\N	\N
181	200_200_d1cb7783_fe628ab0	18	24.179	24.639	Tornado.	龙卷风。	speaker_2	Tornado.	1.299	0.62	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.537826	2025-07-01 08:44:24.537839	200_d1cb7783	\N	\N
182	200_200_d1cb7783_fe628ab0	19	24.639	25.259	Tornado.	龙卷风。	speaker_2	Tornado.	1.243	0.64	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.538073	2025-07-01 08:44:24.538086	200_d1cb7783	\N	\N
183	200_200_d1cb7783_fe628ab0	20	25.259	26.119	I told you guys.	我告诉过你们。	speaker_2	I told you guys.	1.55	0.9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.538316	2025-07-01 08:44:24.538329	200_d1cb7783	\N	\N
184	200_200_d1cb7783_fe628ab0	21	26.119	27.659	This tornado is so fast and scary at the same time.	这场龙卷风既快速又可怕。	speaker_0	This tornado is so fast and scary at the same time.	1.7	1.09	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.538573	2025-07-01 08:44:24.538585	200_d1cb7783	\N	\N
185	200_200_d1cb7783_fe628ab0	22	27.659	29.819	Next is tornado caught in Oklahoma.	接下来是在俄克拉荷马州捕获的龙卷风。	speaker_0	Next is tornado caught in Oklahoma.	1.7	1.81	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.538825	2025-07-01 08:44:24.538838	200_d1cb7783	\N	\N
186	200_200_d1cb7783_fe628ab0	23	29.819	31.639	A tornado in the middle of the night means double fear,	半夜的龙卷风意味着双重恐惧，	speaker_0	A tornado in the middle of the night means double fear,	1.7	1.16	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.539071	2025-07-01 08:44:24.539084	200_d1cb7783	\N	\N
187	200_200_d1cb7783_fe628ab0	24	31.639	32.239	double everything.	加倍一切。	speaker_0	double everything.	1.626	0.62	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 08:44:24.539325	2025-07-01 08:44:24.539338	200_d1cb7783	\N	\N
212	202_202_62ebfd84_6209205f	1	0.099	2.459	These are the top five most dangerous tornadoes to	这些是前五名最危险的龙卷风	speaker_0	These are the top five most dangerous tornadoes to	1.7	1.07	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.094406	2025-07-01 10:06:15.094437	202_62ebfd84	\N	\N
213	202_202_62ebfd84_6209205f	2	2.659	4.339	ever strike the United States.	从来没有打击过美国。	speaker_0	ever strike the United States.	1.7	1.04	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.095194	2025-07-01 10:06:15.095213	202_62ebfd84	\N	\N
214	202_202_62ebfd84_6209205f	3	4.339	6.259	The last one happened once in a lifetime.	上一次发生在一生中一次。	speaker_0	The last one happened once in a lifetime.	1.7	1.05	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.095498	2025-07-01 10:06:15.095515	202_62ebfd84	\N	\N
215	202_202_62ebfd84_6209205f	4	6.319	8.539	Comment which one you think is the most terrifying.	评论你认为哪一个最可怕。	speaker_0	Comment which one you think is the most terrifying.	1.7	0.95	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.095795	2025-07-01 10:06:15.09581	202_62ebfd84	\N	\N
369	242_242_ec31e69d_ab0f0d65	2	4.11	7.82	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-10 05:45:06.906713	2025-07-10 05:45:06.906728	242_ec31e69d	\N	\N
370	242_242_ec31e69d_ab0f0d65	3	7.82	9.467	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-10 05:45:06.90697	2025-07-10 05:45:06.906984	242_ec31e69d	\N	\N
134	179_179_4865820b_3a1d4072	1	1.24	2.58	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-27 08:44:47.356344	2025-06-27 08:44:47.356374	179_4865820b	\N	\N
135	179_179_4865820b_3a1d4072	2	2.58	5.05	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-27 08:44:47.357097	2025-06-27 08:44:47.357115	179_4865820b	\N	\N
136	179_179_4865820b_3a1d4072	3	5.05	7.79	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-27 08:44:47.35741	2025-06-27 08:44:47.357426	179_4865820b	\N	\N
146	192_192_a2cafd28_26845681	1	1.24	3.88	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-30 10:28:04.377087	2025-06-30 10:28:04.377111	192_a2cafd28	\N	\N
147	192_192_a2cafd28_26845681	2	3.88	7.82	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-30 10:28:04.377792	2025-06-30 10:28:04.37781	192_a2cafd28	\N	\N
148	192_192_a2cafd28_26845681	3	7.82	9.467	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-30 10:28:04.378106	2025-06-30 10:28:04.378122	192_a2cafd28	\N	\N
78	172_172_be083c95_007d863f	1	1.24	2.58	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 12:49:30.476349	2025-06-26 12:49:30.47638	172_be083c95	\N	\N
79	172_172_be083c95_007d863f	2	2.58	5.05	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 12:49:30.477062	2025-06-26 12:49:30.477083	172_be083c95	\N	\N
80	172_172_be083c95_007d863f	3	5.05	7.83	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 12:49:30.477437	2025-06-26 12:49:30.477453	172_be083c95	\N	\N
81	173_173_c6269ac9_f885c40f	1	1.24	6.59	生命是如此美丽，自然界具有精致而复杂的结构，让成	Life is so beautiful that nature has a delicate and complex structure that gives way	speaker_0	生命是如此美丽，自然界具有精致而复杂的结构，让成	0.958	17.53	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 13:04:24.935066	2025-06-26 13:04:24.935091	173_c6269ac9	\N	\N
82	173_173_c6269ac9_f885c40f	2	6.59	9.467	千上万的生物保持着微妙的平衡。	Thousands of creatures maintain a delicate balance.	speaker_0	千上万的生物保持着微妙的平衡。	1.071	9.52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 13:04:24.935631	2025-06-26 13:04:24.935648	173_c6269ac9	\N	\N
83	174_174_9098c1d3_5f8b5704	1	1.24	2.58	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 13:16:31.683666	2025-06-26 13:16:31.683697	174_9098c1d3	\N	\N
84	174_174_9098c1d3_5f8b5704	2	2.58	5	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 13:16:31.684368	2025-06-26 13:16:31.684389	174_9098c1d3	\N	\N
85	174_174_9098c1d3_5f8b5704	3	5	7.74	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 13:16:31.684716	2025-06-26 13:16:31.684732	174_9098c1d3	\N	\N
86	177_177_ced6d062_340b436a	1	1.24	2.58	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	1	4.2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 14:34:17.914909	2025-06-26 14:34:17.914934	177_ced6d062	\N	\N
87	177_177_ced6d062_340b436a	2	2.58	5	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	1.137	7.74	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 14:34:17.915501	2025-06-26 14:34:17.915519	177_ced6d062	\N	\N
88	177_177_ced6d062_340b436a	3	5	7.86	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	8.91	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-06-26 14:34:17.9158	2025-06-26 14:34:17.915816	177_ced6d062	\N	\N
188	201_201_405e376c_e01c261c	1	0.099	2.459	These are the top five most dangerous tornadoes to	这些是前五名最危险的龙卷风	speaker_0	These are the top five most dangerous tornadoes to	1.7	1.07	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.061644	2025-07-01 09:28:24.061668	201_405e376c	\N	\N
189	201_201_405e376c_e01c261c	2	2.659	4.339	ever strike the United States.	从来没有打击过美国。	speaker_0	ever strike the United States.	1.7	1.04	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.06241	2025-07-01 09:28:24.062428	201_405e376c	\N	\N
190	201_201_405e376c_e01c261c	3	4.339	6.259	The last one happened once in a lifetime.	上一次发生在一生中一次。	speaker_0	The last one happened once in a lifetime.	1.7	1.05	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.062709	2025-07-01 09:28:24.062725	201_405e376c	\N	\N
191	201_201_405e376c_e01c261c	4	6.319	8.539	Comment which one you think is the most terrifying.	评论你认为哪一个最可怕。	speaker_0	Comment which one you think is the most terrifying.	1.7	0.95	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.062998	2025-07-01 09:28:24.063012	201_405e376c	\N	\N
192	201_201_405e376c_e01c261c	5	8.539	10.9	But first, you'll have incredible luck tomorrow if	但首先，如果	speaker_0	But first, you'll have incredible luck tomorrow if	1.7	0.49	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.063281	2025-07-01 09:28:24.063296	201_405e376c	\N	\N
193	201_201_405e376c_e01c261c	6	10.939	12.799	you like and subscribe to my channel.	您喜欢并订阅我的频道。	speaker_0	you like and subscribe to my channel.	1.7	1.03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.063588	2025-07-01 09:28:24.063601	201_405e376c	\N	\N
194	201_201_405e376c_e01c261c	7	12.859	14.719	First is tornado caught in Iowa.	首先是在爱荷华州捕获的龙卷风。	speaker_0	First is tornado caught in Iowa.	1.7	1.55	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.063822	2025-07-01 09:28:24.063834	201_405e376c	\N	\N
195	201_201_405e376c_e01c261c	8	18.399	20.639	That tornado looked like a nightmare following you	那场龙卷风看起来就像一场噩梦跟着你	speaker_0	That tornado looked like a nightmare following you	1.7	1.37	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.064054	2025-07-01 09:28:24.064066	201_405e376c	\N	\N
196	201_201_405e376c_e01c261c	9	20.659	21.519	into reality.	变为现实。	speaker_0	into reality.	1.451	0.69	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.064283	2025-07-01 09:28:24.064295	201_405e376c	\N	\N
197	201_201_405e376c_e01c261c	10	21.619	23.619	Next is tornado caught in Lake City.	接下来是在湖城捕获的龙卷风。	speaker_0	Next is tornado caught in Lake City.	1.7	1.37	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.06453	2025-07-01 09:28:24.064543	201_405e376c	\N	\N
198	201_201_405e376c_e01c261c	11	25.5	26	You have fear.	你有恐惧。	speaker_1	You have fear.	1.657	0.6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.064759	2025-07-01 09:28:24.064772	201_405e376c	\N	\N
199	201_201_405e376c_e01c261c	12	27.799	28.939	Such a violent moment.	如此暴力的时刻。	speaker_0	Such a violent moment.	1.7	0.9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.064989	2025-07-01 09:28:24.065001	201_405e376c	\N	\N
200	201_201_405e376c_e01c261c	13	28.939	30.36	I hope everyone is okay.	我希望每个人都没事。	speaker_0	I hope everyone is okay.	1.7	1.13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 09:28:24.06522	2025-07-01 09:28:24.065232	201_405e376c	\N	\N
217	202_202_62ebfd84_6209205f	6	10.939	12.799	you like and subscribe to my channel.	您喜欢并订阅我的频道。	speaker_0	you like and subscribe to my channel.	1.7	1.03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.096382	2025-07-01 10:06:15.096397	202_62ebfd84	\N	\N
218	202_202_62ebfd84_6209205f	7	12.859	14.719	First is tornado caught in Iowa.	首先是在爱荷华州捕获的龙卷风。	speaker_0	First is tornado caught in Iowa.	1.7	1.55	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.096748	2025-07-01 10:06:15.096763	202_62ebfd84	\N	\N
219	202_202_62ebfd84_6209205f	8	18.399	20.639	That tornado looked like a nightmare following you	那场龙卷风看起来就像一场噩梦跟着你	speaker_0	That tornado looked like a nightmare following you	1.7	1.37	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.097278	2025-07-01 10:06:15.097296	202_62ebfd84	\N	\N
220	202_202_62ebfd84_6209205f	9	20.659	21.519	into reality.	变为现实。	speaker_0	into reality.	1.451	0.69	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.097568	2025-07-01 10:06:15.097582	202_62ebfd84	\N	\N
221	202_202_62ebfd84_6209205f	10	21.619	23.619	Next is tornado caught in Lake City.	接下来是在湖城捕获的龙卷风。	speaker_0	Next is tornado caught in Lake City.	1.7	1.37	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.097832	2025-07-01 10:06:15.097846	202_62ebfd84	\N	\N
222	202_202_62ebfd84_6209205f	11	25.5	26	You have fear.	你有恐惧。	speaker_1	You have fear.	1.657	0.6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.09809	2025-07-01 10:06:15.098104	202_62ebfd84	\N	\N
223	202_202_62ebfd84_6209205f	12	27.799	28.939	Such a violent moment.	如此暴力的时刻。	speaker_0	Such a violent moment.	1.7	0.9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.098344	2025-07-01 10:06:15.098358	202_62ebfd84	\N	\N
224	202_202_62ebfd84_6209205f	13	28.939	30.36	I hope everyone is okay.	我希望每个人都没事。	speaker_0	I hope everyone is okay.	1.7	1.13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.098598	2025-07-01 10:06:15.098611	202_62ebfd84	\N	\N
225	202_202_62ebfd84_6209205f	14	30.439	32.48	Next is tornado caught in Kansas.	接下来是在堪萨斯州捕获的龙卷风。	speaker_0	Next is tornado caught in Kansas.	1.7	1.68	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.098848	2025-07-01 10:06:15.098861	202_62ebfd84	\N	\N
226	202_202_62ebfd84_6209205f	15	36.439	38.9	It looked like it wasn't moving until it came running	它看起来好像没有动过，直到它开始运行	speaker_0	It looked like it wasn't moving until it came running	1.7	1.45	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.099097	2025-07-01 10:06:15.09911	202_62ebfd84	\N	\N
227	202_202_62ebfd84_6209205f	16	38.979	39.679	towards you.	朝你。	speaker_0	towards you.	1.459	0.41	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.099347	2025-07-01 10:06:15.09936	202_62ebfd84	\N	\N
228	202_202_62ebfd84_6209205f	17	39.719	41.939	Next is Hurricane Milton caught in Florida.	接下来是在佛罗里达州捕获的飓风米尔顿。	speaker_0	Next is Hurricane Milton caught in Florida.	1.7	1.71	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.099597	2025-07-01 10:06:15.09961	202_62ebfd84	\N	\N
229	202_202_62ebfd84_6209205f	18	41.939	42.479	Tornado.	龙卷风。	speaker_2	Tornado.	1.299	0.62	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.099842	2025-07-01 10:06:15.099861	202_62ebfd84	\N	\N
230	202_202_62ebfd84_6209205f	19	42.939	43.64	Tornado.	龙卷风。	speaker_2	Tornado.	1.243	0.64	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.100096	2025-07-01 10:06:15.100109	202_62ebfd84	\N	\N
231	202_202_62ebfd84_6209205f	20	44.479	45.479	I told you guys.	我告诉过你们。	speaker_2	I told you guys.	1.55	0.9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.100341	2025-07-01 10:06:15.100354	202_62ebfd84	\N	\N
232	202_202_62ebfd84_6209205f	21	45.84	48.86	This tornado is so fast and scary at the same time.	这场龙卷风既快速又可怕。	speaker_0	This tornado is so fast and scary at the same time.	1.7	1.09	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.100604	2025-07-01 10:06:15.100617	202_62ebfd84	\N	\N
233	202_202_62ebfd84_6209205f	22	48.86	50.899	Next is tornado caught in Oklahoma.	接下来是在俄克拉荷马州捕获的龙卷风。	speaker_0	Next is tornado caught in Oklahoma.	1.7	1.81	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.100859	2025-07-01 10:06:15.100872	202_62ebfd84	\N	\N
234	202_202_62ebfd84_6209205f	23	53.959	56.739	A tornado in the middle of the night means double fear,	半夜的龙卷风意味着双重恐惧，	speaker_0	A tornado in the middle of the night means double fear,	1.7	1.16	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.101105	2025-07-01 10:06:15.101118	202_62ebfd84	\N	\N
235	202_202_62ebfd84_6209205f	24	56.759	57.819	double everything.	加倍一切。	speaker_0	double everything.	1.626	0.62	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-01 10:06:15.101363	2025-07-01 10:06:15.101376	202_62ebfd84	\N	\N
332	223_223_d1845383_9fa1c2de	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 10:05:27.596128	2025-07-02 10:05:55.070801	223_d1845383	\N	Life is so beautiful.
333	223_223_d1845383_9fa1c2de	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 10:05:27.596816	2025-07-02 10:05:55.070805	223_d1845383	\N	Nature has a delicate and complex structure,
334	223_223_d1845383_9fa1c2de	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 10:05:27.597142	2025-07-02 10:05:55.070806	223_d1845383	\N	Keep thousands of creatures in delicate balance.
368	242_242_ec31e69d_ab0f0d65	1	1.24	4.11	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-10 05:45:06.906103	2025-07-10 07:43:17.81028	242_ec31e69d	生命是如此美丽。	Life is really beautiful.
335	223_223_d1845383_9fa1c2de	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 10:06:01.01212	2025-07-02 10:06:01.012139	223_d1845383	\N	\N
336	223_223_d1845383_9fa1c2de	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 10:06:01.012419	2025-07-02 10:06:01.012433	223_d1845383	\N	\N
337	223_223_d1845383_9fa1c2de	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 10:06:01.012651	2025-07-02 10:06:01.012663	223_d1845383	\N	\N
371	166_166_cc467fe8_4c7bec7e	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-11 03:36:48.142231	2025-07-11 03:36:48.142257	166_cc467fe8	\N	\N
372	166_166_cc467fe8_4c7bec7e	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-11 03:36:48.142972	2025-07-11 03:36:48.142993	166_cc467fe8	\N	\N
373	166_166_cc467fe8_4c7bec7e	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-11 03:36:48.143321	2025-07-11 03:36:48.143336	166_cc467fe8	\N	\N
260	209_209_20f8d395_0598a840	1	1.24	2.84	生命是如此美丽。	生命是如此美丽。	speaker_0	生命是如此美丽。	1	1.6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:01:11.414763	2025-07-02 04:01:11.414786	209_20f8d395	\N	\N
261	209_209_20f8d395_0598a840	2	3.599	5.699	自然界具有精致而复杂的结构,	自然界具有精致而复杂的结构,	speaker_0	自然界具有精致而复杂的结构,	1.137	2.46	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:01:11.415333	2025-07-02 04:01:11.41535	209_20f8d395	\N	\N
262	209_209_20f8d395_0598a840	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	让成千上万的生物保持着微妙的平衡。	speaker_0	让成千上万的生物保持着微妙的平衡。	1.077	3.16	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:01:11.415628	2025-07-02 04:01:11.415644	209_20f8d395	\N	\N
263	210_210_185eef1d_928908be	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:03:20.355111	2025-07-02 04:03:20.355142	210_185eef1d	\N	\N
264	210_210_185eef1d_928908be	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:03:20.35586	2025-07-02 04:03:20.355878	210_185eef1d	\N	\N
265	210_210_185eef1d_928908be	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:03:20.35617	2025-07-02 04:03:20.356186	210_185eef1d	\N	\N
266	211_211_f89736c8_a39bd6d6	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:13:35.764927	2025-07-02 04:13:35.76495	211_f89736c8	\N	\N
267	211_211_f89736c8_a39bd6d6	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:13:35.76553	2025-07-02 04:13:35.765547	211_f89736c8	\N	\N
268	211_211_f89736c8_a39bd6d6	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:13:35.765827	2025-07-02 04:13:35.765843	211_f89736c8	\N	\N
269	212_212_a09faf66_99030364	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:21:03.974403	2025-07-02 04:21:03.974426	212_a09faf66	\N	\N
270	212_212_a09faf66_99030364	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:21:03.974981	2025-07-02 04:21:03.974999	212_a09faf66	\N	\N
271	212_212_a09faf66_99030364	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:21:03.975273	2025-07-02 04:21:03.97529	212_a09faf66	\N	\N
272	213_213_7cb09526_1febaed3	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:24:40.474795	2025-07-02 04:24:40.474817	213_7cb09526	\N	\N
273	213_213_7cb09526_1febaed3	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:24:40.475394	2025-07-02 04:24:40.475412	213_7cb09526	\N	\N
274	213_213_7cb09526_1febaed3	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:24:40.475695	2025-07-02 04:24:40.475711	213_7cb09526	\N	\N
275	214_214_c4a1ae3e_44296052	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:41:53.667314	2025-07-02 04:41:53.667337	214_c4a1ae3e	\N	\N
276	214_214_c4a1ae3e_44296052	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:41:53.667896	2025-07-02 04:41:53.667914	214_c4a1ae3e	\N	\N
277	214_214_c4a1ae3e_44296052	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 04:41:53.668204	2025-07-02 04:41:53.668221	214_c4a1ae3e	\N	\N
279	215_215_e09ac43d_cdf5f13a	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 05:06:31.166924	2025-07-02 05:06:31.166942	215_e09ac43d	\N	\N
280	215_215_e09ac43d_cdf5f13a	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 05:06:31.167225	2025-07-02 05:06:31.167242	215_e09ac43d	\N	\N
278	215_215_e09ac43d_cdf5f13a	1	1.24	2.84	生命是如此美丽。	test	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 05:06:31.166344	2025-07-02 05:34:43.849447	215_e09ac43d	\N	\N
285	216_216_6d5663a6_fb280b9a	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 05:36:31.032751	2025-07-02 05:36:31.032772	216_6d5663a6	\N	\N
286	216_216_6d5663a6_fb280b9a	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 05:36:31.033124	2025-07-02 05:36:31.033141	216_6d5663a6	\N	\N
338	225_225_1cc1a481_1527e1c2	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 10:32:47.502315	2025-07-02 10:33:16.015865	225_1cc1a481	\N	Life is very very beautiful.
339	225_225_1cc1a481_1527e1c2	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 10:32:47.502902	2025-07-02 10:33:16.015867	225_1cc1a481	\N	Nature has a delicate and complex structure,
340	225_225_1cc1a481_1527e1c2	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 10:32:47.503208	2025-07-02 10:33:16.015868	225_1cc1a481	\N	Keep thousands of creatures in delicate balance.
284	216_216_6d5663a6_fb280b9a	1	1.24	2.84	Original text	Test	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 05:36:31.032029	2025-07-02 05:45:39.444974	216_6d5663a6	\N	\N
374	249_249_b8bf6681_a8df10b4	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-11 10:57:40.372866	2025-07-11 10:58:05.244098	249_b8bf6681	\N	Life is very very beautiful.
375	249_249_b8bf6681_a8df10b4	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-11 10:57:40.373438	2025-07-11 10:58:05.244103	249_b8bf6681	\N	Nature has a delicate and complex structure,
376	249_249_b8bf6681_a8df10b4	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-11 10:57:40.373738	2025-07-11 10:58:05.244103	249_b8bf6681	\N	Keep thousands of creatures in delicate balance.
293	217_217_d34aa897_6be18761	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 06:14:35.257376	2025-07-02 06:14:35.257399	217_d34aa897	\N	\N
294	217_217_d34aa897_6be18761	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 06:14:35.25798	2025-07-02 06:14:35.257998	217_d34aa897	\N	\N
295	217_217_d34aa897_6be18761	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 06:14:35.258285	2025-07-02 06:14:35.258302	217_d34aa897	\N	\N
359	234_234_cffd70a1_d213f67a	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-08 07:51:47.311369	2025-07-08 07:52:03.907952	234_cffd70a1	\N	Life is very very beautiful.
360	234_234_cffd70a1_d213f67a	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-08 07:51:47.311931	2025-07-08 07:52:03.907956	234_cffd70a1	\N	Nature has a delicate and complex structure,
361	234_234_cffd70a1_d213f67a	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-08 07:51:47.312222	2025-07-08 07:52:03.907974	234_cffd70a1	\N	Keep thousands of creatures in delicate balance.
317	219_219_510641f4_540df1c5	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 08:15:00.217836	2025-07-02 08:15:00.217859	219_510641f4	\N	\N
318	219_219_510641f4_540df1c5	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 08:15:00.218424	2025-07-02 08:15:00.218488	219_510641f4	\N	\N
319	219_219_510641f4_540df1c5	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 08:15:00.218811	2025-07-02 08:15:00.218829	219_510641f4	\N	\N
320	220_220_473a124c_352f6a35	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 09:22:55.454252	2025-07-02 09:22:55.45427	220_473a124c	\N	\N
321	220_220_473a124c_352f6a35	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 09:22:55.454549	2025-07-02 09:22:55.454562	220_473a124c	\N	\N
322	220_220_473a124c_352f6a35	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 09:22:55.454785	2025-07-02 09:22:55.454798	220_473a124c	\N	\N
323	221_221_24470de5_8742e5b4	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 09:30:07.975846	2025-07-02 09:30:28.858666	221_24470de5	\N	Life is so beautiful.
324	221_221_24470de5_8742e5b4	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 09:30:07.976371	2025-07-02 09:30:28.858669	221_24470de5	\N	Nature has a delicate and complex structure,
325	221_221_24470de5_8742e5b4	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-02 09:30:07.976629	2025-07-02 09:30:28.858669	221_24470de5	\N	Keep thousands of creatures in delicate balance.
362	239_239_edfd256e_7d7deafd	1	1.24	2.84	生命是如此美丽。	Life is so beautiful.	speaker_0	生命是如此美丽。	0.85	4.94	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-08 09:54:04.898908	2025-07-08 09:54:35.462326	239_edfd256e	\N	Life is very very beautiful.
363	239_239_edfd256e_7d7deafd	2	3.599	5.699	自然界具有精致而复杂的结构,	Nature has a delicate and complex structure,	speaker_0	自然界具有精致而复杂的结构,	0.967	9.1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-08 09:54:04.899384	2025-07-08 09:54:35.462329	239_edfd256e	\N	Nature has a delicate and complex structure,
364	239_239_edfd256e_7d7deafd	3	6.019	8.959	让成千上万的生物保持着微妙的平衡。	Keep thousands of creatures in delicate balance.	speaker_0	让成千上万的生物保持着微妙的平衡。	0.916	10.48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-08 09:54:04.899628	2025-07-08 09:54:35.46233	239_edfd256e	\N	Keep thousands of creatures in delicate balance.
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: public; Owner: curify
--

COPY public.subscription (subscription_id, user_id, plan_id, start_date, end_date, is_active, created_at, updated_at, plan_name) FROM stdin;
3	26	2	2025-06-18	2025-07-18	t	2025-06-18 10:13:09.076373	2025-06-18 10:13:09.076389	\N
4	28	2	2025-06-18	2025-07-18	t	2025-06-18 10:21:42.189612	2025-06-18 10:21:42.189628	Pro
5	29	2	2025-06-18	2025-06-18	f	2025-06-18 10:32:27.275917	2025-06-18 10:32:27.319008	Pro
6	30	2	2025-06-18	2025-06-18	f	2025-06-18 10:33:38.590481	2025-06-18 10:33:38.635155	Pro
7	31	2	2025-06-18	2025-06-18	f	2025-06-18 10:37:16.546658	2025-06-18 10:37:16.593084	Pro
8	32	2	2025-06-18	2025-06-18	f	2025-06-18 10:40:10.887255	2025-06-18 10:40:10.928772	Pro
9	33	2	2025-06-18	2025-06-18	f	2025-06-18 10:47:52.425264	2025-06-18 10:47:52.465401	Pro
10	34	2	2025-06-18	2025-06-18	f	2025-06-18 10:54:22.659861	2025-06-18 10:54:22.71296	Pro
11	35	2	2025-06-18	2025-06-18	f	2025-06-18 11:00:45.410045	2025-06-18 11:00:45.457297	Pro
12	36	2	2025-06-18	2025-06-18	f	2025-06-18 11:07:29.0916	2025-06-18 11:07:29.135023	Pro
13	37	2	2025-06-18	2025-06-18	f	2025-06-18 11:35:26.493904	2025-06-18 11:35:26.541144	Pro
14	38	2	2025-06-18	2025-06-18	f	2025-06-18 11:59:23.492842	2025-06-18 11:59:23.539281	Pro
15	39	2	2025-06-18	2025-06-18	f	2025-06-18 12:01:19.862586	2025-06-18 12:01:19.908395	Pro
16	40	2	2025-06-18	2025-06-18	f	2025-06-18 12:08:13.448212	2025-06-18 12:08:13.503007	Pro
17	41	2	2025-06-18	2025-06-18	f	2025-06-18 12:19:11.387581	2025-06-18 12:19:11.429357	Pro
18	42	2	2025-06-18	2025-06-18	f	2025-06-18 12:25:56.314721	2025-06-18 12:25:56.357063	Pro
19	43	2	2025-06-18	2025-06-18	f	2025-06-18 12:26:54.030765	2025-06-18 12:26:54.076744	Pro
20	44	2	2025-06-18	2025-06-18	f	2025-06-18 12:33:16.089946	2025-06-18 12:33:16.138113	Pro
21	45	2	2025-06-18	2025-06-18	f	2025-06-18 12:38:09.580259	2025-06-18 12:38:09.627991	Pro
22	46	2	2025-06-18	2025-06-18	f	2025-06-18 12:38:59.318543	2025-06-18 12:38:59.356518	Pro
23	47	2	2025-06-18	2025-06-18	f	2025-06-18 12:55:13.272588	2025-06-18 12:55:13.316966	Pro
24	48	2	2025-06-18	2025-06-18	f	2025-06-18 12:56:49.077857	2025-06-18 12:56:49.126841	Pro
25	49	2	2025-06-18	2025-06-18	f	2025-06-18 12:57:38.434126	2025-06-18 12:57:38.476905	Pro
26	50	2	2025-06-18	2025-06-18	f	2025-06-18 13:04:35.627829	2025-06-18 13:04:35.663874	Pro
27	51	2	2025-06-18	2025-06-18	f	2025-06-18 13:11:15.167154	2025-06-18 13:11:15.213923	Pro
28	52	2	2025-06-18	2025-06-18	f	2025-06-18 14:39:41.743225	2025-06-18 14:39:41.787855	Pro
29	53	2	2025-06-18	2025-06-18	f	2025-06-18 14:45:38.836571	2025-06-18 14:45:38.880403	Pro
30	54	2	2025-06-18	2025-06-18	f	2025-06-18 14:47:20.030741	2025-06-18 14:47:20.086135	Pro
31	55	2	2025-06-18	2025-06-18	f	2025-06-18 14:48:17.510281	2025-06-18 14:48:17.55345	Pro
32	56	2	2025-06-18	2025-06-18	f	2025-06-18 14:58:47.17768	2025-06-18 14:58:47.225494	Pro
33	57	2	2025-06-18	2025-06-18	f	2025-06-18 14:59:27.213904	2025-06-18 14:59:27.260044	Pro
34	58	2	2025-06-18	2025-06-18	f	2025-06-18 15:01:24.383416	2025-06-18 15:01:24.428995	Pro
35	59	2	2025-06-18	2025-06-18	f	2025-06-18 15:04:16.225997	2025-06-18 15:04:16.272015	Pro
36	60	2	2025-06-18	2025-06-18	f	2025-06-18 15:05:45.150938	2025-06-18 15:05:45.19898	Pro
37	61	2	2025-06-18	2025-06-18	f	2025-06-18 15:07:45.786023	2025-06-18 15:07:45.835636	Pro
38	62	2	2025-06-18	2025-06-18	f	2025-06-18 15:10:52.287622	2025-06-18 15:10:52.332551	Pro
39	63	2	2025-06-18	2025-06-18	f	2025-06-18 15:13:34.85982	2025-06-18 15:13:34.915891	Pro
40	64	2	2025-06-18	2025-06-18	f	2025-06-18 15:14:56.457634	2025-06-18 15:14:56.496128	Pro
41	65	2	2025-06-18	2025-06-18	f	2025-06-18 15:16:35.03244	2025-06-18 15:16:35.135088	Pro
42	66	2	2025-06-18	2025-06-18	f	2025-06-18 15:25:42.855005	2025-06-18 15:25:42.900882	Pro
43	67	2	2025-06-18	2025-06-18	f	2025-06-18 15:27:29.048264	2025-06-18 15:27:29.114979	Pro
44	68	2	2025-06-18	2025-06-18	f	2025-06-18 15:28:50.678786	2025-06-18 15:28:50.744045	Pro
45	69	2	2025-06-18	2025-06-18	f	2025-06-18 15:30:09.692865	2025-06-18 15:30:09.742192	Pro
46	70	2	2025-06-18	2025-06-18	f	2025-06-18 15:36:07.966132	2025-06-18 15:36:08.015588	Pro
47	71	2	2025-06-18	2025-06-18	f	2025-06-18 15:38:45.70371	2025-06-18 15:38:45.75219	Pro
48	73	2	2025-06-19	2025-06-19	f	2025-06-18 16:03:47.931815	2025-06-18 16:03:48.276981	Pro
49	74	2	2025-06-19	2025-06-19	f	2025-06-19 00:23:03.652024	2025-06-19 00:23:03.705623	Pro
50	75	2	2025-06-19	2025-06-19	f	2025-06-19 00:36:53.773422	2025-06-19 00:36:53.82125	Pro
51	76	2	2025-06-19	2025-06-19	f	2025-06-19 01:18:00.900745	2025-06-19 01:18:00.944581	Pro
52	77	2	2025-06-19	2025-06-19	f	2025-06-19 01:30:17.600446	2025-06-19 01:30:17.64385	Pro
53	78	2	2025-06-19	2025-06-19	f	2025-06-19 01:46:25.065525	2025-06-19 01:46:25.113227	Pro
54	79	2	2025-06-19	2025-06-19	f	2025-06-19 03:04:06.111356	2025-06-19 03:04:06.196998	Pro
55	80	2	2025-06-19	2025-06-19	f	2025-06-19 04:06:43.431147	2025-06-19 04:06:43.505176	Pro
56	81	2	2025-06-19	2025-06-19	f	2025-06-19 04:17:03.919788	2025-06-19 04:17:03.980422	Pro
57	82	2	2025-06-19	2025-06-19	f	2025-06-19 04:26:05.827011	2025-06-19 04:26:05.970517	Pro
58	83	2	2025-06-19	2025-06-19	f	2025-06-19 05:02:22.856301	2025-06-19 05:02:22.911165	Pro
59	86	2	2025-06-19	2025-06-19	f	2025-06-19 06:20:19.540047	2025-06-19 06:20:19.582681	Pro
60	87	2	2025-06-19	2025-06-19	f	2025-06-19 07:54:26.09632	2025-06-19 07:54:26.14492	Pro
61	88	2	2025-06-20	2025-06-20	f	2025-06-20 11:33:09.004523	2025-06-20 11:33:09.051988	Pro
62	89	2	2025-06-21	2025-06-21	f	2025-06-21 09:12:05.357676	2025-06-21 09:12:05.419477	Pro
63	90	2	2025-06-21	2025-06-21	f	2025-06-21 09:31:31.505916	2025-06-21 09:31:31.614533	Pro
64	91	2	2025-06-21	2025-06-21	f	2025-06-21 09:37:24.639676	2025-06-21 09:37:24.68007	Pro
65	92	2	2025-06-21	2025-06-21	f	2025-06-21 09:44:44.515663	2025-06-21 09:44:44.564635	Pro
66	93	2	2025-06-21	2025-06-21	f	2025-06-21 09:51:26.891891	2025-06-21 09:51:26.940189	Pro
67	94	2	2025-06-21	2025-06-21	f	2025-06-21 10:01:23.472695	2025-06-21 10:01:23.555573	Pro
68	95	2	2025-06-21	2025-06-21	f	2025-06-21 10:34:46.745261	2025-06-21 10:34:46.802001	Pro
69	96	2	2025-06-21	2025-06-21	f	2025-06-21 10:46:38.799571	2025-06-21 10:46:38.844305	Pro
70	97	2	2025-06-21	2025-06-21	f	2025-06-21 11:10:47.811033	2025-06-21 11:10:47.87562	Pro
71	98	2	2025-06-21	2025-06-21	f	2025-06-21 11:16:03.421762	2025-06-21 11:16:03.467478	Pro
72	99	2	2025-06-21	2025-06-21	f	2025-06-21 11:19:20.051053	2025-06-21 11:19:20.095492	Pro
73	100	2	2025-06-21	2025-06-21	f	2025-06-21 11:22:25.952547	2025-06-21 11:22:25.994593	Pro
74	101	2	2025-06-21	2025-06-21	f	2025-06-21 11:33:38.535794	2025-06-21 11:33:38.581934	Pro
75	102	2	2025-06-21	2025-06-21	f	2025-06-21 11:44:38.625123	2025-06-21 11:44:38.675523	Pro
76	103	2	2025-06-21	2025-06-21	f	2025-06-21 11:53:55.295253	2025-06-21 11:53:55.338856	Pro
77	104	2	2025-06-21	2025-06-21	f	2025-06-21 11:56:07.22998	2025-06-21 11:56:07.270971	Pro
78	105	2	2025-06-21	2025-06-21	f	2025-06-21 12:03:23.82346	2025-06-21 12:03:23.867691	Pro
79	106	2	2025-06-21	2025-06-21	f	2025-06-21 12:18:12.103793	2025-06-21 12:18:12.164829	Pro
80	107	2	2025-06-21	2025-06-21	f	2025-06-21 12:27:10.407124	2025-06-21 12:27:10.471938	Pro
81	108	2	2025-06-22	2025-06-22	f	2025-06-22 11:12:53.623043	2025-06-22 11:12:53.732408	Pro
82	109	2	2025-06-22	2025-06-22	f	2025-06-22 11:34:18.255403	2025-06-22 11:34:18.304908	Pro
83	110	2	2025-06-22	2025-06-22	f	2025-06-22 11:43:19.316891	2025-06-22 11:43:19.358506	Pro
84	111	2	2025-06-22	2025-06-22	f	2025-06-22 11:52:09.392813	2025-06-22 11:52:09.442834	Pro
85	112	2	2025-06-22	2025-06-22	f	2025-06-22 12:02:42.234714	2025-06-22 12:02:42.284507	Pro
86	113	2	2025-06-22	2025-06-22	f	2025-06-22 13:48:13.592603	2025-06-22 13:48:13.639238	Pro
87	114	2	2025-06-22	2025-06-22	f	2025-06-22 14:30:17.557519	2025-06-22 14:30:17.755124	Pro
88	115	2	2025-06-22	2025-06-22	f	2025-06-22 14:33:24.366749	2025-06-22 14:33:24.476362	Pro
89	116	2	2025-06-22	2025-06-22	f	2025-06-22 14:48:00.746361	2025-06-22 14:48:00.812024	Pro
90	117	2	2025-06-22	2025-06-22	f	2025-06-22 14:58:21.101545	2025-06-22 14:58:21.229085	Pro
91	118	2	2025-06-22	2025-06-22	f	2025-06-22 15:06:56.915378	2025-06-22 15:06:57.112289	Pro
92	119	2	2025-06-22	2025-06-22	f	2025-06-22 15:09:54.947611	2025-06-22 15:09:54.998335	Pro
93	120	2	2025-06-22	2025-06-22	f	2025-06-22 15:28:46.246417	2025-06-22 15:28:46.294565	Pro
94	121	2	2025-06-22	2025-06-22	f	2025-06-22 15:34:07.835048	2025-06-22 15:34:07.873754	Pro
95	122	2	2025-06-22	2025-06-22	f	2025-06-22 15:45:09.242992	2025-06-22 15:45:09.28289	Pro
96	123	2	2025-06-22	2025-06-22	f	2025-06-22 15:55:11.559823	2025-06-22 15:55:11.606752	Pro
97	124	2	2025-06-23	2025-06-23	f	2025-06-22 16:01:46.339222	2025-06-22 16:01:46.375764	Pro
98	125	2	2025-06-23	2025-06-23	f	2025-06-22 16:21:38.460259	2025-06-22 16:21:38.517238	Pro
99	126	2	2025-06-23	2025-06-23	f	2025-06-22 16:26:32.548313	2025-06-22 16:26:32.588617	Pro
100	127	2	2025-06-23	2025-06-23	f	2025-06-22 16:42:32.107948	2025-06-22 16:42:32.149002	Pro
101	128	2	2025-06-23	2025-06-23	f	2025-06-22 16:50:56.042531	2025-06-22 16:50:56.095797	Pro
102	129	2	2025-06-23	2025-06-23	f	2025-06-22 17:15:21.196738	2025-06-22 17:15:21.24382	Pro
103	130	2	2025-06-23	2025-06-23	f	2025-06-22 17:20:51.349805	2025-06-22 17:20:51.40819	Pro
104	131	2	2025-06-23	2025-06-23	f	2025-06-22 17:23:25.822435	2025-06-22 17:23:25.869262	Pro
105	132	2	2025-06-23	2025-06-23	f	2025-06-22 17:28:26.978568	2025-06-22 17:28:27.033603	Pro
106	133	2	2025-06-23	2025-06-23	f	2025-06-22 17:34:56.107347	2025-06-22 17:34:56.169781	Pro
107	146	2	2025-06-25	2025-07-25	t	2025-06-25 04:46:11.157508	2025-06-25 04:46:11.157524	Pro
108	147	2	2025-06-25	2025-06-25	f	2025-06-25 04:57:15.217004	2025-06-25 04:57:15.407393	Pro
109	167	2	2025-06-25	2025-06-25	f	2025-06-25 08:08:42.994456	2025-06-25 08:08:43.174993	Pro
110	168	2	2025-06-26	2025-06-26	f	2025-06-26 07:19:58.455696	2025-06-26 07:19:58.674778	Pro
111	169	2	2025-06-26	2025-06-26	f	2025-06-26 07:23:57.002547	2025-06-26 07:23:57.210733	Pro
112	170	2	2025-06-26	2025-06-26	f	2025-06-26 07:42:45.545943	2025-06-26 07:42:45.721586	Pro
113	171	2	2025-06-26	2025-06-26	f	2025-06-26 08:14:39.672741	2025-06-26 08:14:39.992544	Pro
114	172	2	2025-06-26	2025-06-26	f	2025-06-26 12:48:37.744555	2025-06-26 12:48:37.960483	Pro
115	173	2	2025-06-26	2025-06-26	f	2025-06-26 13:02:48.828526	2025-06-26 13:02:49.040044	Pro
116	174	2	2025-06-26	2025-06-26	f	2025-06-26 13:15:21.529967	2025-06-26 13:15:21.718152	Pro
117	175	2	2025-06-26	2025-06-26	f	2025-06-26 14:05:33.597022	2025-06-26 14:05:33.76924	Pro
118	176	2	2025-06-26	2025-06-26	f	2025-06-26 14:27:03.106641	2025-06-26 14:27:03.309529	Pro
119	177	2	2025-06-26	2025-06-26	f	2025-06-26 14:33:18.843741	2025-06-26 14:33:19.061663	Pro
120	178	2	2025-06-27	2025-06-27	f	2025-06-27 08:37:02.643908	2025-06-27 08:37:02.852218	Pro
121	179	2	2025-06-27	2025-06-27	f	2025-06-27 08:43:17.669275	2025-06-27 08:43:17.886031	Pro
122	180	2	2025-06-27	2025-06-27	f	2025-06-27 09:00:32.283666	2025-06-27 09:00:32.476981	Pro
123	181	2	2025-06-27	2025-06-27	f	2025-06-27 09:05:52.613999	2025-06-27 09:05:52.820439	Pro
124	182	2	2025-06-30	2025-06-30	f	2025-06-30 03:35:23.396837	2025-06-30 03:35:23.545169	Pro
125	183	2	2025-06-30	2025-06-30	f	2025-06-30 04:32:24.476271	2025-06-30 04:32:24.647886	Pro
126	184	2	2025-06-30	2025-06-30	f	2025-06-30 06:50:01.560655	2025-06-30 06:50:01.756701	Pro
127	185	2	2025-06-30	2025-06-30	f	2025-06-30 09:22:41.768915	2025-06-30 09:22:41.968866	Pro
128	186	2	2025-06-30	2025-06-30	f	2025-06-30 09:39:17.150497	2025-06-30 09:39:17.346897	Pro
129	187	2	2025-06-30	2025-06-30	f	2025-06-30 10:02:27.810359	2025-06-30 10:02:28.049643	Pro
130	188	2	2025-06-30	2025-06-30	f	2025-06-30 10:09:28.894075	2025-06-30 10:09:29.07988	Pro
131	189	2	2025-06-30	2025-06-30	f	2025-06-30 10:15:22.847623	2025-06-30 10:15:23.045911	Pro
132	190	2	2025-06-30	2025-06-30	f	2025-06-30 10:17:04.131692	2025-06-30 10:17:04.334632	Pro
133	191	2	2025-06-30	2025-06-30	f	2025-06-30 10:17:58.862292	2025-06-30 10:17:59.070166	Pro
134	192	2	2025-06-30	2025-06-30	f	2025-06-30 10:25:33.914197	2025-06-30 10:25:34.139575	Pro
135	193	2	2025-07-01	2025-07-01	f	2025-07-01 01:26:02.829124	2025-07-01 01:26:03.047241	Pro
136	194	2	2025-07-01	2025-07-01	f	2025-07-01 01:47:36.171581	2025-07-01 01:47:36.35902	Pro
137	196	2	2025-07-01	2025-07-01	f	2025-07-01 03:18:19.047899	2025-07-01 03:18:19.244905	Pro
138	198	2	2025-07-01	2025-07-01	f	2025-07-01 07:00:30.602766	2025-07-01 07:00:30.811929	Pro
139	199	2	2025-07-01	2025-07-01	f	2025-07-01 07:21:42.711962	2025-07-01 07:21:42.894453	Pro
140	200	2	2025-07-01	2025-07-01	f	2025-07-01 08:00:07.349394	2025-07-01 08:00:07.546187	Pro
141	201	2	2025-07-01	2025-07-01	f	2025-07-01 09:15:59.435146	2025-07-01 09:15:59.618864	Pro
142	202	2	2025-07-01	2025-07-01	f	2025-07-01 09:56:20.200132	2025-07-01 09:56:20.511516	Pro
143	205	2	2025-07-02	2025-07-02	f	2025-07-02 03:38:06.563419	2025-07-02 03:38:06.772565	Pro
144	206	2	2025-07-02	2025-07-02	f	2025-07-02 03:39:00.887366	2025-07-02 03:39:01.11244	Pro
145	207	2	2025-07-02	2025-07-02	f	2025-07-02 03:40:47.904633	2025-07-02 03:40:48.100417	Pro
146	208	2	2025-07-02	2025-07-02	f	2025-07-02 03:58:14.093359	2025-07-02 03:58:14.273537	Pro
147	209	2	2025-07-02	2025-07-02	f	2025-07-02 04:00:35.616921	2025-07-02 04:00:35.826578	Pro
148	210	2	2025-07-02	2025-07-02	f	2025-07-02 04:02:46.913094	2025-07-02 04:02:47.092576	Pro
149	211	2	2025-07-02	2025-07-02	f	2025-07-02 04:13:00.115371	2025-07-02 04:13:00.326483	Pro
150	212	2	2025-07-02	2025-07-02	f	2025-07-02 04:20:29.27272	2025-07-02 04:20:29.446771	Pro
151	213	2	2025-07-02	2025-07-02	f	2025-07-02 04:24:05.320377	2025-07-02 04:24:05.529678	Pro
152	214	2	2025-07-02	2025-07-02	f	2025-07-02 04:41:16.68435	2025-07-02 04:41:16.886351	Pro
153	215	2	2025-07-02	2025-07-02	f	2025-07-02 05:05:52.787927	2025-07-02 05:05:53.018621	Pro
154	216	2	2025-07-02	2025-07-02	f	2025-07-02 05:35:55.571985	2025-07-02 05:35:55.724549	Pro
155	217	2	2025-07-02	2025-07-02	f	2025-07-02 06:13:38.132455	2025-07-02 06:13:38.357807	Pro
156	219	2	2025-07-02	2025-07-02	f	2025-07-02 08:14:18.662666	2025-07-02 08:14:18.866592	Pro
157	220	2	2025-07-02	2025-07-02	f	2025-07-02 09:22:13.894418	2025-07-02 09:22:14.068238	Pro
158	221	2	2025-07-02	2025-07-02	f	2025-07-02 09:29:12.723115	2025-07-02 09:29:12.908545	Pro
159	222	2	2025-07-02	2025-07-02	f	2025-07-02 09:48:52.045958	2025-07-02 09:48:52.22822	Pro
160	223	2	2025-07-02	2025-07-02	f	2025-07-02 10:04:49.945173	2025-07-02 10:04:50.147611	Pro
161	224	2	2025-07-02	2025-07-02	f	2025-07-02 10:24:29.550698	2025-07-02 10:24:29.753345	Pro
162	225	2	2025-07-02	2025-07-02	f	2025-07-02 10:32:12.323934	2025-07-02 10:32:12.613745	Pro
163	234	2	2025-07-08	2025-07-08	f	2025-07-08 07:50:59.721043	2025-07-08 07:50:59.916599	Pro
164	239	2	2025-07-08	2025-07-08	f	2025-07-08 09:53:31.803925	2025-07-08 09:53:32.005838	Pro
165	240	2	2025-07-08	2025-07-08	f	2025-07-08 09:58:45.735872	2025-07-08 09:58:45.888436	Pro
166	249	2	2025-07-11	2025-07-11	f	2025-07-11 10:56:56.222982	2025-07-11 10:56:56.398849	Pro
\.


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: public; Owner: curify
--

COPY public.transaction (transaction_id, user_id, transaction_type, amount, currency, transaction_date, description, created_at, updated_at, project_id) FROM stdin;
1	16	CREDIT_PURCHASE	100	USD	2025-06-18 07:20:35.520218	Credit recharge via test... for 100.0 USD (Txn: txn_1750202435.519797_100.0)	2025-06-18 07:20:35.520238	2025-06-18 07:20:35.520249	\N
2	17	CREDIT_PURCHASE	100	USD	2025-06-18 08:32:52.97988	Credit recharge via test... for 100.0 USD (Txn: txn_1750206772.979624_100.0)	2025-06-18 08:32:52.979897	2025-06-18 08:32:52.979909	\N
3	18	CREDIT_PURCHASE	100	USD	2025-06-18 08:37:21.772069	Credit recharge via test... for 100.0 USD (Txn: txn_1750207041.771841_100.0)	2025-06-18 08:37:21.772085	2025-06-18 08:37:21.772096	\N
4	19	CREDIT_PURCHASE	100	USD	2025-06-18 08:39:14.873955	Credit recharge via test... for 100.0 USD (Txn: txn_1750207154.873736_100.0)	2025-06-18 08:39:14.87397	2025-06-18 08:39:14.873981	\N
5	20	CREDIT_PURCHASE	100	USD	2025-06-18 08:44:50.631776	Credit recharge via test... for 100.0 USD (Txn: txn_1750207490.631539_100.0)	2025-06-18 08:44:50.631794	2025-06-18 08:44:50.631806	\N
6	21	CREDIT_PURCHASE	100	USD	2025-06-18 08:56:41.828369	Credit recharge via test... for 100.0 USD (Txn: txn_1750208201.828081_100.0)	2025-06-18 08:56:41.828385	2025-06-18 08:56:41.828396	\N
7	22	CREDIT_PURCHASE	100	USD	2025-06-18 09:10:05.279421	Credit recharge via test... for 100.0 USD (Txn: txn_1750209005.279188_100.0)	2025-06-18 09:10:05.279437	2025-06-18 09:10:05.279447	\N
8	24	CREDIT_PURCHASE	100	USD	2025-06-18 09:54:48.263969	Credit recharge via test... for 100.0 USD (Txn: txn_1750211688.263692_100.0)	2025-06-18 09:54:48.263986	2025-06-18 09:54:48.263997	\N
9	25	CREDIT_PURCHASE	100	USD	2025-06-18 09:59:17.618473	Credit recharge via test... for 100.0 USD (Txn: txn_1750211957.618092_100.0)	2025-06-18 09:59:17.618493	2025-06-18 09:59:17.618505	\N
10	26	CREDIT_PURCHASE	100	USD	2025-06-18 10:13:09.031353	Credit recharge via test... for 100.0 USD (Txn: txn_1750212789.030985_100.0)	2025-06-18 10:13:09.03137	2025-06-18 10:13:09.031381	\N
11	26	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 10:13:09.087174	Subscription 'Pro' enrollment (Txn: txn_1750212789.07618_12.0)	2025-06-18 10:13:09.087193	2025-06-18 10:13:09.087206	\N
12	27	CREDIT_PURCHASE	100	USD	2025-06-18 10:19:54.35925	Credit recharge via test... for 100.0 USD (Txn: txn_1750213194.358999_100.0)	2025-06-18 10:19:54.359267	2025-06-18 10:19:54.359279	\N
13	28	CREDIT_PURCHASE	100	USD	2025-06-18 10:21:42.142998	Credit recharge via test... for 100.0 USD (Txn: txn_1750213302.142751_100.0)	2025-06-18 10:21:42.143016	2025-06-18 10:21:42.143027	\N
14	28	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 10:21:42.197797	Subscription 'Pro' enrollment (Txn: txn_1750213302.189417_12.0)	2025-06-18 10:21:42.197815	2025-06-18 10:21:42.197828	\N
15	29	CREDIT_PURCHASE	100	USD	2025-06-18 10:32:27.228262	Credit recharge via test... for 100.0 USD (Txn: txn_1750213947.227966_100.0)	2025-06-18 10:32:27.228279	2025-06-18 10:32:27.228291	\N
16	29	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 10:32:27.285127	Subscription 'Pro' enrollment (Txn: txn_1750213947.275649_12.0)	2025-06-18 10:32:27.285188	2025-06-18 10:32:27.285205	\N
17	30	CREDIT_PURCHASE	100	USD	2025-06-18 10:33:38.541544	Credit recharge via test... for 100.0 USD (Txn: txn_1750214018.541235_100.0)	2025-06-18 10:33:38.541619	2025-06-18 10:33:38.541636	\N
18	30	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 10:33:38.598811	Subscription 'Pro' enrollment (Txn: txn_1750214018.590294_12.0)	2025-06-18 10:33:38.59883	2025-06-18 10:33:38.598842	\N
19	31	CREDIT_PURCHASE	100	USD	2025-06-18 10:37:16.49988	Credit recharge via test... for 100.0 USD (Txn: txn_1750214236.49961_100.0)	2025-06-18 10:37:16.499897	2025-06-18 10:37:16.499907	\N
20	31	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 10:37:16.557157	Subscription 'Pro' enrollment (Txn: txn_1750214236.546441_12.0)	2025-06-18 10:37:16.557177	2025-06-18 10:37:16.557189	\N
21	32	CREDIT_PURCHASE	100	USD	2025-06-18 10:40:10.84022	Credit recharge via test... for 100.0 USD (Txn: txn_1750214410.839952_100.0)	2025-06-18 10:40:10.840249	2025-06-18 10:40:10.840262	\N
22	32	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 10:40:10.894925	Subscription 'Pro' enrollment (Txn: txn_1750214410.887062_12.0)	2025-06-18 10:40:10.89496	2025-06-18 10:40:10.894981	\N
23	33	CREDIT_PURCHASE	100	USD	2025-06-18 10:47:52.377066	Credit recharge via test... for 100.0 USD (Txn: txn_1750214872.376818_100.0)	2025-06-18 10:47:52.377082	2025-06-18 10:47:52.377094	\N
24	33	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 10:47:52.434451	Subscription 'Pro' enrollment (Txn: txn_1750214872.425088_12.0)	2025-06-18 10:47:52.43447	2025-06-18 10:47:52.434482	\N
25	34	CREDIT_PURCHASE	100	USD	2025-06-18 10:54:22.57335	Credit recharge via test... for 100.0 USD (Txn: txn_1750215262.573077_100.0)	2025-06-18 10:54:22.573367	2025-06-18 10:54:22.573378	\N
26	34	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 10:54:22.671395	Subscription 'Pro' enrollment (Txn: txn_1750215262.659669_12.0)	2025-06-18 10:54:22.671413	2025-06-18 10:54:22.671425	\N
27	35	CREDIT_PURCHASE	100	USD	2025-06-18 11:00:45.361847	Credit recharge via test... for 100.0 USD (Txn: txn_1750215645.361609_100.0)	2025-06-18 11:00:45.361863	2025-06-18 11:00:45.361874	\N
28	35	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 11:00:45.421799	Subscription 'Pro' enrollment (Txn: txn_1750215645.409757_12.0)	2025-06-18 11:00:45.421819	2025-06-18 11:00:45.421832	\N
29	36	CREDIT_PURCHASE	100	USD	2025-06-18 11:07:29.044342	Credit recharge via test... for 100.0 USD (Txn: txn_1750216049.044082_100.0)	2025-06-18 11:07:29.044359	2025-06-18 11:07:29.044371	\N
30	36	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 11:07:29.100671	Subscription 'Pro' enrollment (Txn: txn_1750216049.091369_12.0)	2025-06-18 11:07:29.100692	2025-06-18 11:07:29.100705	\N
31	37	CREDIT_PURCHASE	100	USD	2025-06-18 11:35:26.441922	Credit recharge via test... for 100.0 USD (Txn: txn_1750217726.441598_100.0)	2025-06-18 11:35:26.441942	2025-06-18 11:35:26.441955	\N
32	37	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 11:35:26.50552	Subscription 'Pro' enrollment (Txn: txn_1750217726.49372_12.0)	2025-06-18 11:35:26.50554	2025-06-18 11:35:26.505553	\N
33	38	CREDIT_PURCHASE	100	USD	2025-06-18 11:59:23.435398	Credit recharge via test... for 100.0 USD (Txn: txn_1750219163.435129_100.0)	2025-06-18 11:59:23.435415	2025-06-18 11:59:23.435427	\N
34	38	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 11:59:23.503553	Subscription 'Pro' enrollment (Txn: txn_1750219163.492647_12.0)	2025-06-18 11:59:23.503572	2025-06-18 11:59:23.503584	\N
35	39	CREDIT_PURCHASE	100	USD	2025-06-18 12:01:19.813929	Credit recharge via test... for 100.0 USD (Txn: txn_1750219279.813597_100.0)	2025-06-18 12:01:19.813948	2025-06-18 12:01:19.81396	\N
36	39	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 12:01:19.873471	Subscription 'Pro' enrollment (Txn: txn_1750219279.862281_12.0)	2025-06-18 12:01:19.873489	2025-06-18 12:01:19.873501	\N
37	40	CREDIT_PURCHASE	100	USD	2025-06-18 12:08:13.390719	Credit recharge via test... for 100.0 USD (Txn: txn_1750219693.390438_100.0)	2025-06-18 12:08:13.390737	2025-06-18 12:08:13.39075	\N
38	40	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 12:08:13.458066	Subscription 'Pro' enrollment (Txn: txn_1750219693.447986_12.0)	2025-06-18 12:08:13.458085	2025-06-18 12:08:13.458099	\N
39	41	CREDIT_PURCHASE	100	USD	2025-06-18 12:19:11.338014	Credit recharge via test... for 100.0 USD (Txn: txn_1750220351.337774_100.0)	2025-06-18 12:19:11.33803	2025-06-18 12:19:11.338041	\N
40	41	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 12:19:11.394985	Subscription 'Pro' enrollment (Txn: txn_1750220351.387403_12.0)	2025-06-18 12:19:11.395003	2025-06-18 12:19:11.395015	\N
41	42	CREDIT_PURCHASE	100	USD	2025-06-18 12:25:56.266173	Credit recharge via test... for 100.0 USD (Txn: txn_1750220756.26594_100.0)	2025-06-18 12:25:56.26619	2025-06-18 12:25:56.2662	\N
42	42	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 12:25:56.322644	Subscription 'Pro' enrollment (Txn: txn_1750220756.314466_12.0)	2025-06-18 12:25:56.322661	2025-06-18 12:25:56.322673	\N
43	43	CREDIT_PURCHASE	100	USD	2025-06-18 12:26:53.9801	Credit recharge via test... for 100.0 USD (Txn: txn_1750220813.979861_100.0)	2025-06-18 12:26:53.980116	2025-06-18 12:26:53.980126	\N
44	43	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 12:26:54.040381	Subscription 'Pro' enrollment (Txn: txn_1750220814.030463_12.0)	2025-06-18 12:26:54.0404	2025-06-18 12:26:54.040412	\N
45	44	CREDIT_PURCHASE	100	USD	2025-06-18 12:33:16.038392	Credit recharge via test... for 100.0 USD (Txn: txn_1750221196.037842_100.0)	2025-06-18 12:33:16.03846	2025-06-18 12:33:16.038511	\N
46	44	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 12:33:16.100239	Subscription 'Pro' enrollment (Txn: txn_1750221196.089332_12.0)	2025-06-18 12:33:16.100577	2025-06-18 12:33:16.101148	\N
47	45	CREDIT_PURCHASE	100	USD	2025-06-18 12:38:09.512394	Credit recharge via test... for 100.0 USD (Txn: txn_1750221489.512097_100.0)	2025-06-18 12:38:09.512411	2025-06-18 12:38:09.512423	\N
48	45	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 12:38:09.590361	Subscription 'Pro' enrollment (Txn: txn_1750221489.580065_12.0)	2025-06-18 12:38:09.590422	2025-06-18 12:38:09.590448	\N
49	46	CREDIT_PURCHASE	100	USD	2025-06-18 12:38:59.289777	Credit recharge via test... for 100.0 USD (Txn: txn_1750221539.289472_100.0)	2025-06-18 12:38:59.28979	2025-06-18 12:38:59.289798	\N
50	46	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 12:38:59.322848	Subscription 'Pro' enrollment (Txn: txn_1750221539.318361_12.0)	2025-06-18 12:38:59.322915	2025-06-18 12:38:59.322944	\N
51	47	CREDIT_PURCHASE	100	USD	2025-06-18 12:55:13.223617	Credit recharge via test... for 100.0 USD (Txn: txn_1750222513.223332_100.0)	2025-06-18 12:55:13.223634	2025-06-18 12:55:13.223646	\N
52	47	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 12:55:13.28237	Subscription 'Pro' enrollment (Txn: txn_1750222513.272381_12.0)	2025-06-18 12:55:13.282388	2025-06-18 12:55:13.2824	\N
53	48	CREDIT_PURCHASE	100	USD	2025-06-18 12:56:49.029999	Credit recharge via test... for 100.0 USD (Txn: txn_1750222609.029763_100.0)	2025-06-18 12:56:49.030016	2025-06-18 12:56:49.030027	\N
54	48	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 12:56:49.089158	Subscription 'Pro' enrollment (Txn: txn_1750222609.077671_12.0)	2025-06-18 12:56:49.089179	2025-06-18 12:56:49.089191	\N
55	49	CREDIT_PURCHASE	100	USD	2025-06-18 12:57:38.387862	Credit recharge via test... for 100.0 USD (Txn: txn_1750222658.387609_100.0)	2025-06-18 12:57:38.387878	2025-06-18 12:57:38.387889	\N
56	49	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 12:57:38.44342	Subscription 'Pro' enrollment (Txn: txn_1750222658.433862_12.0)	2025-06-18 12:57:38.443438	2025-06-18 12:57:38.44345	\N
57	50	CREDIT_PURCHASE	100	USD	2025-06-18 13:04:35.596896	Credit recharge via test... for 100.0 USD (Txn: txn_1750223075.596387_100.0)	2025-06-18 13:04:35.596912	2025-06-18 13:04:35.596922	\N
58	50	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 13:04:35.635067	Subscription 'Pro' enrollment (Txn: txn_1750223075.627543_12.0)	2025-06-18 13:04:35.635085	2025-06-18 13:04:35.635098	\N
59	51	CREDIT_PURCHASE	100	USD	2025-06-18 13:11:15.137674	Credit recharge via test... for 100.0 USD (Txn: txn_1750223475.137422_100.0)	2025-06-18 13:11:15.137691	2025-06-18 13:11:15.137702	\N
60	51	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 13:11:15.17131	Subscription 'Pro' enrollment (Txn: txn_1750223475.16693_12.0)	2025-06-18 13:11:15.171329	2025-06-18 13:11:15.171341	\N
61	52	CREDIT_PURCHASE	100	USD	2025-06-18 14:39:41.692647	Credit recharge via test... for 100.0 USD (Txn: txn_1750228781.692325_100.0)	2025-06-18 14:39:41.692663	2025-06-18 14:39:41.692674	\N
62	52	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 14:39:41.753537	Subscription 'Pro' enrollment (Txn: txn_1750228781.743025_12.0)	2025-06-18 14:39:41.753556	2025-06-18 14:39:41.753569	\N
63	53	CREDIT_PURCHASE	100	USD	2025-06-18 14:45:38.790105	Credit recharge via test... for 100.0 USD (Txn: txn_1750229138.789775_100.0)	2025-06-18 14:45:38.790122	2025-06-18 14:45:38.790133	\N
64	53	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 14:45:38.845957	Subscription 'Pro' enrollment (Txn: txn_1750229138.836397_12.0)	2025-06-18 14:45:38.845975	2025-06-18 14:45:38.845986	\N
65	54	CREDIT_PURCHASE	100	USD	2025-06-18 14:47:19.981919	Credit recharge via test... for 100.0 USD (Txn: txn_1750229239.981663_100.0)	2025-06-18 14:47:19.981936	2025-06-18 14:47:19.981946	\N
66	54	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 14:47:20.040264	Subscription 'Pro' enrollment (Txn: txn_1750229240.0305_12.0)	2025-06-18 14:47:20.040283	2025-06-18 14:47:20.040295	\N
67	55	CREDIT_PURCHASE	100	USD	2025-06-18 14:48:17.46332	Credit recharge via test... for 100.0 USD (Txn: txn_1750229297.463036_100.0)	2025-06-18 14:48:17.463338	2025-06-18 14:48:17.46335	\N
68	55	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 14:48:17.520056	Subscription 'Pro' enrollment (Txn: txn_1750229297.510056_12.0)	2025-06-18 14:48:17.520074	2025-06-18 14:48:17.520086	\N
69	56	CREDIT_PURCHASE	100	USD	2025-06-18 14:58:47.125913	Credit recharge via test... for 100.0 USD (Txn: txn_1750229927.125499_100.0)	2025-06-18 14:58:47.125934	2025-06-18 14:58:47.125945	\N
70	56	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 14:58:47.189741	Subscription 'Pro' enrollment (Txn: txn_1750229927.177336_12.0)	2025-06-18 14:58:47.18976	2025-06-18 14:58:47.189773	\N
71	57	CREDIT_PURCHASE	100	USD	2025-06-18 14:59:27.165131	Credit recharge via test... for 100.0 USD (Txn: txn_1750229967.164895_100.0)	2025-06-18 14:59:27.165147	2025-06-18 14:59:27.165157	\N
72	57	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 14:59:27.223116	Subscription 'Pro' enrollment (Txn: txn_1750229967.213629_12.0)	2025-06-18 14:59:27.223134	2025-06-18 14:59:27.223147	\N
73	58	CREDIT_PURCHASE	100	USD	2025-06-18 15:01:24.333786	Credit recharge via test... for 100.0 USD (Txn: txn_1750230084.333546_100.0)	2025-06-18 15:01:24.333802	2025-06-18 15:01:24.333813	\N
74	58	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:01:24.393551	Subscription 'Pro' enrollment (Txn: txn_1750230084.383173_12.0)	2025-06-18 15:01:24.393573	2025-06-18 15:01:24.393586	\N
75	59	CREDIT_PURCHASE	100	USD	2025-06-18 15:04:16.113368	Credit recharge via test... for 100.0 USD (Txn: txn_1750230256.113101_100.0)	2025-06-18 15:04:16.113384	2025-06-18 15:04:16.113395	\N
76	59	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:04:16.238551	Subscription 'Pro' enrollment (Txn: txn_1750230256.225702_12.0)	2025-06-18 15:04:16.238569	2025-06-18 15:04:16.23858	\N
77	60	CREDIT_PURCHASE	100	USD	2025-06-18 15:05:45.102914	Credit recharge via test... for 100.0 USD (Txn: txn_1750230345.102692_100.0)	2025-06-18 15:05:45.102929	2025-06-18 15:05:45.102939	\N
78	60	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:05:45.161815	Subscription 'Pro' enrollment (Txn: txn_1750230345.150679_12.0)	2025-06-18 15:05:45.161865	2025-06-18 15:05:45.16188	\N
79	61	CREDIT_PURCHASE	100	USD	2025-06-18 15:07:45.731119	Credit recharge via test... for 100.0 USD (Txn: txn_1750230465.730686_100.0)	2025-06-18 15:07:45.731137	2025-06-18 15:07:45.731149	\N
80	61	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:07:45.797856	Subscription 'Pro' enrollment (Txn: txn_1750230465.785833_12.0)	2025-06-18 15:07:45.797875	2025-06-18 15:07:45.797888	\N
81	62	CREDIT_PURCHASE	100	USD	2025-06-18 15:10:52.246845	Credit recharge via test... for 100.0 USD (Txn: txn_1750230652.246511_100.0)	2025-06-18 15:10:52.246868	2025-06-18 15:10:52.246881	\N
82	62	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:10:52.294047	Subscription 'Pro' enrollment (Txn: txn_1750230652.287279_12.0)	2025-06-18 15:10:52.294066	2025-06-18 15:10:52.294079	\N
83	63	CREDIT_PURCHASE	100	USD	2025-06-18 15:13:34.801064	Credit recharge via test... for 100.0 USD (Txn: txn_1750230814.800367_100.0)	2025-06-18 15:13:34.801093	2025-06-18 15:13:34.801105	\N
84	63	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:13:34.869575	Subscription 'Pro' enrollment (Txn: txn_1750230814.859266_12.0)	2025-06-18 15:13:34.869593	2025-06-18 15:13:34.869605	\N
85	64	CREDIT_PURCHASE	100	USD	2025-06-18 15:14:56.424554	Credit recharge via test... for 100.0 USD (Txn: txn_1750230896.424254_100.0)	2025-06-18 15:14:56.424573	2025-06-18 15:14:56.424583	\N
86	64	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:14:56.462573	Subscription 'Pro' enrollment (Txn: txn_1750230896.457442_12.0)	2025-06-18 15:14:56.462591	2025-06-18 15:14:56.462602	\N
87	65	CREDIT_PURCHASE	100	USD	2025-06-18 15:16:34.997682	Credit recharge via test... for 100.0 USD (Txn: txn_1750230994.997433_100.0)	2025-06-18 15:16:34.997699	2025-06-18 15:16:34.997708	\N
88	65	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:16:35.037501	Subscription 'Pro' enrollment (Txn: txn_1750230995.032137_12.0)	2025-06-18 15:16:35.03752	2025-06-18 15:16:35.037532	\N
89	66	CREDIT_PURCHASE	100	USD	2025-06-18 15:25:42.802629	Credit recharge via test... for 100.0 USD (Txn: txn_1750231542.802282_100.0)	2025-06-18 15:25:42.802648	2025-06-18 15:25:42.80266	\N
90	66	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:25:42.864103	Subscription 'Pro' enrollment (Txn: txn_1750231542.854813_12.0)	2025-06-18 15:25:42.864122	2025-06-18 15:25:42.864134	\N
91	67	CREDIT_PURCHASE	100	USD	2025-06-18 15:27:28.994088	Credit recharge via test... for 100.0 USD (Txn: txn_1750231648.993852_100.0)	2025-06-18 15:27:28.994105	2025-06-18 15:27:28.994116	\N
92	67	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:27:29.064853	Subscription 'Pro' enrollment (Txn: txn_1750231649.047977_12.0)	2025-06-18 15:27:29.064873	2025-06-18 15:27:29.064886	\N
93	68	CREDIT_PURCHASE	100	USD	2025-06-18 15:28:50.624757	Credit recharge via test... for 100.0 USD (Txn: txn_1750231730.62452_100.0)	2025-06-18 15:28:50.624773	2025-06-18 15:28:50.624784	\N
94	68	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:28:50.701202	Subscription 'Pro' enrollment (Txn: txn_1750231730.677866_12.0)	2025-06-18 15:28:50.701225	2025-06-18 15:28:50.70124	\N
95	69	CREDIT_PURCHASE	100	USD	2025-06-18 15:30:09.645302	Credit recharge via test... for 100.0 USD (Txn: txn_1750231809.645029_100.0)	2025-06-18 15:30:09.645318	2025-06-18 15:30:09.645329	\N
96	69	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:30:09.703516	Subscription 'Pro' enrollment (Txn: txn_1750231809.692612_12.0)	2025-06-18 15:30:09.703534	2025-06-18 15:30:09.703546	\N
97	70	CREDIT_PURCHASE	100	USD	2025-06-18 15:36:07.914395	Credit recharge via test... for 100.0 USD (Txn: txn_1750232167.914148_100.0)	2025-06-18 15:36:07.914412	2025-06-18 15:36:07.914423	\N
98	70	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:36:07.977724	Subscription 'Pro' enrollment (Txn: txn_1750232167.965939_12.0)	2025-06-18 15:36:07.977744	2025-06-18 15:36:07.977756	\N
99	71	CREDIT_PURCHASE	100	USD	2025-06-18 15:38:45.648053	Credit recharge via test... for 100.0 USD (Txn: txn_1750232325.647781_100.0)	2025-06-18 15:38:45.64807	2025-06-18 15:38:45.648082	\N
100	71	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 15:38:45.715674	Subscription 'Pro' enrollment (Txn: txn_1750232325.703513_12.0)	2025-06-18 15:38:45.715693	2025-06-18 15:38:45.715706	\N
101	73	CREDIT_PURCHASE	100	USD	2025-06-18 16:03:47.681794	Credit recharge via test... for 100.0 USD (Txn: txn_1750233827.680329_100.0)	2025-06-18 16:03:47.681852	2025-06-18 16:03:47.681884	\N
102	73	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-18 16:03:48.122496	Subscription 'Pro' enrollment (Txn: txn_1750233827.931158_12.0)	2025-06-18 16:03:48.122547	2025-06-18 16:03:48.12258	\N
103	74	CREDIT_PURCHASE	100	USD	2025-06-19 00:23:03.589062	Credit recharge via test... for 100.0 USD (Txn: txn_1750263783.588683_100.0)	2025-06-19 00:23:03.589081	2025-06-19 00:23:03.589093	\N
104	74	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-19 00:23:03.662987	Subscription 'Pro' enrollment (Txn: txn_1750263783.651682_12.0)	2025-06-19 00:23:03.663007	2025-06-19 00:23:03.66302	\N
105	75	CREDIT_PURCHASE	100	USD	2025-06-19 00:36:53.722062	Credit recharge via test... for 100.0 USD (Txn: txn_1750264613.721803_100.0)	2025-06-19 00:36:53.722078	2025-06-19 00:36:53.722088	\N
106	75	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-19 00:36:53.783592	Subscription 'Pro' enrollment (Txn: txn_1750264613.773214_12.0)	2025-06-19 00:36:53.78361	2025-06-19 00:36:53.783622	\N
107	76	CREDIT_PURCHASE	100	USD	2025-06-19 01:18:00.850896	Credit recharge via test... for 100.0 USD (Txn: txn_1750267080.850526_100.0)	2025-06-19 01:18:00.850916	2025-06-19 01:18:00.850928	\N
108	76	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-19 01:18:00.910523	Subscription 'Pro' enrollment (Txn: txn_1750267080.90053_12.0)	2025-06-19 01:18:00.910542	2025-06-19 01:18:00.910554	\N
109	77	CREDIT_PURCHASE	100	USD	2025-06-19 01:30:17.550159	Credit recharge via test... for 100.0 USD (Txn: txn_1750267817.549906_100.0)	2025-06-19 01:30:17.550174	2025-06-19 01:30:17.550185	\N
110	77	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-19 01:30:17.609028	Subscription 'Pro' enrollment (Txn: txn_1750267817.600241_12.0)	2025-06-19 01:30:17.609046	2025-06-19 01:30:17.609058	\N
111	78	CREDIT_PURCHASE	100	USD	2025-06-19 01:46:24.942385	Credit recharge via test... for 100.0 USD (Txn: txn_1750268784.941565_100.0)	2025-06-19 01:46:24.942426	2025-06-19 01:46:24.942448	\N
112	78	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-19 01:46:25.074285	Subscription 'Pro' enrollment (Txn: txn_1750268785.065162_12.0)	2025-06-19 01:46:25.074304	2025-06-19 01:46:25.074316	\N
113	79	CREDIT_PURCHASE	100	USD	2025-06-19 03:04:06.053558	Credit recharge via test... for 100.0 USD (Txn: txn_1750273446.053228_100.0)	2025-06-19 03:04:06.053576	2025-06-19 03:04:06.053588	\N
114	79	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-19 03:04:06.122003	Subscription 'Pro' enrollment (Txn: txn_1750273446.111159_12.0)	2025-06-19 03:04:06.122023	2025-06-19 03:04:06.122036	\N
115	80	CREDIT_PURCHASE	100	USD	2025-06-19 04:06:43.365195	Credit recharge via test... for 100.0 USD (Txn: txn_1750277203.364851_100.0)	2025-06-19 04:06:43.365214	2025-06-19 04:06:43.365226	\N
116	80	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-19 04:06:43.46063	Subscription 'Pro' enrollment (Txn: txn_1750277203.430754_12.0)	2025-06-19 04:06:43.46065	2025-06-19 04:06:43.460662	\N
117	81	CREDIT_PURCHASE	100	USD	2025-06-19 04:17:03.858599	Credit recharge via test... for 100.0 USD (Txn: txn_1750277823.858131_100.0)	2025-06-19 04:17:03.858618	2025-06-19 04:17:03.85863	\N
118	81	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-19 04:17:03.934593	Subscription 'Pro' enrollment (Txn: txn_1750277823.919542_12.0)	2025-06-19 04:17:03.934612	2025-06-19 04:17:03.934624	\N
119	82	CREDIT_PURCHASE	100	USD	2025-06-19 04:26:05.781257	Credit recharge via test... for 100.0 USD (Txn: txn_1750278365.781023_100.0)	2025-06-19 04:26:05.781272	2025-06-19 04:26:05.781282	\N
120	82	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-19 04:26:05.83974	Subscription 'Pro' enrollment (Txn: txn_1750278365.826699_12.0)	2025-06-19 04:26:05.839754	2025-06-19 04:26:05.839763	\N
121	83	CREDIT_PURCHASE	100	USD	2025-06-19 05:02:22.803226	Credit recharge via test... for 100.0 USD (Txn: txn_1750280542.802957_100.0)	2025-06-19 05:02:22.803244	2025-06-19 05:02:22.803257	\N
122	83	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-19 05:02:22.870119	Subscription 'Pro' enrollment (Txn: txn_1750280542.856105_12.0)	2025-06-19 05:02:22.870138	2025-06-19 05:02:22.87015	\N
123	86	CREDIT_PURCHASE	100	USD	2025-06-19 06:20:19.482106	Credit recharge via test... for 100.0 USD (Txn: txn_1750285219.481762_100.0)	2025-06-19 06:20:19.482123	2025-06-19 06:20:19.482141	\N
124	86	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-19 06:20:19.549334	Subscription 'Pro' enrollment (Txn: txn_1750285219.539825_12.0)	2025-06-19 06:20:19.549352	2025-06-19 06:20:19.549364	\N
125	87	CREDIT_PURCHASE	100	USD	2025-06-19 07:54:26.033754	Credit recharge via test... for 100.0 USD (Txn: txn_1750290866.033287_100.0)	2025-06-19 07:54:26.033775	2025-06-19 07:54:26.033788	\N
126	87	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-19 07:54:26.106534	Subscription 'Pro' enrollment (Txn: txn_1750290866.096096_12.0)	2025-06-19 07:54:26.106563	2025-06-19 07:54:26.106578	\N
127	88	CREDIT_PURCHASE	100	USD	2025-06-20 11:33:08.928517	Credit recharge via test... for 100.0 USD (Txn: txn_1750390388.928241_100.0)	2025-06-20 11:33:08.928535	2025-06-20 11:33:08.928547	\N
128	88	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-20 11:33:09.01581	Subscription 'Pro' enrollment (Txn: txn_1750390389.004283_12.0)	2025-06-20 11:33:09.015829	2025-06-20 11:33:09.015842	\N
129	89	CREDIT_PURCHASE	100	USD	2025-06-21 09:12:05.283879	Credit recharge via test... for 100.0 USD (Txn: txn_1750468325.283501_100.0)	2025-06-21 09:12:05.283898	2025-06-21 09:12:05.283911	\N
130	89	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 09:12:05.37061	Subscription 'Pro' enrollment (Txn: txn_1750468325.357129_12.0)	2025-06-21 09:12:05.370629	2025-06-21 09:12:05.370642	\N
131	90	CREDIT_PURCHASE	100	USD	2025-06-21 09:31:31.453384	Credit recharge via test... for 100.0 USD (Txn: txn_1750469491.453081_100.0)	2025-06-21 09:31:31.453401	2025-06-21 09:31:31.453412	\N
132	90	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 09:31:31.56235	Subscription 'Pro' enrollment (Txn: txn_1750469491.505672_12.0)	2025-06-21 09:31:31.562369	2025-06-21 09:31:31.562382	\N
133	91	CREDIT_PURCHASE	100	USD	2025-06-21 09:37:24.577285	Credit recharge via test... for 100.0 USD (Txn: txn_1750469844.577032_100.0)	2025-06-21 09:37:24.5773	2025-06-21 09:37:24.57731	\N
134	91	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 09:37:24.648266	Subscription 'Pro' enrollment (Txn: txn_1750469844.63937_12.0)	2025-06-21 09:37:24.648285	2025-06-21 09:37:24.648297	\N
135	92	CREDIT_PURCHASE	100	USD	2025-06-21 09:44:44.456538	Credit recharge via test... for 100.0 USD (Txn: txn_1750470284.45625_100.0)	2025-06-21 09:44:44.456555	2025-06-21 09:44:44.456567	\N
136	92	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 09:44:44.526689	Subscription 'Pro' enrollment (Txn: txn_1750470284.515457_12.0)	2025-06-21 09:44:44.526708	2025-06-21 09:44:44.526721	\N
137	93	CREDIT_PURCHASE	100	USD	2025-06-21 09:51:26.823985	Credit recharge via test... for 100.0 USD (Txn: txn_1750470686.823713_100.0)	2025-06-21 09:51:26.824003	2025-06-21 09:51:26.824014	\N
138	93	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 09:51:26.904392	Subscription 'Pro' enrollment (Txn: txn_1750470686.891613_12.0)	2025-06-21 09:51:26.904411	2025-06-21 09:51:26.904424	\N
139	94	CREDIT_PURCHASE	100	USD	2025-06-21 10:01:23.391929	Credit recharge via test... for 100.0 USD (Txn: txn_1750471283.391236_100.0)	2025-06-21 10:01:23.391976	2025-06-21 10:01:23.392004	\N
140	94	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 10:01:23.483212	Subscription 'Pro' enrollment (Txn: txn_1750471283.472413_12.0)	2025-06-21 10:01:23.483232	2025-06-21 10:01:23.483245	\N
141	95	CREDIT_PURCHASE	100	USD	2025-06-21 10:34:46.689029	Credit recharge via test... for 100.0 USD (Txn: txn_1750473286.688735_100.0)	2025-06-21 10:34:46.689047	2025-06-21 10:34:46.689059	\N
142	95	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 10:34:46.756156	Subscription 'Pro' enrollment (Txn: txn_1750473286.744964_12.0)	2025-06-21 10:34:46.756176	2025-06-21 10:34:46.756189	\N
143	96	CREDIT_PURCHASE	100	USD	2025-06-21 10:46:38.73424	Credit recharge via test... for 100.0 USD (Txn: txn_1750473998.733806_100.0)	2025-06-21 10:46:38.734261	2025-06-21 10:46:38.734274	\N
144	96	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 10:46:38.808197	Subscription 'Pro' enrollment (Txn: txn_1750473998.799363_12.0)	2025-06-21 10:46:38.808235	2025-06-21 10:46:38.808252	\N
145	97	CREDIT_PURCHASE	100	USD	2025-06-21 11:10:47.752766	Credit recharge via test... for 100.0 USD (Txn: txn_1750475447.752495_100.0)	2025-06-21 11:10:47.752784	2025-06-21 11:10:47.752796	\N
146	97	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 11:10:47.836897	Subscription 'Pro' enrollment (Txn: txn_1750475447.810742_12.0)	2025-06-21 11:10:47.836916	2025-06-21 11:10:47.836928	\N
147	98	CREDIT_PURCHASE	100	USD	2025-06-21 11:16:03.370525	Credit recharge via test... for 100.0 USD (Txn: txn_1750475763.370222_100.0)	2025-06-21 11:16:03.370543	2025-06-21 11:16:03.370555	\N
148	98	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 11:16:03.430925	Subscription 'Pro' enrollment (Txn: txn_1750475763.421545_12.0)	2025-06-21 11:16:03.430944	2025-06-21 11:16:03.430957	\N
149	99	CREDIT_PURCHASE	100	USD	2025-06-21 11:19:20.00177	Credit recharge via test... for 100.0 USD (Txn: txn_1750475960.001503_100.0)	2025-06-21 11:19:20.001785	2025-06-21 11:19:20.001796	\N
150	99	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 11:19:20.058428	Subscription 'Pro' enrollment (Txn: txn_1750475960.050826_12.0)	2025-06-21 11:19:20.058446	2025-06-21 11:19:20.058458	\N
151	100	CREDIT_PURCHASE	100	USD	2025-06-21 11:22:25.906697	Credit recharge via test... for 100.0 USD (Txn: txn_1750476145.906486_100.0)	2025-06-21 11:22:25.906713	2025-06-21 11:22:25.906723	\N
152	100	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 11:22:25.960305	Subscription 'Pro' enrollment (Txn: txn_1750476145.952354_12.0)	2025-06-21 11:22:25.960325	2025-06-21 11:22:25.960337	\N
153	101	CREDIT_PURCHASE	100	USD	2025-06-21 11:33:38.482046	Credit recharge via test... for 100.0 USD (Txn: txn_1750476818.481738_100.0)	2025-06-21 11:33:38.482063	2025-06-21 11:33:38.482075	\N
154	101	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 11:33:38.545132	Subscription 'Pro' enrollment (Txn: txn_1750476818.535606_12.0)	2025-06-21 11:33:38.545153	2025-06-21 11:33:38.545166	\N
155	102	CREDIT_PURCHASE	100	USD	2025-06-21 11:44:38.571295	Credit recharge via test... for 100.0 USD (Txn: txn_1750477478.570891_100.0)	2025-06-21 11:44:38.571316	2025-06-21 11:44:38.571329	\N
156	102	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 11:44:38.634402	Subscription 'Pro' enrollment (Txn: txn_1750477478.624887_12.0)	2025-06-21 11:44:38.634421	2025-06-21 11:44:38.634434	\N
157	103	CREDIT_PURCHASE	100	USD	2025-06-21 11:53:55.220804	Credit recharge via test... for 100.0 USD (Txn: txn_1750478035.220463_100.0)	2025-06-21 11:53:55.220822	2025-06-21 11:53:55.220833	\N
158	103	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 11:53:55.304726	Subscription 'Pro' enrollment (Txn: txn_1750478035.295059_12.0)	2025-06-21 11:53:55.304747	2025-06-21 11:53:55.304759	\N
159	104	CREDIT_PURCHASE	100	USD	2025-06-21 11:56:07.180349	Credit recharge via test... for 100.0 USD (Txn: txn_1750478167.180099_100.0)	2025-06-21 11:56:07.180366	2025-06-21 11:56:07.180395	\N
160	104	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 11:56:07.239104	Subscription 'Pro' enrollment (Txn: txn_1750478167.229759_12.0)	2025-06-21 11:56:07.239139	2025-06-21 11:56:07.239153	\N
161	105	CREDIT_PURCHASE	100	USD	2025-06-21 12:03:23.70062	Credit recharge via test... for 100.0 USD (Txn: txn_1750478603.700306_100.0)	2025-06-21 12:03:23.700636	2025-06-21 12:03:23.700647	\N
162	105	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 12:03:23.832039	Subscription 'Pro' enrollment (Txn: txn_1750478603.823284_12.0)	2025-06-21 12:03:23.832058	2025-06-21 12:03:23.83207	\N
163	106	CREDIT_PURCHASE	100	USD	2025-06-21 12:18:12.034635	Credit recharge via test... for 100.0 USD (Txn: txn_1750479492.034096_100.0)	2025-06-21 12:18:12.034654	2025-06-21 12:18:12.034684	\N
164	106	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 12:18:12.115524	Subscription 'Pro' enrollment (Txn: txn_1750479492.103453_12.0)	2025-06-21 12:18:12.115544	2025-06-21 12:18:12.115557	\N
165	107	CREDIT_PURCHASE	100	USD	2025-06-21 12:27:10.338303	Credit recharge via test... for 100.0 USD (Txn: txn_1750480030.337936_100.0)	2025-06-21 12:27:10.338388	2025-06-21 12:27:10.338405	\N
166	107	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-21 12:27:10.422027	Subscription 'Pro' enrollment (Txn: txn_1750480030.406601_12.0)	2025-06-21 12:27:10.422052	2025-06-21 12:27:10.422065	\N
167	108	CREDIT_PURCHASE	100	USD	2025-06-22 11:12:53.561168	Credit recharge via test... for 100.0 USD (Txn: txn_1750561973.560899_100.0)	2025-06-22 11:12:53.561186	2025-06-22 11:12:53.561198	\N
168	108	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 11:12:53.63194	Subscription 'Pro' enrollment (Txn: txn_1750561973.622845_12.0)	2025-06-22 11:12:53.631967	2025-06-22 11:12:53.631981	\N
169	109	CREDIT_PURCHASE	100	USD	2025-06-22 11:34:18.197753	Credit recharge via test... for 100.0 USD (Txn: txn_1750563258.197238_100.0)	2025-06-22 11:34:18.197772	2025-06-22 11:34:18.197784	\N
170	109	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 11:34:18.266049	Subscription 'Pro' enrollment (Txn: txn_1750563258.255153_12.0)	2025-06-22 11:34:18.266068	2025-06-22 11:34:18.266081	\N
171	110	CREDIT_PURCHASE	100	USD	2025-06-22 11:43:19.269978	Credit recharge via test... for 100.0 USD (Txn: txn_1750563799.269676_100.0)	2025-06-22 11:43:19.269996	2025-06-22 11:43:19.270008	\N
172	110	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 11:43:19.325211	Subscription 'Pro' enrollment (Txn: txn_1750563799.316708_12.0)	2025-06-22 11:43:19.325231	2025-06-22 11:43:19.325244	\N
173	111	CREDIT_PURCHASE	100	USD	2025-06-22 11:52:09.33992	Credit recharge via test... for 100.0 USD (Txn: txn_1750564329.339633_100.0)	2025-06-22 11:52:09.339937	2025-06-22 11:52:09.339949	\N
174	111	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 11:52:09.403649	Subscription 'Pro' enrollment (Txn: txn_1750564329.392545_12.0)	2025-06-22 11:52:09.403667	2025-06-22 11:52:09.40368	\N
175	112	CREDIT_PURCHASE	100	USD	2025-06-22 12:02:42.154731	Credit recharge via test... for 100.0 USD (Txn: txn_1750564962.154409_100.0)	2025-06-22 12:02:42.154749	2025-06-22 12:02:42.154761	\N
176	112	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 12:02:42.244737	Subscription 'Pro' enrollment (Txn: txn_1750564962.23435_12.0)	2025-06-22 12:02:42.244755	2025-06-22 12:02:42.244768	\N
177	113	CREDIT_PURCHASE	100	USD	2025-06-22 13:48:13.533635	Credit recharge via test... for 100.0 USD (Txn: txn_1750571293.532592_100.0)	2025-06-22 13:48:13.533655	2025-06-22 13:48:13.533667	\N
178	113	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 13:48:13.603132	Subscription 'Pro' enrollment (Txn: txn_1750571293.59234_12.0)	2025-06-22 13:48:13.603168	2025-06-22 13:48:13.603182	\N
179	114	CREDIT_PURCHASE	100	USD	2025-06-22 14:30:17.347823	Credit recharge via test... for 100.0 USD (Txn: txn_1750573817.347245_100.0)	2025-06-22 14:30:17.347849	2025-06-22 14:30:17.347866	\N
180	114	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 14:30:17.602098	Subscription 'Pro' enrollment (Txn: txn_1750573817.556975_12.0)	2025-06-22 14:30:17.602163	2025-06-22 14:30:17.602382	\N
181	115	CREDIT_PURCHASE	100	USD	2025-06-22 14:33:24.154868	Credit recharge via test... for 100.0 USD (Txn: txn_1750574004.153649_100.0)	2025-06-22 14:33:24.154932	2025-06-22 14:33:24.154991	\N
182	115	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 14:33:24.391183	Subscription 'Pro' enrollment (Txn: txn_1750574004.366456_12.0)	2025-06-22 14:33:24.391234	2025-06-22 14:33:24.391272	\N
183	116	CREDIT_PURCHASE	100	USD	2025-06-22 14:48:00.674529	Credit recharge via test... for 100.0 USD (Txn: txn_1750574880.674125_100.0)	2025-06-22 14:48:00.674552	2025-06-22 14:48:00.674564	\N
184	116	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 14:48:00.757769	Subscription 'Pro' enrollment (Txn: txn_1750574880.746024_12.0)	2025-06-22 14:48:00.75779	2025-06-22 14:48:00.757803	\N
185	117	CREDIT_PURCHASE	100	USD	2025-06-22 14:58:20.968728	Credit recharge via test... for 100.0 USD (Txn: txn_1750575500.96828_100.0)	2025-06-22 14:58:20.968757	2025-06-22 14:58:20.968777	\N
186	117	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 14:58:21.124996	Subscription 'Pro' enrollment (Txn: txn_1750575501.101137_12.0)	2025-06-22 14:58:21.125061	2025-06-22 14:58:21.1251	\N
187	118	CREDIT_PURCHASE	100	USD	2025-06-22 15:06:56.693967	Credit recharge via test... for 100.0 USD (Txn: txn_1750576016.692228_100.0)	2025-06-22 15:06:56.694025	2025-06-22 15:06:56.694064	\N
188	118	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 15:06:56.960289	Subscription 'Pro' enrollment (Txn: txn_1750576016.910979_12.0)	2025-06-22 15:06:56.960369	2025-06-22 15:06:56.960437	\N
189	119	CREDIT_PURCHASE	100	USD	2025-06-22 15:09:54.894905	Credit recharge via test... for 100.0 USD (Txn: txn_1750576194.894591_100.0)	2025-06-22 15:09:54.894924	2025-06-22 15:09:54.894936	\N
190	119	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 15:09:54.961751	Subscription 'Pro' enrollment (Txn: txn_1750576194.947435_12.0)	2025-06-22 15:09:54.961786	2025-06-22 15:09:54.961857	\N
191	120	CREDIT_PURCHASE	100	USD	2025-06-22 15:28:46.194048	Credit recharge via test... for 100.0 USD (Txn: txn_1750577326.193722_100.0)	2025-06-22 15:28:46.194066	2025-06-22 15:28:46.194078	\N
192	120	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 15:28:46.256581	Subscription 'Pro' enrollment (Txn: txn_1750577326.246085_12.0)	2025-06-22 15:28:46.2566	2025-06-22 15:28:46.256613	\N
193	121	CREDIT_PURCHASE	100	USD	2025-06-22 15:34:07.788628	Credit recharge via test... for 100.0 USD (Txn: txn_1750577647.78835_100.0)	2025-06-22 15:34:07.788644	2025-06-22 15:34:07.788656	\N
194	121	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 15:34:07.843233	Subscription 'Pro' enrollment (Txn: txn_1750577647.834844_12.0)	2025-06-22 15:34:07.843253	2025-06-22 15:34:07.843265	\N
195	122	CREDIT_PURCHASE	100	USD	2025-06-22 15:45:09.194514	Credit recharge via test... for 100.0 USD (Txn: txn_1750578309.194241_100.0)	2025-06-22 15:45:09.194532	2025-06-22 15:45:09.194543	\N
196	122	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 15:45:09.251567	Subscription 'Pro' enrollment (Txn: txn_1750578309.242691_12.0)	2025-06-22 15:45:09.251586	2025-06-22 15:45:09.251598	\N
197	123	CREDIT_PURCHASE	100	USD	2025-06-22 15:55:11.504009	Credit recharge via test... for 100.0 USD (Txn: txn_1750578911.503558_100.0)	2025-06-22 15:55:11.504031	2025-06-22 15:55:11.504061	\N
198	123	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 15:55:11.568196	Subscription 'Pro' enrollment (Txn: txn_1750578911.559429_12.0)	2025-06-22 15:55:11.568219	2025-06-22 15:55:11.568231	\N
199	124	CREDIT_PURCHASE	100	USD	2025-06-22 16:01:46.293793	Credit recharge via test... for 100.0 USD (Txn: txn_1750579306.293586_100.0)	2025-06-22 16:01:46.293807	2025-06-22 16:01:46.293816	\N
200	124	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 16:01:46.345668	Subscription 'Pro' enrollment (Txn: txn_1750579306.339045_12.0)	2025-06-22 16:01:46.345686	2025-06-22 16:01:46.345698	\N
201	125	CREDIT_PURCHASE	100	USD	2025-06-22 16:21:38.317339	Credit recharge via test... for 100.0 USD (Txn: txn_1750580498.317019_100.0)	2025-06-22 16:21:38.317357	2025-06-22 16:21:38.317369	\N
202	125	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 16:21:38.468733	Subscription 'Pro' enrollment (Txn: txn_1750580498.459849_12.0)	2025-06-22 16:21:38.468753	2025-06-22 16:21:38.468765	\N
203	126	CREDIT_PURCHASE	100	USD	2025-06-22 16:26:32.498769	Credit recharge via test... for 100.0 USD (Txn: txn_1750580792.498259_100.0)	2025-06-22 16:26:32.498786	2025-06-22 16:26:32.498797	\N
204	126	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 16:26:32.55504	Subscription 'Pro' enrollment (Txn: txn_1750580792.548112_12.0)	2025-06-22 16:26:32.555058	2025-06-22 16:26:32.55507	\N
205	127	CREDIT_PURCHASE	100	USD	2025-06-22 16:42:32.054396	Credit recharge via test... for 100.0 USD (Txn: txn_1750581752.054148_100.0)	2025-06-22 16:42:32.054413	2025-06-22 16:42:32.054424	\N
206	127	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 16:42:32.115532	Subscription 'Pro' enrollment (Txn: txn_1750581752.107751_12.0)	2025-06-22 16:42:32.115552	2025-06-22 16:42:32.115564	\N
207	128	CREDIT_PURCHASE	100	USD	2025-06-22 16:50:55.992866	Credit recharge via test... for 100.0 USD (Txn: txn_1750582255.992619_100.0)	2025-06-22 16:50:55.992881	2025-06-22 16:50:55.992891	\N
208	128	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 16:50:56.051824	Subscription 'Pro' enrollment (Txn: txn_1750582256.042256_12.0)	2025-06-22 16:50:56.051841	2025-06-22 16:50:56.051853	\N
209	129	CREDIT_PURCHASE	100	USD	2025-06-22 17:15:21.141625	Credit recharge via test... for 100.0 USD (Txn: txn_1750583721.141312_100.0)	2025-06-22 17:15:21.141642	2025-06-22 17:15:21.141654	\N
210	129	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 17:15:21.206117	Subscription 'Pro' enrollment (Txn: txn_1750583721.19653_12.0)	2025-06-22 17:15:21.206141	2025-06-22 17:15:21.206154	\N
211	130	CREDIT_PURCHASE	100	USD	2025-06-22 17:20:51.286717	Credit recharge via test... for 100.0 USD (Txn: txn_1750584051.286306_100.0)	2025-06-22 17:20:51.286735	2025-06-22 17:20:51.286747	\N
212	130	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 17:20:51.362915	Subscription 'Pro' enrollment (Txn: txn_1750584051.3496_12.0)	2025-06-22 17:20:51.362964	2025-06-22 17:20:51.362981	\N
213	131	CREDIT_PURCHASE	100	USD	2025-06-22 17:23:25.767523	Credit recharge via test... for 100.0 USD (Txn: txn_1750584205.767191_100.0)	2025-06-22 17:23:25.767559	2025-06-22 17:23:25.767571	\N
214	131	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 17:23:25.831249	Subscription 'Pro' enrollment (Txn: txn_1750584205.822229_12.0)	2025-06-22 17:23:25.831268	2025-06-22 17:23:25.83128	\N
215	132	CREDIT_PURCHASE	100	USD	2025-06-22 17:28:26.92061	Credit recharge via test... for 100.0 USD (Txn: txn_1750584506.920014_100.0)	2025-06-22 17:28:26.920628	2025-06-22 17:28:26.92064	\N
216	132	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 17:28:26.988723	Subscription 'Pro' enrollment (Txn: txn_1750584506.978354_12.0)	2025-06-22 17:28:26.988744	2025-06-22 17:28:26.988757	\N
217	133	CREDIT_PURCHASE	100	USD	2025-06-22 17:34:56.053002	Credit recharge via test... for 100.0 USD (Txn: txn_1750584896.052747_100.0)	2025-06-22 17:34:56.05302	2025-06-22 17:34:56.053032	\N
218	133	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-22 17:34:56.116796	Subscription 'Pro' enrollment (Txn: txn_1750584896.107137_12.0)	2025-06-22 17:34:56.116842	2025-06-22 17:34:56.116875	\N
219	140	CREDIT_PURCHASE	100	USD	2025-06-25 04:22:15.680538	Credit recharge via test... for 100.0 USD (Txn: txn_1750796535.679908_100.0)	2025-06-25 04:22:15.680564	2025-06-25 04:22:15.680576	\N
220	146	CREDIT_PURCHASE	100	USD	2025-06-25 04:46:11.026354	Credit recharge via test... for 100.0 USD (Txn: txn_1750797971.026037_100.0)	2025-06-25 04:46:11.026371	2025-06-25 04:46:11.026383	\N
221	146	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-25 04:46:11.180461	Subscription 'Pro' enrollment (Txn: txn_1750797971.157268_12.0)	2025-06-25 04:46:11.180479	2025-06-25 04:46:11.180492	\N
222	147	CREDIT_PURCHASE	100	USD	2025-06-25 04:57:15.081965	Credit recharge via test... for 100.0 USD (Txn: txn_1750798635.081656_100.0)	2025-06-25 04:57:15.082001	2025-06-25 04:57:15.082016	\N
223	147	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-25 04:57:15.238657	Subscription 'Pro' enrollment (Txn: txn_1750798635.216813_12.0)	2025-06-25 04:57:15.238676	2025-06-25 04:57:15.238688	\N
224	167	CREDIT_PURCHASE	100	USD	2025-06-25 08:08:42.854148	Credit recharge via test... for 100.0 USD (Txn: txn_1750810122.853845_100.0)	2025-06-25 08:08:42.854169	2025-06-25 08:08:42.854183	\N
225	167	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-25 08:08:43.010897	Subscription 'Pro' enrollment (Txn: txn_1750810122.99423_12.0)	2025-06-25 08:08:43.010914	2025-06-25 08:08:43.010926	\N
226	168	CREDIT_PURCHASE	100	USD	2025-06-26 07:19:58.303242	Credit recharge via test... for 100.0 USD (Txn: txn_1750893598.302792_100.0)	2025-06-26 07:19:58.30327	2025-06-26 07:19:58.303283	\N
227	168	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-26 07:19:58.480143	Subscription 'Pro' enrollment (Txn: txn_1750893598.455068_12.0)	2025-06-26 07:19:58.480162	2025-06-26 07:19:58.480175	\N
228	169	CREDIT_PURCHASE	100	USD	2025-06-26 07:23:56.856343	Credit recharge via test... for 100.0 USD (Txn: txn_1750893836.855795_100.0)	2025-06-26 07:23:56.856364	2025-06-26 07:23:56.856378	\N
229	169	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-26 07:23:57.02619	Subscription 'Pro' enrollment (Txn: txn_1750893837.002343_12.0)	2025-06-26 07:23:57.02621	2025-06-26 07:23:57.026223	\N
230	170	CREDIT_PURCHASE	100	USD	2025-06-26 07:42:45.419971	Credit recharge via test... for 100.0 USD (Txn: txn_1750894965.419669_100.0)	2025-06-26 07:42:45.419992	2025-06-26 07:42:45.420004	\N
231	170	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-26 07:42:45.567144	Subscription 'Pro' enrollment (Txn: txn_1750894965.545731_12.0)	2025-06-26 07:42:45.567162	2025-06-26 07:42:45.567175	\N
232	171	CREDIT_PURCHASE	100	USD	2025-06-26 08:14:39.517058	Credit recharge via test... for 100.0 USD (Txn: txn_1750896879.51647_100.0)	2025-06-26 08:14:39.517092	2025-06-26 08:14:39.517113	\N
233	171	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-26 08:14:39.694065	Subscription 'Pro' enrollment (Txn: txn_1750896879.67255_12.0)	2025-06-26 08:14:39.694085	2025-06-26 08:14:39.694098	\N
234	172	CREDIT_PURCHASE	100	USD	2025-06-26 12:48:37.595108	Credit recharge via test... for 100.0 USD (Txn: txn_1750913317.5948_100.0)	2025-06-26 12:48:37.595126	2025-06-26 12:48:37.595138	\N
235	172	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-26 12:48:37.767603	Subscription 'Pro' enrollment (Txn: txn_1750913317.744339_12.0)	2025-06-26 12:48:37.767622	2025-06-26 12:48:37.767636	\N
236	173	CREDIT_PURCHASE	100	USD	2025-06-26 13:02:48.680207	Credit recharge via test... for 100.0 USD (Txn: txn_1750914168.679904_100.0)	2025-06-26 13:02:48.680224	2025-06-26 13:02:48.680236	\N
237	173	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-26 13:02:48.851377	Subscription 'Pro' enrollment (Txn: txn_1750914168.828161_12.0)	2025-06-26 13:02:48.851395	2025-06-26 13:02:48.851408	\N
238	174	CREDIT_PURCHASE	100	USD	2025-06-26 13:15:21.393673	Credit recharge via test... for 100.0 USD (Txn: txn_1750914921.393332_100.0)	2025-06-26 13:15:21.393691	2025-06-26 13:15:21.393703	\N
239	174	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-26 13:15:21.551237	Subscription 'Pro' enrollment (Txn: txn_1750914921.529765_12.0)	2025-06-26 13:15:21.551257	2025-06-26 13:15:21.55127	\N
240	175	CREDIT_PURCHASE	100	USD	2025-06-26 14:05:33.467105	Credit recharge via test... for 100.0 USD (Txn: txn_1750917933.466823_100.0)	2025-06-26 14:05:33.467123	2025-06-26 14:05:33.467135	\N
241	175	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-26 14:05:33.616657	Subscription 'Pro' enrollment (Txn: txn_1750917933.596736_12.0)	2025-06-26 14:05:33.616675	2025-06-26 14:05:33.616687	\N
242	176	CREDIT_PURCHASE	100	USD	2025-06-26 14:27:02.953126	Credit recharge via test... for 100.0 USD (Txn: txn_1750919222.952531_100.0)	2025-06-26 14:27:02.953145	2025-06-26 14:27:02.953158	\N
243	176	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-26 14:27:03.129521	Subscription 'Pro' enrollment (Txn: txn_1750919223.106427_12.0)	2025-06-26 14:27:03.12954	2025-06-26 14:27:03.129552	\N
244	177	CREDIT_PURCHASE	100	USD	2025-06-26 14:33:18.700902	Credit recharge via test... for 100.0 USD (Txn: txn_1750919598.700577_100.0)	2025-06-26 14:33:18.700919	2025-06-26 14:33:18.700931	\N
245	177	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-26 14:33:18.868154	Subscription 'Pro' enrollment (Txn: txn_1750919598.843504_12.0)	2025-06-26 14:33:18.868173	2025-06-26 14:33:18.868185	\N
246	178	CREDIT_PURCHASE	100	USD	2025-06-27 08:37:02.498623	Credit recharge via test... for 100.0 USD (Txn: txn_1750984622.498275_100.0)	2025-06-27 08:37:02.49864	2025-06-27 08:37:02.498652	\N
247	178	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-27 08:37:02.667201	Subscription 'Pro' enrollment (Txn: txn_1750984622.643734_12.0)	2025-06-27 08:37:02.667219	2025-06-27 08:37:02.667231	\N
248	179	CREDIT_PURCHASE	100	USD	2025-06-27 08:43:17.529573	Credit recharge via test... for 100.0 USD (Txn: txn_1750984997.52929_100.0)	2025-06-27 08:43:17.529591	2025-06-27 08:43:17.529603	\N
249	179	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-27 08:43:17.694155	Subscription 'Pro' enrollment (Txn: txn_1750984997.66903_12.0)	2025-06-27 08:43:17.69419	2025-06-27 08:43:17.694205	\N
250	180	CREDIT_PURCHASE	100	USD	2025-06-27 09:00:32.148226	Credit recharge via test... for 100.0 USD (Txn: txn_1750986032.147703_100.0)	2025-06-27 09:00:32.148245	2025-06-27 09:00:32.148257	\N
251	180	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-27 09:00:32.304102	Subscription 'Pro' enrollment (Txn: txn_1750986032.283483_12.0)	2025-06-27 09:00:32.304119	2025-06-27 09:00:32.304132	\N
252	181	CREDIT_PURCHASE	100	USD	2025-06-27 09:05:52.463563	Credit recharge via test... for 100.0 USD (Txn: txn_1750986352.463249_100.0)	2025-06-27 09:05:52.463581	2025-06-27 09:05:52.463592	\N
253	181	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-27 09:05:52.637974	Subscription 'Pro' enrollment (Txn: txn_1750986352.613794_12.0)	2025-06-27 09:05:52.637992	2025-06-27 09:05:52.638005	\N
254	182	CREDIT_PURCHASE	100	USD	2025-06-30 03:35:23.277473	Credit recharge via test... for 100.0 USD (Txn: txn_1751225723.277123_100.0)	2025-06-30 03:35:23.277489	2025-06-30 03:35:23.277501	\N
255	182	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-30 03:35:23.412731	Subscription 'Pro' enrollment (Txn: txn_1751225723.396614_12.0)	2025-06-30 03:35:23.412748	2025-06-30 03:35:23.41276	\N
256	183	CREDIT_PURCHASE	100	USD	2025-06-30 04:32:24.363618	Credit recharge via test... for 100.0 USD (Txn: txn_1751229144.363313_100.0)	2025-06-30 04:32:24.363637	2025-06-30 04:32:24.36365	\N
257	183	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-30 04:32:24.494862	Subscription 'Pro' enrollment (Txn: txn_1751229144.476063_12.0)	2025-06-30 04:32:24.494879	2025-06-30 04:32:24.494891	\N
258	184	CREDIT_PURCHASE	100	USD	2025-06-30 06:50:01.409162	Credit recharge via test... for 100.0 USD (Txn: txn_1751237401.408835_100.0)	2025-06-30 06:50:01.409183	2025-06-30 06:50:01.409198	\N
259	184	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-30 06:50:01.583925	Subscription 'Pro' enrollment (Txn: txn_1751237401.560266_12.0)	2025-06-30 06:50:01.583944	2025-06-30 06:50:01.583957	\N
260	185	CREDIT_PURCHASE	100	USD	2025-06-30 09:22:41.613728	Credit recharge via test... for 100.0 USD (Txn: txn_1751246561.613196_100.0)	2025-06-30 09:22:41.613747	2025-06-30 09:22:41.61376	\N
261	185	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-30 09:22:41.789615	Subscription 'Pro' enrollment (Txn: txn_1751246561.767718_12.0)	2025-06-30 09:22:41.789637	2025-06-30 09:22:41.78965	\N
262	186	CREDIT_PURCHASE	100	USD	2025-06-30 09:39:17.006237	Credit recharge via test... for 100.0 USD (Txn: txn_1751247557.005859_100.0)	2025-06-30 09:39:17.006262	2025-06-30 09:39:17.006275	\N
263	186	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-30 09:39:17.171826	Subscription 'Pro' enrollment (Txn: txn_1751247557.150277_12.0)	2025-06-30 09:39:17.17184	2025-06-30 09:39:17.171849	\N
264	187	CREDIT_PURCHASE	100	USD	2025-06-30 10:02:27.657821	Credit recharge via test... for 100.0 USD (Txn: txn_1751248947.657416_100.0)	2025-06-30 10:02:27.657841	2025-06-30 10:02:27.657853	\N
265	187	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-30 10:02:27.835908	Subscription 'Pro' enrollment (Txn: txn_1751248947.810132_12.0)	2025-06-30 10:02:27.835927	2025-06-30 10:02:27.83594	\N
266	188	CREDIT_PURCHASE	100	USD	2025-06-30 10:09:28.749301	Credit recharge via test... for 100.0 USD (Txn: txn_1751249368.748958_100.0)	2025-06-30 10:09:28.749319	2025-06-30 10:09:28.749331	\N
267	188	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-30 10:09:28.916051	Subscription 'Pro' enrollment (Txn: txn_1751249368.893871_12.0)	2025-06-30 10:09:28.91607	2025-06-30 10:09:28.916082	\N
268	189	CREDIT_PURCHASE	100	USD	2025-06-30 10:15:22.71132	Credit recharge via test... for 100.0 USD (Txn: txn_1751249722.711034_100.0)	2025-06-30 10:15:22.711338	2025-06-30 10:15:22.71135	\N
269	189	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-30 10:15:22.867586	Subscription 'Pro' enrollment (Txn: txn_1751249722.847436_12.0)	2025-06-30 10:15:22.867604	2025-06-30 10:15:22.867616	\N
270	190	CREDIT_PURCHASE	100	USD	2025-06-30 10:17:03.990432	Credit recharge via test... for 100.0 USD (Txn: txn_1751249823.989972_100.0)	2025-06-30 10:17:03.990449	2025-06-30 10:17:03.99046	\N
271	190	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-30 10:17:04.155166	Subscription 'Pro' enrollment (Txn: txn_1751249824.13148_12.0)	2025-06-30 10:17:04.155184	2025-06-30 10:17:04.155196	\N
272	191	CREDIT_PURCHASE	100	USD	2025-06-30 10:17:58.722905	Credit recharge via test... for 100.0 USD (Txn: txn_1751249878.722578_100.0)	2025-06-30 10:17:58.722925	2025-06-30 10:17:58.722937	\N
273	191	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-30 10:17:58.884784	Subscription 'Pro' enrollment (Txn: txn_1751249878.862059_12.0)	2025-06-30 10:17:58.884802	2025-06-30 10:17:58.884816	\N
274	192	CREDIT_PURCHASE	100	USD	2025-06-30 10:25:33.763951	Credit recharge via test... for 100.0 USD (Txn: txn_1751250333.763531_100.0)	2025-06-30 10:25:33.76397	2025-06-30 10:25:33.763983	\N
275	192	SUBSCRIPTION_PAYMENT	-12	USD	2025-06-30 10:25:33.939929	Subscription 'Pro' enrollment (Txn: txn_1751250333.913941_12.0)	2025-06-30 10:25:33.939949	2025-06-30 10:25:33.939963	\N
276	193	CREDIT_PURCHASE	100	USD	2025-07-01 01:26:02.680083	Credit recharge via test... for 100.0 USD (Txn: txn_1751304362.679675_100.0)	2025-07-01 01:26:02.680101	2025-07-01 01:26:02.680114	\N
277	193	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-01 01:26:02.85307	Subscription 'Pro' enrollment (Txn: txn_1751304362.828914_12.0)	2025-07-01 01:26:02.85309	2025-07-01 01:26:02.853103	\N
278	194	CREDIT_PURCHASE	100	USD	2025-07-01 01:47:36.033117	Credit recharge via test... for 100.0 USD (Txn: txn_1751305656.03268_100.0)	2025-07-01 01:47:36.033135	2025-07-01 01:47:36.033147	\N
279	194	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-01 01:47:36.191074	Subscription 'Pro' enrollment (Txn: txn_1751305656.171076_12.0)	2025-07-01 01:47:36.191092	2025-07-01 01:47:36.191104	\N
280	196	CREDIT_PURCHASE	100	USD	2025-07-01 03:18:18.900947	Credit recharge via test... for 100.0 USD (Txn: txn_1751311098.900622_100.0)	2025-07-01 03:18:18.900969	2025-07-01 03:18:18.900984	\N
281	196	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-01 03:18:19.067704	Subscription 'Pro' enrollment (Txn: txn_1751311099.047703_12.0)	2025-07-01 03:18:19.067722	2025-07-01 03:18:19.067735	\N
282	198	CREDIT_PURCHASE	100	USD	2025-07-01 07:00:30.449651	Credit recharge via test... for 100.0 USD (Txn: txn_1751324430.449323_100.0)	2025-07-01 07:00:30.449669	2025-07-01 07:00:30.449681	\N
283	198	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-01 07:00:30.625107	Subscription 'Pro' enrollment (Txn: txn_1751324430.602579_12.0)	2025-07-01 07:00:30.625126	2025-07-01 07:00:30.625139	\N
284	199	CREDIT_PURCHASE	100	USD	2025-07-01 07:21:42.574304	Credit recharge via test... for 100.0 USD (Txn: txn_1751325702.57403_100.0)	2025-07-01 07:21:42.574322	2025-07-01 07:21:42.574333	\N
285	199	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-01 07:21:42.731051	Subscription 'Pro' enrollment (Txn: txn_1751325702.711696_12.0)	2025-07-01 07:21:42.731069	2025-07-01 07:21:42.731081	\N
286	200	CREDIT_PURCHASE	100	USD	2025-07-01 08:00:07.208782	Credit recharge via test... for 100.0 USD (Txn: txn_1751328007.208312_100.0)	2025-07-01 08:00:07.208805	2025-07-01 08:00:07.208818	\N
287	200	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-01 08:00:07.371816	Subscription 'Pro' enrollment (Txn: txn_1751328007.349184_12.0)	2025-07-01 08:00:07.371835	2025-07-01 08:00:07.371848	\N
288	201	CREDIT_PURCHASE	100	USD	2025-07-01 09:15:59.30163	Credit recharge via test... for 100.0 USD (Txn: txn_1751332559.301174_100.0)	2025-07-01 09:15:59.301702	2025-07-01 09:15:59.301741	\N
289	201	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-01 09:15:59.455696	Subscription 'Pro' enrollment (Txn: txn_1751332559.434695_12.0)	2025-07-01 09:15:59.455714	2025-07-01 09:15:59.455726	\N
290	202	CREDIT_PURCHASE	100	USD	2025-07-01 09:56:20.043167	Credit recharge via test... for 100.0 USD (Txn: txn_1751334980.042904_100.0)	2025-07-01 09:56:20.043183	2025-07-01 09:56:20.043194	\N
291	202	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-01 09:56:20.230748	Subscription 'Pro' enrollment (Txn: txn_1751334980.199829_12.0)	2025-07-01 09:56:20.230765	2025-07-01 09:56:20.230777	\N
292	205	CREDIT_PURCHASE	100	USD	2025-07-02 03:38:06.410917	Credit recharge via test... for 100.0 USD (Txn: txn_1751398686.41058_100.0)	2025-07-02 03:38:06.410937	2025-07-02 03:38:06.41095	\N
293	205	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 03:38:06.587002	Subscription 'Pro' enrollment (Txn: txn_1751398686.563222_12.0)	2025-07-02 03:38:06.587029	2025-07-02 03:38:06.587045	\N
294	206	CREDIT_PURCHASE	100	USD	2025-07-02 03:39:00.73464	Credit recharge via test... for 100.0 USD (Txn: txn_1751398740.734352_100.0)	2025-07-02 03:39:00.734658	2025-07-02 03:39:00.73467	\N
295	206	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 03:39:00.913571	Subscription 'Pro' enrollment (Txn: txn_1751398740.88714_12.0)	2025-07-02 03:39:00.91359	2025-07-02 03:39:00.913615	\N
296	207	CREDIT_PURCHASE	100	USD	2025-07-02 03:40:47.762555	Credit recharge via test... for 100.0 USD (Txn: txn_1751398847.762258_100.0)	2025-07-02 03:40:47.762572	2025-07-02 03:40:47.762583	\N
297	207	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 03:40:47.925513	Subscription 'Pro' enrollment (Txn: txn_1751398847.904419_12.0)	2025-07-02 03:40:47.925534	2025-07-02 03:40:47.925546	\N
298	208	CREDIT_PURCHASE	100	USD	2025-07-02 03:58:13.954674	Credit recharge via test... for 100.0 USD (Txn: txn_1751399893.954347_100.0)	2025-07-02 03:58:13.954692	2025-07-02 03:58:13.954704	\N
299	208	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 03:58:14.112041	Subscription 'Pro' enrollment (Txn: txn_1751399894.093091_12.0)	2025-07-02 03:58:14.112059	2025-07-02 03:58:14.112071	\N
300	209	CREDIT_PURCHASE	100	USD	2025-07-02 04:00:35.468895	Credit recharge via test... for 100.0 USD (Txn: txn_1751400035.468404_100.0)	2025-07-02 04:00:35.468923	2025-07-02 04:00:35.468942	\N
301	209	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 04:00:35.639857	Subscription 'Pro' enrollment (Txn: txn_1751400035.616731_12.0)	2025-07-02 04:00:35.639876	2025-07-02 04:00:35.639889	\N
302	210	CREDIT_PURCHASE	100	USD	2025-07-02 04:02:46.777219	Credit recharge via test... for 100.0 USD (Txn: txn_1751400166.776924_100.0)	2025-07-02 04:02:46.777239	2025-07-02 04:02:46.777251	\N
303	210	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 04:02:46.932856	Subscription 'Pro' enrollment (Txn: txn_1751400166.912881_12.0)	2025-07-02 04:02:46.932875	2025-07-02 04:02:46.932888	\N
304	211	CREDIT_PURCHASE	100	USD	2025-07-02 04:12:59.968219	Credit recharge via test... for 100.0 USD (Txn: txn_1751400779.967923_100.0)	2025-07-02 04:12:59.968236	2025-07-02 04:12:59.968248	\N
305	211	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 04:13:00.139076	Subscription 'Pro' enrollment (Txn: txn_1751400780.115089_12.0)	2025-07-02 04:13:00.139097	2025-07-02 04:13:00.13911	\N
306	212	CREDIT_PURCHASE	100	USD	2025-07-02 04:20:29.134605	Credit recharge via test... for 100.0 USD (Txn: txn_1751401229.13431_100.0)	2025-07-02 04:20:29.134622	2025-07-02 04:20:29.134634	\N
307	212	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 04:20:29.291791	Subscription 'Pro' enrollment (Txn: txn_1751401229.272493_12.0)	2025-07-02 04:20:29.29181	2025-07-02 04:20:29.291823	\N
308	213	CREDIT_PURCHASE	100	USD	2025-07-02 04:24:05.176072	Credit recharge via test... for 100.0 USD (Txn: txn_1751401445.175758_100.0)	2025-07-02 04:24:05.17609	2025-07-02 04:24:05.176103	\N
309	213	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 04:24:05.343927	Subscription 'Pro' enrollment (Txn: txn_1751401445.320128_12.0)	2025-07-02 04:24:05.343946	2025-07-02 04:24:05.343959	\N
310	214	CREDIT_PURCHASE	100	USD	2025-07-02 04:41:16.538062	Credit recharge via test... for 100.0 USD (Txn: txn_1751402476.537521_100.0)	2025-07-02 04:41:16.538085	2025-07-02 04:41:16.538098	\N
311	214	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 04:41:16.709152	Subscription 'Pro' enrollment (Txn: txn_1751402476.684138_12.0)	2025-07-02 04:41:16.709171	2025-07-02 04:41:16.709183	\N
312	215	CREDIT_PURCHASE	100	USD	2025-07-02 05:05:52.62018	Credit recharge via test... for 100.0 USD (Txn: txn_1751403952.619544_100.0)	2025-07-02 05:05:52.620207	2025-07-02 05:05:52.62022	\N
313	215	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 05:05:52.812978	Subscription 'Pro' enrollment (Txn: txn_1751403952.787566_12.0)	2025-07-02 05:05:52.812997	2025-07-02 05:05:52.81301	\N
314	216	CREDIT_PURCHASE	100	USD	2025-07-02 05:35:55.45868	Credit recharge via test... for 100.0 USD (Txn: txn_1751405755.45843_100.0)	2025-07-02 05:35:55.458697	2025-07-02 05:35:55.458708	\N
315	216	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 05:35:55.58865	Subscription 'Pro' enrollment (Txn: txn_1751405755.571811_12.0)	2025-07-02 05:35:55.588668	2025-07-02 05:35:55.58868	\N
316	217	CREDIT_PURCHASE	100	USD	2025-07-02 06:13:37.984949	Credit recharge via test... for 100.0 USD (Txn: txn_1751408017.984651_100.0)	2025-07-02 06:13:37.984967	2025-07-02 06:13:37.98498	\N
317	217	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 06:13:38.157675	Subscription 'Pro' enrollment (Txn: txn_1751408018.131878_12.0)	2025-07-02 06:13:38.157694	2025-07-02 06:13:38.157707	\N
318	219	CREDIT_PURCHASE	100	USD	2025-07-02 08:14:18.504825	Credit recharge via test... for 100.0 USD (Txn: txn_1751415258.504469_100.0)	2025-07-02 08:14:18.504843	2025-07-02 08:14:18.504855	\N
319	219	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 08:14:18.688295	Subscription 'Pro' enrollment (Txn: txn_1751415258.661772_12.0)	2025-07-02 08:14:18.688314	2025-07-02 08:14:18.688327	\N
320	220	CREDIT_PURCHASE	100	USD	2025-07-02 09:22:13.7674	Credit recharge via test... for 100.0 USD (Txn: txn_1751419333.766754_100.0)	2025-07-02 09:22:13.767419	2025-07-02 09:22:13.767431	\N
321	220	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 09:22:13.911407	Subscription 'Pro' enrollment (Txn: txn_1751419333.894141_12.0)	2025-07-02 09:22:13.911425	2025-07-02 09:22:13.911438	\N
322	221	CREDIT_PURCHASE	100	USD	2025-07-02 09:29:12.58607	Credit recharge via test... for 100.0 USD (Txn: txn_1751419752.585377_100.0)	2025-07-02 09:29:12.58609	2025-07-02 09:29:12.586102	\N
323	221	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 09:29:12.743527	Subscription 'Pro' enrollment (Txn: txn_1751419752.722927_12.0)	2025-07-02 09:29:12.743545	2025-07-02 09:29:12.743557	\N
324	222	CREDIT_PURCHASE	100	USD	2025-07-02 09:48:51.909023	Credit recharge via test... for 100.0 USD (Txn: txn_1751420931.908745_100.0)	2025-07-02 09:48:51.90904	2025-07-02 09:48:51.909052	\N
325	222	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 09:48:52.067004	Subscription 'Pro' enrollment (Txn: txn_1751420932.045591_12.0)	2025-07-02 09:48:52.067022	2025-07-02 09:48:52.067034	\N
326	223	CREDIT_PURCHASE	100	USD	2025-07-02 10:04:49.798335	Credit recharge via test... for 100.0 USD (Txn: txn_1751421889.79802_100.0)	2025-07-02 10:04:49.798352	2025-07-02 10:04:49.798365	\N
327	223	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 10:04:49.968469	Subscription 'Pro' enrollment (Txn: txn_1751421889.944317_12.0)	2025-07-02 10:04:49.968489	2025-07-02 10:04:49.968502	\N
328	224	CREDIT_PURCHASE	100	USD	2025-07-02 10:24:29.41687	Credit recharge via test... for 100.0 USD (Txn: txn_1751423069.416599_100.0)	2025-07-02 10:24:29.416889	2025-07-02 10:24:29.416901	\N
329	224	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 10:24:29.569474	Subscription 'Pro' enrollment (Txn: txn_1751423069.550513_12.0)	2025-07-02 10:24:29.569495	2025-07-02 10:24:29.569509	\N
330	225	CREDIT_PURCHASE	100	USD	2025-07-02 10:32:12.17004	Credit recharge via test... for 100.0 USD (Txn: txn_1751423532.169744_100.0)	2025-07-02 10:32:12.170057	2025-07-02 10:32:12.170069	\N
331	225	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-02 10:32:12.349539	Subscription 'Pro' enrollment (Txn: txn_1751423532.323613_12.0)	2025-07-02 10:32:12.349562	2025-07-02 10:32:12.349602	\N
332	234	CREDIT_PURCHASE	100	USD	2025-07-08 07:50:59.562264	Credit recharge via test... for 100.0 USD (Txn: txn_1751932259.56194_100.0)	2025-07-08 07:50:59.562281	2025-07-08 07:50:59.562293	\N
333	234	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-08 07:50:59.745644	Subscription 'Pro' enrollment (Txn: txn_1751932259.720643_12.0)	2025-07-08 07:50:59.745662	2025-07-08 07:50:59.745675	\N
334	239	CREDIT_PURCHASE	100	USD	2025-07-08 09:53:31.520381	Credit recharge via test... for 100.0 USD (Txn: txn_1751939611.519995_100.0)	2025-07-08 09:53:31.5204	2025-07-08 09:53:31.520411	\N
335	239	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-08 09:53:31.824103	Subscription 'Pro' enrollment (Txn: txn_1751939611.803647_12.0)	2025-07-08 09:53:31.824123	2025-07-08 09:53:31.824136	\N
336	240	CREDIT_PURCHASE	100	USD	2025-07-08 09:58:45.626423	Credit recharge via test... for 100.0 USD (Txn: txn_1751939925.626149_100.0)	2025-07-08 09:58:45.62644	2025-07-08 09:58:45.626452	\N
337	240	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-08 09:58:45.752915	Subscription 'Pro' enrollment (Txn: txn_1751939925.735696_12.0)	2025-07-08 09:58:45.752932	2025-07-08 09:58:45.752944	\N
338	249	CREDIT_PURCHASE	100	USD	2025-07-11 10:56:55.688563	Credit recharge via test... for 100.0 USD (Txn: txn_1752202615.688256_100.0)	2025-07-11 10:56:55.688579	2025-07-11 10:56:55.68859	\N
339	249	SUBSCRIPTION_PAYMENT	-12	USD	2025-07-11 10:56:56.245419	Subscription 'Pro' enrollment (Txn: txn_1752202616.222791_12.0)	2025-07-11 10:56:56.245438	2025-07-11 10:56:56.245452	\N
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: curify
--

COPY public."user" (user_id, email, password_hash, username, google_id, account_type, current_credits, subscription_id, created_at, updated_at, first_name, last_name) FROM stdin;
1	test_user_d82cb399@example.com	$2b$12$I2UDvuVFiXCdDWK4TH1Vf.UbM7/0TPChi2PtPayfy.tOakHI44AfC	test_user_d82cb399	\N	PAY_AS_YOU_GO	0	\N	2025-06-17 10:15:23.743557	2025-06-17 10:15:23.74357	\N	\N
2	test_user_e9172bfd@example.com	$2b$12$xtbOMf14UzT4EeuBWrXzWeehPiTRNP089DPWtOHq4.W.xM4ibGeVW	test_user_e9172bfd	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 01:39:56.641803	2025-06-18 01:39:56.641817	\N	\N
3	test_user_0d180445@example.com	$2b$12$yVOjY6ubzuPPzo7DQUxe9exUdOhaeVfBtNv93g5qgl2.CHg8PNH2e	test_user_0d180445	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 01:44:50.231368	2025-06-18 01:44:50.231381	\N	\N
4	test_user_c038d060@example.com	$2b$12$cz7q2kLKTQQYxJ0dmL0PVu0s9Yqkkp2AAdJ1NCxvn4sLrEYlR5QyO	test_user_c038d060	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 01:47:15.724239	2025-06-18 01:47:15.724254	\N	\N
5	test_user_8766f467@example.com	$2b$12$VjEVapPXnt8Zpz/VTUUnNu4vdTybLaw5bynnyLJ4lLr46Hta.Qh7y	test_user_8766f467	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 01:52:25.207248	2025-06-18 01:52:25.207262	\N	\N
6	test_user_c8d6d690@example.com	$2b$12$ma7pRCUK.NwB2JD/CB5rzOAMBzpXxjisYoqROU0vLtgGvcFGYCvE.	test_user_c8d6d690	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 01:57:57.913659	2025-06-18 01:57:57.913674	\N	\N
7	test_user_66908395@example.com	$2b$12$PwIOxk890qqGwp18rZ6PYOLzKPRksrZF/YmpQQSITo3BDzr3O1qeO	test_user_66908395	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 02:54:53.177892	2025-06-18 02:54:53.177907	\N	\N
8	test_user_5e401830@example.com	$2b$12$cKgvO/nlSCWj34rGDYb/KuKC5MfyUr6nU4XnG4PA.7usCppuyTaAq	test_user_5e401830	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 03:33:18.635412	2025-06-18 03:33:18.635426	\N	\N
9	test_user_4bc26512@example.com	$2b$12$wRDb/4zGGhOKNMwR2uWQ5uytmf8aq8re6AXi0cRz3OUnacU0Y9mFq	test_user_4bc26512	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 04:38:32.260737	2025-06-18 04:38:32.260751	\N	\N
10	test_user_a8d7d031@example.com	$2b$12$flnnP/T7rlhGKpKpFUBkluwhmDPzb5zyhba87/RmyZdM6ILziqzH2	test_user_a8d7d031	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 04:56:07.521996	2025-06-18 04:56:07.522011	\N	\N
11	test_user_8584d486@example.com	$2b$12$xgm.9bCNOvwtOXzYQa1wieUtQT0SuXdt4EO8Z9.4Z9GvvvuhRk8hW	test_user_8584d486	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 06:52:35.915798	2025-06-18 06:52:35.915812	\N	\N
12	test_user_ed428ce9@example.com	$2b$12$N4Q6Y1EcfLqcJ75/16wM2Ov4oEzgZAa/KWJOL2Q6yItnGwX1AmQga	test_user_ed428ce9	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 07:06:35.580906	2025-06-18 07:06:35.58092	\N	\N
13	test_user_063d30aa@example.com	$2b$12$5XOafB1yfl.kIlvvpSD68ekaQvlhBixm9D234MrT0ClNVOkpHZwQq	test_user_063d30aa	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 07:15:14.273233	2025-06-18 07:15:14.273246	\N	\N
14	test_user_371b5c20@example.com	$2b$12$93SYjB6ujZBYic9LV/f4X.VNN0cmzaFoUUXaJwoqTH1O5G/oRqZY2	test_user_371b5c20	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 07:17:03.7724	2025-06-18 07:17:03.772413	\N	\N
15	test_user_a3cab285@example.com	$2b$12$oLD8FbhwaOJqxn/W7E4lFOHTq8oRgLxf9sMNEpzlsshUeuzEylnTK	test_user_a3cab285	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 07:18:45.660223	2025-06-18 07:18:45.660237	\N	\N
31	test_user_fe100de7@example.com	$2b$12$OchhqvHCZBlfJHcX49X6vehxZkFHSxc5TP0l2nbNMOMB.R6yoLKuW	test_user_fe100de7	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 10:37:16.204642	2025-06-18 10:37:16.597792	\N	\N
16	test_user_d1ec6b25@example.com	$2b$12$EIWguhd28/qsGzyd7yR31OfO8iHld5u7T2K4/ARQeM/TlAYq3jCWm	test_user_d1ec6b25	\N	PAY_AS_YOU_GO	100	\N	2025-06-18 07:20:35.236205	2025-06-18 07:20:35.519986	\N	\N
17	test_user_f3441b62@example.com	$2b$12$uLMGcERfkzbIfAuTLLIG/Ov2FbBF7XCxOSfCHl1CO8MitsQh/MlfK	test_user_f3441b62	\N	PAY_AS_YOU_GO	100	\N	2025-06-18 08:32:52.66606	2025-06-18 08:32:52.979712	\N	\N
18	test_user_53b0965a@example.com	$2b$12$lQKtk2j8uABG6txi.U8b7uhhXmQqT6940PD37URbbQAsOsFmuK93y	test_user_53b0965a	\N	PAY_AS_YOU_GO	100	\N	2025-06-18 08:37:21.475127	2025-06-18 08:37:21.771924	\N	\N
19	test_user_75999d20@example.com	$2b$12$oR5EoEuKWkozS1UqdO//3e8Wiy92kXxT1oAXygWU.3Gyii1oQKNdm	test_user_75999d20	\N	PAY_AS_YOU_GO	100	\N	2025-06-18 08:39:14.553982	2025-06-18 08:39:14.873813	\N	\N
20	test_user_7739e50c@example.com	$2b$12$teqVAQKQX/JTG3rFxyThp.EMi8tVoZS6QUuBCp1htgaF7N2x2/V1K	test_user_7739e50c	\N	PAY_AS_YOU_GO	100	\N	2025-06-18 08:44:50.335844	2025-06-18 08:44:50.631624	\N	\N
21	test_user_3d99cf4b@example.com	$2b$12$FrQzcBqb1fTPZX.GfQp3zuN7Y6.B.xZVe6KSFBGX8XxPgcAVLtmrq	test_user_3d99cf4b	\N	PAY_AS_YOU_GO	100	\N	2025-06-18 08:56:41.519601	2025-06-18 08:56:41.828167	\N	\N
22	test_user_51ccaec3@example.com	$2b$12$uU.UY.kDfe3INB9WzmhbJ.KcOXSjoGRlOsfn15UL8NLJKitu1SXwq	test_user_51ccaec3	\N	PAY_AS_YOU_GO	100	\N	2025-06-18 09:10:04.980179	2025-06-18 09:10:05.279267	\N	\N
23	test_user_fc0f771b@example.com	$2b$12$xguuND44lVeQfNtvEJdZ9uflobKfdBNWDm3CssUy/5NcKwA7.69Fi	test_user_fc0f771b	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 09:17:57.951492	2025-06-18 09:17:57.951508	\N	\N
24	test_user_9e38ac28@example.com	$2b$12$jaXl.ohcnyXoRnzGEvTEiOL8GL80LNv8O68suV3XTC4sRzRkGcVxa	test_user_9e38ac28	\N	PAY_AS_YOU_GO	100	\N	2025-06-18 09:54:47.898167	2025-06-18 09:54:48.263792	\N	\N
25	test_user_f7c510da@example.com	$2b$12$qdWfnIfTLhlCeF9VTVtWUupRf4jbEGfi0gq8YJIGx6l78mqMwJvfK	test_user_f7c510da	\N	PAY_AS_YOU_GO	100	\N	2025-06-18 09:59:17.268064	2025-06-18 09:59:17.618201	\N	\N
28	test_user_d0e5d4ec@example.com	$2b$12$503vQT4BTkHktA2WUIXoe.acfm1f.EJBrMK7Zow5VRVbXC1WewI.i	test_user_d0e5d4ec	\N	SUBSCRIPTION	188	4	2025-06-18 10:21:41.84614	2025-06-18 10:21:42.197624	\N	\N
26	test_user_071e0f35@example.com	$2b$12$FK.i7GPeRtucx2twMwjMLO4u2DyKmLEADXQbARC00lSbFT.dncCZ2	test_user_071e0f35	\N	SUBSCRIPTION	188	3	2025-06-18 10:13:08.740966	2025-06-18 10:13:09.087005	\N	\N
27	test_user_919dea99@example.com	$2b$12$foNrPlOCrPIcA2olL33vdeUKnmmAqfoUQNtiNKu9SGvllkyagUxLK	test_user_919dea99	\N	PAY_AS_YOU_GO	100	\N	2025-06-18 10:19:54.057062	2025-06-18 10:19:54.359088	\N	\N
29	test_user_5115a9cb@example.com	$2b$12$wFlA2ZVXulyiY5bN3rBfp.j.nDBnYy4YfwG/QfQQihcABWzlFAmo.	test_user_5115a9cb	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 10:32:26.894638	2025-06-18 10:32:27.326059	\N	\N
32	test_user_db77ee15@example.com	$2b$12$4dcSKeKv6yTFXqJRE7vVke4N7IXqwW9cfl2gV9GRKfvN2BvR2FeFa	test_user_db77ee15	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 10:40:10.55413	2025-06-18 10:40:10.93374	\N	\N
30	test_user_df471d4c@example.com	$2b$12$CLCI6tNhT2tRipARcbLQmucn2BpWpwEBUhuesgot98pII38muZsWm	test_user_df471d4c	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 10:33:38.223956	2025-06-18 10:33:38.639891	\N	\N
34	test_user_0062392c@example.com	$2b$12$Y/TM4t2J/zdOfxazIVqM2uPE5kZfkVkHHz6TrT47GSXiwGvkXO/zG	test_user_0062392c	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 10:54:22.264168	2025-06-18 10:54:22.722426	\N	\N
37	test_user_d8b07db4@example.com	$2b$12$BaatdULzzQGQLmYWTWvt1e75IsaZE1cS7KPKY8HYWKrergImj2iUi	test_user_d8b07db4	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 11:35:26.154817	2025-06-18 11:35:26.545783	\N	\N
33	test_user_622079c5@example.com	$2b$12$DeV8Yq7R3jrKVKdPXQUg8uXwwzAS2cSkoUySzJ3tBaDlHL1s/JQlq	test_user_622079c5	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 10:47:52.07515	2025-06-18 10:47:52.470623	\N	\N
36	test_user_2566ce7d@example.com	$2b$12$Hph5.ZOEIgSE62RjO4sMWegarFCN4AVrCl4cYJwlJYIo.VXbmli1.	test_user_2566ce7d	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 11:07:28.747934	2025-06-18 11:07:29.140327	\N	\N
35	test_user_8df41fca@example.com	$2b$12$qozwFochR1/dQ3C2re5hxuqzkUrncmvxigVAeCCOVhUpapnjH2CmK	test_user_8df41fca	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 11:00:45.055834	2025-06-18 11:00:45.462388	\N	\N
38	test_user_cff48933@example.com	$2b$12$ygkq2qDudf2ggUYetd8mxuHP5wG2M9/LD9SfuROy7x60HDDxP1QqC	test_user_cff48933	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 11:59:23.065416	2025-06-18 11:59:23.543654	\N	\N
40	test_user_e9007808@example.com	$2b$12$o9n/SfMKcgogejCHlOI26OeavrEx3sa4mOKCeBktULXicqjLKsfoy	test_user_e9007808	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 12:08:12.947839	2025-06-18 12:08:13.508745	\N	\N
39	test_user_22d23ae3@example.com	$2b$12$B37rroaszZ0u57puIOnONuFNkuwDfm2n6ULsQjXycDoAsigt6K8ea	test_user_22d23ae3	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 12:01:19.528581	2025-06-18 12:01:19.913076	\N	\N
41	test_user_1962120d@example.com	$2b$12$F50Qc5ENfGq6iOre0zgZG./kPcb32whu7jW/zMlvrs9T1R3UkUWFy	test_user_1962120d	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 12:19:11.030632	2025-06-18 12:19:11.43479	\N	\N
42	test_user_82ee6de8@example.com	$2b$12$PLoFI9.e0o3C3xZegpGneeAZVtgP6guHuvtA2m2L0FXuzahh9Dzzy	test_user_82ee6de8	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 12:25:55.972177	2025-06-18 12:25:56.361254	\N	\N
43	test_user_265a392a@example.com	$2b$12$8gHq9mftDh9C98lG.Z5Cbein7SlNrbL1AcuW0Hjv8T3xEfJz0J8Ye	test_user_265a392a	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 12:26:53.650198	2025-06-18 12:26:54.082084	\N	\N
61	test_user_5fd19dea@example.com	$2b$12$QWg6nesq9rrueiXSUAhGAOBvog89lAQrnLco0kNY.uuEsMB17RNdC	test_user_5fd19dea	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:07:45.432599	2025-06-18 15:07:45.843438	\N	\N
44	test_user_c431996b@example.com	$2b$12$GrHhoFk0kmerxWESksJ5FOfa0gGyUIxMEh8w8SEAwsgohjsUhFrkK	test_user_c431996b	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 12:33:15.739013	2025-06-18 12:33:16.143753	\N	\N
54	test_user_2ce5761a@example.com	$2b$12$AdMN6OGsiASyiw0gaBETT.pk.a4nTJssFJodIgtW/ByZmpYznfn.m	test_user_2ce5761a	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 14:47:19.696549	2025-06-18 14:47:20.090684	\N	\N
45	test_user_eeb9ae63@example.com	$2b$12$oqLEhxjunMbH5xLzbXNHzOiGxALhi3Al7u0EnA0Hrv/r0MKE6ziIK	test_user_eeb9ae63	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 12:38:09.171347	2025-06-18 12:38:09.633128	\N	\N
46	test_user_5a07bf56@example.com	$2b$12$uPUXnbS0HcwMgikHAlFeC.oU2LemWG9S2W41x7kxJZSiqbcIlZoYm	test_user_5a07bf56	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 12:38:59.027773	2025-06-18 12:38:59.360362	\N	\N
55	test_user_2b3cf2da@example.com	$2b$12$npXEgZkq/7Hzb23AHJ9gcuHWheaxAPR8pSHCF.YRBJ1JZib0QyTyy	test_user_2b3cf2da	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 14:48:17.169664	2025-06-18 14:48:17.558953	\N	\N
47	test_user_830e1232@example.com	$2b$12$D94ukSaFcfFKvjN8Pen9ROq.7JhGnB7kJISCP8xPnpaZwciGfNEfq	test_user_830e1232	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 12:55:12.915312	2025-06-18 12:55:13.321858	\N	\N
71	test_user_d8f9363d@example.com	$2b$12$fPupWNb1PTim7aluUpqZRO/8KDZAdOcCIDVd39KY90Wu6hDV6J3F2	test_user_d8f9363d	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:38:45.301825	2025-06-18 15:38:45.757269	\N	\N
62	test_user_46d312ca@example.com	$2b$12$Gp7tbidi1AB0xkLrdS2Zx.vfwecvOGCSg43XrPTmfkME3DQWNi6tO	test_user_46d312ca	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:10:51.948549	2025-06-18 15:10:52.337688	\N	\N
48	test_user_61a335b4@example.com	$2b$12$MxUK6ESqMi33FbSwNQLhZOKvP7ViUWpRx2rAbj5aRP7MDpJCJPCZC	test_user_61a335b4	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 12:56:48.728786	2025-06-18 12:56:49.131867	\N	\N
56	test_user_d9d38a31@example.com	$2b$12$ucZl323JTAcfjuUTiVJKlu0F0odHnkhQj1wBerYpLO87zqeFFWLYe	test_user_d9d38a31	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 14:58:46.816923	2025-06-18 14:58:47.231546	\N	\N
49	test_user_cfd34bdd@example.com	$2b$12$xTf.jr08lZajBZ0g/t0v2O8bEw3uEY119ReGTcyDbLUCw70KkCYX.	test_user_cfd34bdd	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 12:57:38.087762	2025-06-18 12:57:38.481382	\N	\N
67	test_user_58b30670@example.com	$2b$12$ABQ2Bn3u31/wAkX3yYuyW.X5rdmiLvXLXj0z89h/vmhfZq3AbBA2u	test_user_58b30670	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:27:28.70726	2025-06-18 15:27:29.123374	\N	\N
50	test_user_a2f5ff70@example.com	$2b$12$7mDA96xcP45/kEvEHQxeXOQaqrna3XJUzh2OE2eBt1pK6Y7T4jWwa	test_user_a2f5ff70	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 13:04:35.317778	2025-06-18 13:04:35.668165	\N	\N
57	test_user_eedbded8@example.com	$2b$12$Rt/r054EHwxBlz1TdEthXu0QF7kFYJ0RoXGZ3q5jaMwoKmfz8rEFG	test_user_eedbded8	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 14:59:26.878508	2025-06-18 14:59:27.265709	\N	\N
51	test_user_6c944e85@example.com	$2b$12$vponCcOcKkxHQ5eXnkbS1u.aUYdU1BwttUBDTenKAGY91PSget8pe	test_user_6c944e85	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 13:11:14.843132	2025-06-18 13:11:15.220639	\N	\N
63	test_user_ee1e46aa@example.com	$2b$12$pg6yQCftBHA9KnTCgXjid.Ow.FxLNKL7onEeyOWvmosjTHRZDZoUe	test_user_ee1e46aa	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:13:34.535709	2025-06-18 15:13:34.91977	\N	\N
52	test_user_d95fdc3a@example.com	$2b$12$VAl6GBoKLiXZkgShPQc/2eiPsXFBT3VyTEAHJaal5Knh3EeYk1ski	test_user_d95fdc3a	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 14:39:41.394988	2025-06-18 14:39:41.791964	\N	\N
58	test_user_c5e2befb@example.com	$2b$12$HCEkGX1UnQc.EaNIXxjWceMVSTVdYccSvaPvJ0IMHpwjHKAFDMcOe	test_user_c5e2befb	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:01:24.033365	2025-06-18 15:01:24.433698	\N	\N
53	test_user_668b382f@example.com	$2b$12$eGe4J40irfS9z/H.02Lu5u44sCGGlQGKTXsPcqu./j.Uwciy12xqm	test_user_668b382f	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 14:45:38.496292	2025-06-18 14:45:38.884511	\N	\N
72	test_user_6e388ac0@example.com	$2b$12$zMxxOVcL0tVLEiZCgbRdAuIPJJfuSXljlZgBWCBsypvjkVH4yBnA2	test_user_6e388ac0	\N	PAY_AS_YOU_GO	0	\N	2025-06-18 16:01:40.604779	2025-06-18 16:01:40.604839	\N	\N
59	test_user_600e5c61@example.com	$2b$12$mMbkCecIYqC0OVhYSmfJs.EGxP70Vc6v1mj8k1UCbPY2TUOy7mrbS	test_user_600e5c61	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:04:15.810985	2025-06-18 15:04:16.277528	\N	\N
64	test_user_607e6fa6@example.com	$2b$12$pKBR6A1maGWgwuda7iW97eoe4JgFIaQIH3aVwdh7ciw4OvOag6LSG	test_user_607e6fa6	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:14:56.156471	2025-06-18 15:14:56.500835	\N	\N
60	test_user_24cc05e5@example.com	$2b$12$SA6J.b6uHv6hkCnQzbsUseiab51bBTx5p0P01WVxooyQa9j3aWQ..	test_user_24cc05e5	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:05:44.808807	2025-06-18 15:05:45.203495	\N	\N
68	test_user_10c41cdc@example.com	$2b$12$WRZKi2TYFuWds7TzgvnzsOmGNc8HMO8wXVvYhJyWZQ52E5lxyaWKa	test_user_10c41cdc	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:28:50.331695	2025-06-18 15:28:50.75072	\N	\N
77	test_user_20f9bd14@example.com	$2b$12$f8LDb64bzh3mzRTnaCNmUep5mb21Sl8G3Fr/brsgPRw.6XdeZWZce	test_user_20f9bd14	\N	PAY_AS_YOU_GO	188	\N	2025-06-19 01:30:17.205888	2025-06-19 01:30:17.648704	\N	\N
75	test_user_1a2ef6f9@example.com	$2b$12$CahTWFg5GWIpV80XAOgLi.KjqYSDLwmTKXUngISv5/U2caclQnh.m	test_user_1a2ef6f9	\N	PAY_AS_YOU_GO	188	\N	2025-06-19 00:36:53.362292	2025-06-19 00:36:53.82765	\N	\N
65	test_user_69f2bfad@example.com	$2b$12$skpvMPQhCToFLu84xMuYS.P3YnpdSATh4qU/aOyoXLSidi27Qc9dC	test_user_69f2bfad	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:16:34.670385	2025-06-18 15:16:35.138286	\N	\N
69	test_user_5d90865c@example.com	$2b$12$QD0RpsM8PtMFyAn63YbvXu8vUQ8cKXlA56ko0NK2L3wetyK8ZeU8G	test_user_5d90865c	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:30:09.360842	2025-06-18 15:30:09.74777	\N	\N
66	test_user_bd566529@example.com	$2b$12$.Mi7GPT.A.MTkSPmTIeQVO9cRkRsbkVVVr7aU/AO/seul4KgoyayG	test_user_bd566529	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:25:42.488677	2025-06-18 15:25:42.906742	\N	\N
73	test_user_fde7b339@example.com	$2b$12$.RWvc3P1apn3xHfAWaagz.KuCkvjd5F6HiChAP7fzS1LV44lpt7Wi	test_user_fde7b339	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 16:03:46.9513	2025-06-18 16:03:48.330764	\N	\N
70	test_user_2e1b9a44@example.com	$2b$12$DuEyO0TFqjnVQ.X7TGdDR.grWQDUutR5H973DcG592BnLCyE9s/Zq	test_user_2e1b9a44	\N	PAY_AS_YOU_GO	188	\N	2025-06-18 15:36:07.619138	2025-06-18 15:36:08.021424	\N	\N
74	test_user_21efcb91@example.com	$2b$12$l3evWHAyoIUphPEfffC5n.PN3o4q23R.sSTQPLyuQsvyxWd81rLem	test_user_21efcb91	\N	PAY_AS_YOU_GO	188	\N	2025-06-19 00:23:03.254476	2025-06-19 00:23:03.712888	\N	\N
76	test_user_0da71860@example.com	$2b$12$N1jXES.MbSsSL8cuSqqjOuvjtg/ifwaEPR6jGy2R7yS1q.X1jRtiC	test_user_0da71860	\N	PAY_AS_YOU_GO	188	\N	2025-06-19 01:18:00.515233	2025-06-19 01:18:00.951723	\N	\N
80	test_user_4613f454@example.com	$2b$12$vcE59Ru.AV3nI8VpkQ0xMe1kZC5DRjy5kInu7Zt5kCoew42gAAXCS	test_user_4613f454	\N	PAY_AS_YOU_GO	188	\N	2025-06-19 04:06:43.003569	2025-06-19 04:06:43.517504	\N	\N
79	test_user_68a2d484@example.com	$2b$12$4gWGiktyyMNVSWs2jGykTeMqd80.e6mTUJYMnk3OqztQBueHb0Nea	test_user_68a2d484	\N	PAY_AS_YOU_GO	188	\N	2025-06-19 03:04:05.665802	2025-06-19 03:04:06.273112	\N	\N
78	test_user_7b249526@example.com	$2b$12$1rL2uRt6yBrg9w2JkJewxe0isn/8fv5QDLsvmZC9GfN.0p/xvV08y	test_user_7b249526	\N	PAY_AS_YOU_GO	188	\N	2025-06-19 01:46:24.628169	2025-06-19 01:46:25.118583	\N	\N
82	test_user_022c8716@example.com	$2b$12$9e9HJVTs9VX5Per7vRyo8u/mxulqQoExTpE/SizfCnlM6guvzu9VG	test_user_022c8716	\N	PAY_AS_YOU_GO	188	\N	2025-06-19 04:26:05.476148	2025-06-19 04:26:05.97895	\N	\N
81	test_user_556922a1@example.com	$2b$12$GdqPd8zULEjvIucYu7lsP.FEYSx/MwmtjJjRO9u0HCJPgj2gBYx1q	test_user_556922a1	\N	PAY_AS_YOU_GO	188	\N	2025-06-19 04:17:03.457758	2025-06-19 04:17:03.987298	\N	\N
83	test_user_b2ce361c@example.com	$2b$12$.YstTmN4RWRY4rRkdHRNIOSaF1qhSmBYECGqlniarN/YG3K9U2lFi	test_user_b2ce361c	\N	PAY_AS_YOU_GO	188	\N	2025-06-19 05:02:22.473278	2025-06-19 05:02:22.920485	\N	\N
84	test_user_be9dd709@example.com	$2b$12$qzvvSQ9yj9FykzU5ZxENzOLk3MecUPH/rHHSWScwjOKyHrYY0BchS	test_user_be9dd709	\N	PAY_AS_YOU_GO	0	\N	2025-06-19 05:50:45.253831	2025-06-19 05:50:45.253846	\N	\N
85	test_user_f2a11fb4@example.com	$2b$12$BP4T1INCdAxNhv0oOV8WFul88sGxSghkAUqOaZIcOwWbnck.iH0TK	test_user_f2a11fb4	\N	PAY_AS_YOU_GO	0	\N	2025-06-19 05:55:30.419198	2025-06-19 05:55:30.419223	\N	\N
86	test_user_550d3d47@example.com	$2b$12$HdrK2Qj6stELW8GMIirEdu/JMZXyP0RTAjwLWGCzaJkpNXsI6prsS	test_user_550d3d47	\N	PAY_AS_YOU_GO	188	\N	2025-06-19 06:20:19.137169	2025-06-19 06:20:19.586863	\N	\N
104	test_user_d6ab8baa@example.com	$2b$12$ImyFUgXxFAnCoGp0kGzIYe3dECxzz9X2EYUW8uHzF27fLaNnogKSi	test_user_d6ab8baa	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 11:56:06.90404	2025-06-21 11:56:07.27538	\N	\N
87	test_user_374f5986@example.com	$2b$12$qJG8oNaQdf6nv09XRCJHYu6.Hlfaiyyoq5U7dRh5SGtW//ZWRaHHC	test_user_374f5986	\N	PAY_AS_YOU_GO	188	\N	2025-06-19 07:54:25.708881	2025-06-19 07:54:26.150972	\N	\N
97	test_user_c7bd6156@example.com	$2b$12$5yUHNBgDWIAQEkvGh4FY.uCmERUMpmZys/MvjlQmXcVtEtl7IxngK	test_user_c7bd6156	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 11:10:47.385213	2025-06-21 11:10:47.880491	\N	\N
88	test_user_79dcbf34@example.com	$2b$12$8WmxmTyCQWGvp0blhiTGeuh74amLFnnatxMufWIfQAcs6sWVU8jey	test_user_79dcbf34	\N	PAY_AS_YOU_GO	188	\N	2025-06-20 11:33:08.584005	2025-06-20 11:33:09.057677	\N	\N
119	test_user_59dbf715@example.com	$2b$12$JTlsILoGz.2rP9I1GuAWTOvByvkFmmEqPrN5/pwYeMsXQAIB/QOU6	test_user_59dbf715	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 15:09:54.565504	2025-06-22 15:09:55.005446	\N	\N
89	test_user_0d088964@example.com	$2b$12$WA517nD7kuB/W7.xZ1gjwOMB90sN.AJrB7/LisKnCRzP/qgTlBoEm	test_user_0d088964	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 09:12:04.901606	2025-06-21 09:12:05.427785	\N	\N
98	test_user_e70db3b9@example.com	$2b$12$xfl7fzUTTfSNa7xI3LrbY.MKgbDVF47tBvGWC93OwCcxKr.7/mcpS	test_user_e70db3b9	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 11:16:03.093879	2025-06-21 11:16:03.472829	\N	\N
90	test_user_41ee7d39@example.com	$2b$12$/P00NK2abv9HmQw1Mol7Tuo3CxHKXSTd2bALp8BPGCGpXeqF5.0wS	test_user_41ee7d39	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 09:31:31.155124	2025-06-21 09:31:31.621061	\N	\N
114	test_user_dfe9addc@example.com	$2b$12$eciRZDDJgc0wvvKIxJOxXuSUUwYAGrPkka8lw.qA.BD.2DpkTyDOS	test_user_dfe9addc	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 14:30:16.44502	2025-06-22 14:30:17.781541	\N	\N
105	test_user_eb00a837@example.com	$2b$12$EhWhSHjVGCIBP0pVllrsH.IUBR6sJg7Q91SQf2Cj7haMdodqCswHa	test_user_eb00a837	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 12:03:23.411547	2025-06-21 12:03:23.873037	\N	\N
91	test_user_9fb994d5@example.com	$2b$12$PW8GU7ICBCR4PoEq45DR..oHiwkDA.3Oq.RANOp6PUF1nE/ZnIgHC	test_user_9fb994d5	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 09:37:24.301449	2025-06-21 09:37:24.684999	\N	\N
99	test_user_975a000a@example.com	$2b$12$HLQ7p3rGJ74vjyt7zaRM3u8qq9om9d9h.J9PJHPzIieDY1PXYAGw.	test_user_975a000a	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 11:19:19.717485	2025-06-21 11:19:20.102286	\N	\N
92	test_user_6b5d3e0e@example.com	$2b$12$8kbyiq5vCkaImrtN6q3BN.EvJqCRAYtmu.IzjmiHX7wHUHPVXK/Uq	test_user_6b5d3e0e	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 09:44:44.162799	2025-06-21 09:44:44.571352	\N	\N
110	test_user_530b32da@example.com	$2b$12$6sxV1/aXNmZUR6gyreifxeDZKUuqFrBixuT8Y2soAYPPZGiFl0Jua	test_user_530b32da	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 11:43:18.966454	2025-06-22 11:43:19.362389	\N	\N
93	test_user_2fee3065@example.com	$2b$12$FQYp6LFz/GESrxNFZFv3w.xkNRkljLhlpjrYpXrY2O2MDf82nXzvG	test_user_2fee3065	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 09:51:26.529098	2025-06-21 09:51:26.944339	\N	\N
100	test_user_81a3a92c@example.com	$2b$12$wVV1l5SZUL8tWixLFs..MO.OB4EiYkOIbTsFTaGMLGsoszK0BfTbK	test_user_81a3a92c	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 11:22:25.629277	2025-06-21 11:22:25.999137	\N	\N
94	test_user_604332e8@example.com	$2b$12$opN1VKoJp4eHxAwBv/iyDOobhbeV13KHzj3pLogEQUSzPP3DWhHuG	test_user_604332e8	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 10:01:22.934693	2025-06-21 10:01:23.573187	\N	\N
106	test_user_21fd2cca@example.com	$2b$12$/ofgSnk3ib8FHHUJnAodc.U6iLzlh1Z5s/ry494qmE1aVhAik.yj6	test_user_21fd2cca	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 12:18:11.738571	2025-06-21 12:18:12.178507	\N	\N
95	test_user_fb63ce8a@example.com	$2b$12$4CIYHtZp5G886GrGPrYEoODOA.HHTG1o1cTRkOrXhi5ro.u5AN/bO	test_user_fb63ce8a	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 10:34:46.371829	2025-06-21 10:34:46.808606	\N	\N
101	test_user_042491b8@example.com	$2b$12$Yl3IVFexhBYqLIXfQd6LC.YeJmjB1SR9OnFSeaOQ3PmmPNC3vgs5q	test_user_042491b8	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 11:33:38.182991	2025-06-21 11:33:38.586735	\N	\N
96	test_user_9c0fd118@example.com	$2b$12$3umFGNsU5R09FKpqwZx27u5uqR0CARE8Vf5gYa.skJmDGAH/7cCg.	test_user_9c0fd118	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 10:46:38.362703	2025-06-21 10:46:38.850494	\N	\N
117	test_user_88d75c60@example.com	$2b$12$VRDeBrSDZX56OJke7lDkXur8K33OvoDftfg6byaTZEd1g8CD3cmZO	test_user_88d75c60	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 14:58:20.136621	2025-06-22 14:58:21.249693	\N	\N
102	test_user_c3a8d031@example.com	$2b$12$.R1czSAqqDC99ZtQbi5xUezUh6zv5/83AkjVZJoYz.vVJ2EqHVMnm	test_user_c3a8d031	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 11:44:38.280927	2025-06-21 11:44:38.682482	\N	\N
107	test_user_f6bdbc85@example.com	$2b$12$sPJvUbRYQmwN/K9JdAKil.96gWdSpnmDq6940OUyPTos9AQZZ2DHG	test_user_f6bdbc85	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 12:27:09.985864	2025-06-21 12:27:10.479295	\N	\N
103	test_user_67101e32@example.com	$2b$12$UeA2Jokw1QOF8GkEqRu1euAeeRMNAeqYsm/ib3QSJ0ggaLyJ7eD9W	test_user_67101e32	\N	PAY_AS_YOU_GO	188	\N	2025-06-21 11:53:54.928981	2025-06-21 11:53:55.345028	\N	\N
111	test_user_823dafda@example.com	$2b$12$7pkoOOy9NYeUzHQcgeaNfu4YRWu3xoTh0KCrzzEyaJz2DWQRjJoIm	test_user_823dafda	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 11:52:09.014782	2025-06-22 11:52:09.448233	\N	\N
115	test_user_c68fa075@example.com	$2b$12$7Sf5E7yX.kqcO4YpzLMqYeWQY7PHg1FrpT47ZM2ymBdXh4i5CtnLy	test_user_c68fa075	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 14:33:23.483707	2025-06-22 14:33:24.495867	\N	\N
108	test_user_d4e76711@example.com	$2b$12$df3fXHiTAnrUgIcWcBFivuSNbjI7yCu/zhOiz10smxaWVEfQPhBFq	test_user_d4e76711	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 11:12:53.224783	2025-06-22 11:12:53.737392	\N	\N
112	test_user_cb1e8796@example.com	$2b$12$XqdzhsZFxwUHs5CUeoleg.cDFcWYFAEPYLtZRlOw5Ous.5o0KCkaK	test_user_cb1e8796	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 12:02:41.752328	2025-06-22 12:02:42.290035	\N	\N
109	test_user_501ec90d@example.com	$2b$12$YQ0aJ82Huqtwk0vXphTmXuSTd3xCf8pMhcjr5DvVJ5F84Xu4Rt8uG	test_user_501ec90d	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 11:34:17.874559	2025-06-22 11:34:18.310938	\N	\N
113	test_user_88c9b7c2@example.com	$2b$12$qtmOyFV6a/1zRrjwKNI6h.yLVEIoPdu81KPTD1c8kHUo94wawLwU2	test_user_88c9b7c2	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 13:48:13.207402	2025-06-22 13:48:13.645532	\N	\N
122	test_user_fb4c3491@example.com	$2b$12$raofOeQ4OHg/z8uqVHUMm.xZzWESLX1Wv4LTpszdazvPKAYZ/dCM.	test_user_fb4c3491	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 15:45:08.878699	2025-06-22 15:45:09.288648	\N	\N
118	test_user_4ef517e6@example.com	$2b$12$26G6Yzglx/4dz5DMACn.GuQgGp21GDrJWH6C4/nPxoYs9WmdGx2N.	test_user_4ef517e6	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 15:06:55.892718	2025-06-22 15:06:57.136206	\N	\N
116	test_user_0e09b31e@example.com	$2b$12$vMzlkt6DIKkLYCx6ZoJDVuz5tSU7NsKIcbcxBlc9el1gyKMRVQheK	test_user_0e09b31e	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 14:48:00.283742	2025-06-22 14:48:00.824838	\N	\N
121	test_user_6735da95@example.com	$2b$12$qZbQlr7WPwEdZgRHP88HXun1Lkuewpr0otI6Z.7yjWN8j/gbhmOnS	test_user_6735da95	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 15:34:07.499964	2025-06-22 15:34:07.87809	\N	\N
120	test_user_5dd520ec@example.com	$2b$12$VtX4gCI2M8WFAIwA0dfezuEVJ7S9/QW10Vk4ge1NpC/mgkcHqsRW2	test_user_5dd520ec	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 15:28:45.869443	2025-06-22 15:28:46.29957	\N	\N
123	test_user_02ecf145@example.com	$2b$12$M0MBko/4EORTlRbZBKaXzOQ9db1s57g9ku0afL4P2vUnDDMxqa7Be	test_user_02ecf145	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 15:55:11.181354	2025-06-22 15:55:11.610673	\N	\N
125	test_user_84f633b8@example.com	$2b$12$HULHdROhZPdc5gB64gKYreGRaz3CwuG.PBb9tnfu7kD0hBLlwhIwu	test_user_84f633b8	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 16:21:37.989357	2025-06-22 16:21:38.523712	\N	\N
124	test_user_bea52be0@example.com	$2b$12$au0qvgDaWoZ8yq3MyvLTQec73mtnFbaUMVwMBDxmOQssPHAZw2O5y	test_user_bea52be0	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 16:01:45.998634	2025-06-22 16:01:46.379646	\N	\N
126	test_user_679665b2@example.com	$2b$12$xx40J9Q8YCrKwpfhKKps1eg1i83kwnaTTtadLrjE2wTjAnfjVHXve	test_user_679665b2	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 16:26:32.200412	2025-06-22 16:26:32.593414	\N	\N
127	test_user_aacebda3@example.com	$2b$12$xZElmKgoCGpsJdqfObJquOpq3P/c.Ax88SQwUEQu7evgBhqlkYCTy	test_user_aacebda3	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 16:42:31.745679	2025-06-22 16:42:32.153566	\N	\N
128	test_user_81cf398d@example.com	$2b$12$Nm2fuPSfau.Vfwt6au60GuflvPQauEcsNTYq8NXxthZD4EOUyCRb2	test_user_81cf398d	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 16:50:55.715544	2025-06-22 16:50:56.103699	\N	\N
129	test_user_4ffad2cb@example.com	$2b$12$FdetnKfpDGLMEDGjklhurekFEXZz4hk0WtShw/CN8E6PNBtopyKj.	test_user_4ffad2cb	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 17:15:20.838107	2025-06-22 17:15:21.250515	\N	\N
130	test_user_b90205e2@example.com	$2b$12$5JU7uk8GcSXOn4sa3qHopOPjyR0PhxBMPg4DIQxmEtkka0o2aeAz.	test_user_b90205e2	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 17:20:50.963824	2025-06-22 17:20:51.415425	\N	\N
131	test_user_f7d3031c@example.com	$2b$12$T2F/o1AJcInT2Ba4NTGAIOZ4NrMUBNoyz1wcfEPfmjEkhhtm3KIOi	test_user_f7d3031c	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 17:23:25.415634	2025-06-22 17:23:25.874321	\N	\N
132	test_user_a2420ca5@example.com	$2b$12$ye/O48vC2PCRzioUaTsFAulIcEtmI7D2QW/2uaRc6NGyrCCC5E1fy	test_user_a2420ca5	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 17:28:26.635775	2025-06-22 17:28:27.040676	\N	\N
133	test_user_a9810ed6@example.com	$2b$12$z69ZdggDC70fJZy/.KvBlOsTX.VdhJabUworkRNkRDb8QmTITE34.	test_user_a9810ed6	\N	PAY_AS_YOU_GO	188	\N	2025-06-22 17:34:55.760082	2025-06-22 17:34:56.175599	\N	\N
134	testrdeandsom@curify.ai	$2b$12$5T4UFL0RiRIvGcx2MYRTj.uuIAFxBfG0/jwun2oL77n2UtGeSR/DW	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 03:48:45.209091	2025-06-25 03:48:45.209105	\N	\N
135	test_user_99b6da2d@example.com	$2b$12$Q0KgeAxxUakxBSRxRjGx/.AnJf7mcBETLnpwFrXjh3IWg5s.NITGm	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 03:51:32.53086	2025-06-25 03:51:32.530873	\N	\N
136	test_user_f67b3915@example.com	$2b$12$TK7fFoKjqVcSA0mbDmu5rOIhka2dHrnL006bRScnl/feeGqlOfwWC	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 04:00:46.302675	2025-06-25 04:00:46.302689	\N	\N
137	test_user_8c01388e@example.com	$2b$12$bDAB7/7fzRt14vEciwR.i.3r.OG/21Kz7YA1i2WmWTSDLMi1IBn4K	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 04:02:00.375667	2025-06-25 04:02:00.37568	\N	\N
138	e2@q.c	$2b$12$XjkEEmc5MTe8Rne2Qte9K./X20mKFkoNS6dQVZ.txE1da.6Yp1ErC	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 04:07:33.80575	2025-06-25 04:07:33.805763	\N	\N
139	e2@q.a	$2b$12$WsBHAiQ97pYapyYfPhVEOeKvBJ9lntyUkpfaVWZSHV6Gv1e5wC2ia	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 04:14:59.464402	2025-06-25 04:14:59.464416	\N	\N
140	test_user_b46725f8@example.com	$2b$12$ek7qxdtqOtkSrE8o3kWQ5uvSy2JgxkEpOLnmxm0SFsUujKDD.QvvK	\N	\N	PAY_AS_YOU_GO	100	\N	2025-06-25 04:22:15.325834	2025-06-25 04:22:15.680115	\N	\N
141	w12w@q.d	$2b$12$iHeHbtk9gWNdR3W96OXLKO.0ZOftYR075NGBsFU9/7io3eJXs7gi.	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 04:29:57.488655	2025-06-25 04:29:57.488668	\N	\N
142	e@qc.d	$2b$12$txFVMJ8paoZibRfanBhal.DpuY06BEWvkWsf.OBuS.2khleyCvVUW	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 04:31:07.68174	2025-06-25 04:31:07.681758	\N	\N
143	w12w@dc.c	$2b$12$HQuE3RqqagCZAsgsYvKd6uv9CptIkOceenhLDwB.4ZVBTEZoFlJSK	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 04:32:19.457042	2025-06-25 04:32:19.457068	\N	\N
144	w1@q.a	$2b$12$TOD0EumB0wLPKOm.pr45x.6J0qsHb8z2l34iRDDGuyjttBxMQPM0W	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 04:41:56.824454	2025-06-25 04:41:56.824469	\N	\N
145	1w@c.ad	$2b$12$aCN71q2oARlyxLPROgJvbubKibxDviAw5Hf74UUj9cvQDgcSuwaRe	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 04:43:23.188726	2025-06-25 04:43:23.18874	\N	\N
146	test_user_67202d2d@example.com	$2b$12$isMMv9HySb8qkH04oh421e/qyProwWdLbJctKC7rIaLZkoxRiZZoq	\N	\N	SUBSCRIPTION	188	107	2025-06-25 04:46:10.674279	2025-06-25 04:46:11.180306	\N	\N
173	test_user_3b6dfbbc@example.com	$2b$12$v6RZqk/Cv2vIkMlhXuVXzerUApCsGy8.Opm9Gs0Ny.b7F5ofgdWJm	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-26 13:02:48.328344	2025-06-26 13:02:49.060272	\N	\N
147	test_user_2bce302f@example.com	$2b$12$uizfzAoTrlU68xC.ahK3D.ckr8TL2FWJFA9xU83EJLx3QWZ2hFKpS	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-25 04:57:14.719259	2025-06-25 04:57:15.427007	\N	\N
148	15@qw.n	$2b$12$BHNybytL90.FDyq3LUqgHurkYofk1PXvDLvT8hIbIdEhnCGc2Gdv.	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:03:42.543852	2025-06-25 05:03:42.543865	\N	\N
149	w1w@q.a	$2b$12$L74rsgmoCBmqGiHTSegiFu8sPv76SU2yShmkPnct3XvnW3KibmFU.	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:07:08.365789	2025-06-25 05:07:08.365817	\N	\N
150	e1d.cascd@ca.c	$2b$12$aOzFmlbvwWUbbwdeWM8m2.bf/rFlSClsFs5nW041Zj1qFa/M64H9i	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:24:39.512336	2025-06-25 05:24:39.51235	\N	\N
151	w1@c.v	$2b$12$/DD5XYwYOnsSvRDUXlkRMOsEFXXF3XTEWg.edvKU6xykwkF4lbWVW	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:28:45.814528	2025-06-25 05:28:45.814542	\N	\N
152	e1@c.c	$2b$12$YzNkR5h.20T0z/qzEyMqBOKGubCba0jYFTymK4sinsOYjJFzIwiaW	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:30:13.806314	2025-06-25 05:30:13.806331	\N	\N
153	e@a.c	$2b$12$lwikFkteu9KUYHDh.EoAHO1R.TOPh5AegEciExlFWboKDP0fieqLm	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:31:07.210383	2025-06-25 05:31:07.2104	\N	\N
154	1@q.a	$2b$12$67uox6NhegmqZtqdipD0NOPAfz/wmMFGjHx3fRpKEiWh7SGoY18C6	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:32:11.210933	2025-06-25 05:32:11.210947	\N	\N
155	4@a.q	$2b$12$zRROeI9bgNDYkURY..Y2gO8edBcwonPZI5bfn.TxBS2FELb94hyJu	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:32:34.40162	2025-06-25 05:32:34.401634	\N	\N
156	2@d.q	$2b$12$u/c9wrnvWYXv82REbL.gQOWJzLyqKBuysvkz6UwLR807jgwOMEuP.	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:33:15.319869	2025-06-25 05:33:15.319886	\N	\N
157	2@a.q	$2b$12$vbJ/hSwa0gM2UcBx033vFeanNbINkOoQQdFgjnqGeUM3wr1B1L6uy	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:33:47.488547	2025-06-25 05:33:47.488566	\N	\N
158	3@a.q	$2b$12$er0JyK3NC6oFSQSNJLqavucESgmLzmbyxs1nIL6Q04pnDOg6mdRcS	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:35:18.169492	2025-06-25 05:35:18.169507	\N	\N
159	e@a.q	$2b$12$DsfdTlst2S4xuZwuj/M/ZuPI6PrvqyZSj/2lR2X.BtxYzZcKTVZXS	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:36:44.996795	2025-06-25 05:36:44.99681	\N	\N
160	4@q.asdf	$2b$12$2ahPMVLiR/RQs1NZGgWBLOffH4JEVJRlx6nvgackfbn5fUjLPagEi	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:40:01.695653	2025-06-25 05:40:01.695667	\N	\N
161	w@q12.c	$2b$12$e2Uo8LOCJ76SJePP7u0oFOwVmqyf/5QgMSRuedCJormHgPXVZgFbW	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:40:01.934102	2025-06-25 05:40:01.934116	\N	\N
162	3@af.c	$2b$12$gaTeB9W0HfPI8bgmad74AOyyPBOOterhqlU.ONrOXftMV946/pJ/C	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:41:24.546209	2025-06-25 05:41:24.546223	\N	\N
163	a@ac.c	$2b$12$lNgvi8BDJ6pwxQZrFdMmtOybo9IJj7iPQPA1GMPvWvBfdoUPdglZ6	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:44:42.373516	2025-06-25 05:44:42.37353	\N	\N
164	4@qt.c	$2b$12$reFyJgyaEqy2mt96FljfyuzIbhTLMtWKTbnT3MeUAzs5ZGKGcObYy	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:47:05.556182	2025-06-25 05:47:05.556196	\N	\N
165	3@a.t	$2b$12$81.MXujMgw5ykoKNY5hYjONNeZO3bQMHvIbyO0iy6g76YI907KmBW	\N	\N	PAY_AS_YOU_GO	0	\N	2025-06-25 05:48:57.243085	2025-06-25 05:48:57.2431	\N	\N
166	w1flyggao@gmail.com		\N	102056815876308564975	PAY_AS_YOU_GO	0	\N	2025-06-25 06:24:30.486402	2025-06-25 06:24:30.486422	\N	\N
170	test_user_f923eb7b@example.com	$2b$12$ce8x1eLjj2oTci5g0vfpTehBVYfsaDuODz3N.FDUcXt9SgYXVdNfe	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-26 07:42:45.085552	2025-06-26 07:42:45.737891	\N	\N
167	test_user_99c9f682@example.com	$2b$12$KON44PFekfYz.wR4vAs70.ZXRi2kWoVDreuzsScGYzNsclgF.OJ0O	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-25 08:08:42.51867	2025-06-25 08:08:43.191728	\N	\N
179	test_user_b709ec88@example.com	$2b$12$CHN/4ByGtQlV/FB81.XVSekuYH.JYwFE7RCsE6ytIdgQG..9/x0Y6	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-27 08:43:17.174856	2025-06-27 08:43:17.906362	\N	\N
168	test_user_02d5a8ea@example.com	$2b$12$2NhWJ2jvxOdgZaJ1cT6RBevKrHLTtzUKFnJtviot9BdbCLKZVq8r.	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-26 07:19:57.921469	2025-06-26 07:19:58.695178	\N	\N
171	test_user_2c086ec0@example.com	$2b$12$1l0gpWMD1UQn0Fbqe0F2kOyXiPHuTsFIav5jL3mqCtg3kvXY1mbDO	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-26 08:14:39.109966	2025-06-26 08:14:40.010318	\N	\N
169	test_user_ad533036@example.com	$2b$12$wv/UYen1XwWFSynWgE//j.d11gQhlgmUQvxD6SLQ19I5oaMkMcfbe	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-26 07:23:56.505203	2025-06-26 07:23:57.231381	\N	\N
174	test_user_28f4ea59@example.com	$2b$12$fUdgsPx8UTwgMlBvMFDoMuS.cg1P1L3uoE6QZtBDCyrdXUTblvHHu	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-26 13:15:21.031143	2025-06-26 13:15:21.734771	\N	\N
172	test_user_3d5c2c89@example.com	$2b$12$w9HZ6QkuYaizB0SQxUY7UeKqubfGLdNUS6Q/3qZGmsL7jprc.80tG	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-26 12:48:37.222018	2025-06-26 12:48:37.97971	\N	\N
176	test_user_a38aa844@example.com	$2b$12$edvsBCZx0l1.XUQOBfF0bO9xcWvqaQSFBQVIZk1RVa.9cctMnGUH2	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-26 14:27:02.596289	2025-06-26 14:27:03.328881	\N	\N
178	test_user_3ab1877d@example.com	$2b$12$ESNQiq35RICEtGOzFXpbqevTArR7TuDp1XTC6/mU.0L3Y0gEGCE62	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-27 08:37:02.124959	2025-06-27 08:37:02.875682	\N	\N
175	test_user_1c1bb988@example.com	$2b$12$aBacY6AuB1POmT4aYjX4JeQpDLSSmAyRGpReR6eEEOTpyXqGaJ8sK	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-26 14:05:33.107669	2025-06-26 14:05:33.785779	\N	\N
177	test_user_bc0163e0@example.com	$2b$12$hKn2CyVOyJG5fqsgK.tXW.jMGZbOKSaewX.4dC1lmb53BkpivvTD2	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-26 14:33:18.278126	2025-06-26 14:33:19.079748	\N	\N
180	test_user_3194cb90@example.com	$2b$12$S67rW3aw3whBkSIx87PuYuqsF4a1dZusdH9eRy58yZ7u4U6cqQISu	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-27 09:00:31.794028	2025-06-27 09:00:32.496902	\N	\N
181	test_user_e20913dd@example.com	$2b$12$PTEwzZYWC6AvIdKZWxhvzebZV5XjQ06QkvRuSNq5.BPWZophO7y3u	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-27 09:05:52.106391	2025-06-27 09:05:52.839511	\N	\N
183	test_user_f67731c4@example.com	$2b$12$keiA.wtsbOJrMNMY4Rp0D.MDjqZhMcVKax7anXHy8IMEJJhN2COY.	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-30 04:32:23.964744	2025-06-30 04:32:24.663229	\N	\N
182	test_user_30f59d6a@example.com	$2b$12$YrCip3SfdK7xuakoNW7YNuHzf9sXW4vhprsd60bfSyxwqAJ02cD4m	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-30 03:35:22.885159	2025-06-30 03:35:23.559492	\N	\N
184	test_user_a01b888f@example.com	$2b$12$OjAURdMNBKwnBL9./gj8reD3L5MG2nwIEYVVwEnkMHhPy8oDbbTNa	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-30 06:50:01.040388	2025-06-30 06:50:01.774363	\N	\N
186	test_user_4319fdb3@example.com	$2b$12$gAaO0a81x0RLPNkI4hHEOel.H.3biFrFZ.0EjILK331BhyeYY.c3i	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-30 09:39:16.609407	2025-06-30 09:39:17.374954	\N	\N
185	test_user_e07aff37@example.com	$2b$12$Ux9rkjbM3M/nOrv5Uw4zW.3tCmkL6THO0W/it93J274IyBU6H6rRC	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-30 09:22:41.227942	2025-06-30 09:22:41.987879	\N	\N
187	test_user_4bfc329e@example.com	$2b$12$n7KuwfPr3KGwB8Qqsa/JFOLaj8/z7NRgNVJbM6tjukMzZyLsmLQnm	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-30 10:02:27.284831	2025-06-30 10:02:28.072275	\N	\N
188	test_user_4314b8b4@example.com	$2b$12$PfFYzV4YCdA4WAwUHXswM.WXoS5BHMkr1Ryugwnpp53FtoR2g2ZF.	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-30 10:09:28.400295	2025-06-30 10:09:29.098836	\N	\N
215	test_user_a4d821bc@example.com	$2b$12$2BQmFYfBv1ESr3or0zR.2.uYz46kRGiak6Hr.8nkfQVH71jO93Xwq	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 05:05:52.236324	2025-07-02 05:05:53.041652	\N	\N
210	test_user_c5565341@example.com	$2b$12$V3ipgKQFaN/OsWfI6LLF4e/O1nzw8iL8ozR1oQDX0wt/ztYHdk6KS	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 04:02:46.420836	2025-07-02 04:02:47.110017	\N	\N
189	test_user_9688e2b1@example.com	$2b$12$3wupc5MNAK8aCH1Db9ZEv.t0i0Hsr.tunX25q8ltpXqQ8qkwaBUsa	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-30 10:15:22.353189	2025-06-30 10:15:23.065324	\N	\N
201	test_user_9d2914c5@example.com	$2b$12$BvNoJKMAXbv2hIUQU25KFedDu0/rEtcaL0cGTiLKyFUfuaCAWfZkO	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-01 09:15:58.937145	2025-07-01 09:15:59.638593	\N	\N
190	test_user_7de6ec7d@example.com	$2b$12$I8RYxywdZw3B2/BTV10mTu85UnTFR8va58XC4jT3nHJvlrsYE4dRS	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-30 10:17:03.635968	2025-06-30 10:17:04.352884	\N	\N
191	test_user_dc4a3243@example.com	$2b$12$zXvEWXe5E7ha.8zlxYmKouIStcb1St6MBSgqhbvelzcPl8ukuZQV6	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-30 10:17:58.373061	2025-06-30 10:17:59.090603	\N	\N
202	test_user_10dc376d@example.com	$2b$12$FEjyFyzH/PwwY9N/9eJrEezi8nyJzBsIudwTi6xJA28lkA4uXs0gK	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-01 09:56:19.648935	2025-07-01 09:56:20.528324	\N	\N
203	w1w1w@q.c	$2b$12$RMHH2itWdHfFz1SJj5F/buI7.FlzCqbB4b3VKpEAtLvBoXGyih94G	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-02 02:36:51.42138	2025-07-02 02:36:51.421395	\N	\N
192	test_user_40e84e8d@example.com	$2b$12$CBJevpN5J9uTAVEC.RfLA.KaPE5UITWlKpSRLBfTMV29JGur8m4kO	\N	\N	PAY_AS_YOU_GO	188	\N	2025-06-30 10:25:33.387161	2025-06-30 10:25:34.163106	\N	\N
204	klein@curify.com	$2b$12$mfS7l8nBJvFyC7.gg6k8Y.ucr1lRECnSihdow6.kkA.AFXsEyieg2	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-02 02:37:19.951269	2025-07-02 02:37:19.951283	\N	\N
193	test_user_ccf592d5@example.com	$2b$12$7RsISXErlcd8V/6zrjGlsee/M2kPiC6Opr9ZL3S7ofjyx0pcLL6PO	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-01 01:26:02.303509	2025-07-01 01:26:03.068334	\N	\N
230	test_user_6e2514c9@example.com	$2b$12$evuHokaj5t9/JN4n2w5fh./I.W.5bWBbkrvgjCay.jxAU5xK2Pg/y	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-04 05:06:39.860948	2025-07-04 05:06:39.860962	\N	\N
211	test_user_c997c6bf@example.com	$2b$12$M7Nzcln6BhaczqMQePu2X.uLv62S05dDjxdkIKPHApkPAUHnbIPEq	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 04:12:59.561037	2025-07-02 04:13:00.346644	\N	\N
194	test_user_0819662c@example.com	$2b$12$OWs4K5g05ipO1Crkdom/benst2Q6PegQdbeNC9hSYfhdMcQKAaKIG	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-01 01:47:35.679074	2025-07-01 01:47:36.376404	\N	\N
195	test_user_93bf1d77@example.com	$2b$12$UZgSVGi8IZzh89AxOxdXtOxuBHzhvx74anNhPzRsZsZxPtMIJBVKS	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-01 02:59:39.620325	2025-07-01 02:59:39.620339	\N	\N
205	test_user_a0d6fdb8@example.com	$2b$12$KpvSVLHJR.Zozai1tE6UYeLHXGaW9M44w/.aHI/K51X4ZGQ2yR1UO	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 03:38:06.036991	2025-07-02 03:38:06.796871	\N	\N
196	test_user_cf828680@example.com	$2b$12$5kVD8zlsOWxlOH.F0e7Ude30mbYs2/XIFhigcak9SAR3gBx0LDmSW	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-01 03:18:18.537358	2025-07-01 03:18:19.264675	\N	\N
197	q2@qwe.c	$2b$12$9WGWbttn0mJjA8AWd7XIx.RuwUKlTEf0FWNe2BZkRTUCideTzrm52	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-01 04:35:30.82034	2025-07-01 04:35:30.820388	\N	\N
220	test_user_e558e22f@example.com	$2b$12$hnfP.o0lTPvuJ27kCtL5r.F1Hn6vBGGgPyWjSkhq1vIRprHBBfVwa	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 09:22:13.356749	2025-07-02 09:22:14.085333	\N	\N
198	test_user_f247783a@example.com	$2b$12$Z3rcFcgWQSWEam3h7EQ7.uVa1t0VEDag0httce6gipjcE/g9Nbk3S	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-01 07:00:30.072053	2025-07-01 07:00:30.831973	\N	\N
206	test_user_cffa698e@example.com	$2b$12$gYIj5LcwZhsI7xQB8NoYoeefe7dmJ1YGBLKf1md7c8KmtfogsPzx6	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 03:39:00.378358	2025-07-02 03:39:01.136409	\N	\N
199	test_user_8cbebe67@example.com	$2b$12$sbeXJs3rXilwrSlPuV6sNe2Dw.8UwqsD.yJhMGpd4PvLmN1Kj1eQq	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-01 07:21:42.192658	2025-07-01 07:21:42.915758	\N	\N
216	test_user_bfef7052@example.com	$2b$12$d8rUk407OGaiWWVDOKystegN9xmKyG7uFxT/jnPO.QizVwrBbzmDG	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 05:35:55.13728	2025-07-02 05:35:55.738757	\N	\N
212	test_user_77acb291@example.com	$2b$12$1KKgOLX5SA4jazVEUnpLU.Y8waHAyWj7.AMcU5T2XhzOTTZk.QZ7a	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 04:20:28.77636	2025-07-02 04:20:29.464543	\N	\N
200	test_user_083dc8d9@example.com	$2b$12$pd6h7OnPb624cTaqpUjXPunIHJpeC3k4awPiUveOyTc.mhgSegXYG	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-01 08:00:06.810687	2025-07-01 08:00:07.567142	\N	\N
207	test_user_8cfc23ef@example.com	$2b$12$/g6./Rg.nkLdG0oysTyQZ.VyEDaHf5ETS6mPOeL5MwlBZEQNieN2W	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 03:40:47.402636	2025-07-02 03:40:48.120055	\N	\N
208	test_user_65f20933@example.com	$2b$12$CKeRHxq/vvEZ5STpFwbGX.XE4IQO0Eqqfnlb92mF156MqOwrp/0LO	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 03:58:13.60748	2025-07-02 03:58:14.291291	\N	\N
213	test_user_774c1356@example.com	$2b$12$1Pdxjhat6m2N8l0RHIiRsekdaaaRa5UvPohCoMl534Alpv/8.We8q	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 04:24:04.82534	2025-07-02 04:24:05.551214	\N	\N
209	test_user_5b231c23@example.com	$2b$12$YrEywdzjN1h.wtFJuQYjyOkRkPmmkU6Ig.gxNGnMEmizWZMWTc4ya	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 04:00:35.112886	2025-07-02 04:00:35.849089	\N	\N
225	test_user_63a9bc65@example.com	$2b$12$hu2Is.pLRRi13YK7mbpLeuG/tajCRNfl3U6.RbOdhkI.2CnEjWlo2	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 10:32:11.802283	2025-07-02 10:32:12.635575	\N	\N
217	test_user_0123b356@example.com	$2b$12$E3ZI4xLGxZ1fpaLs8.nzjeFGglnQ/X5f8vk6GGK99PVhA3SFYNWwW	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 06:13:37.623211	2025-07-02 06:13:38.380095	\N	\N
218	test_user_ce75661b@example.com	$2b$12$9Xb8.GoFzzJPHbB967utQOhJMDZ69uEYQYuGrQKmymIR7a.CnRwKy	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-02 08:05:35.809498	2025-07-02 08:05:35.809512	\N	\N
214	test_user_79943744@example.com	$2b$12$veGxTgZaEc4KrHHtGAM3f.gGnH.imRuUORUU97pGQV7izUqzEmHxu	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 04:41:16.182766	2025-07-02 04:41:16.906745	\N	\N
223	test_user_230e727a@example.com	$2b$12$GnfkID1BOX5UW3DRqLQgWejENYT2Vj90Gsh6futA.Ovw5Qydtmk66	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 10:04:49.396954	2025-07-02 10:04:50.167879	\N	\N
221	test_user_40e0c177@example.com	$2b$12$k9BFsBo.ivaJPB0GUuoks.Ns60iQSaYOLRp7/rTDExY0K/LA6L3Vq	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 09:29:12.229818	2025-07-02 09:29:12.927243	\N	\N
219	test_user_a56c23da@example.com	$2b$12$O0.nmywOyJLScY6hsB0Uc.9Z2uUl1pGBHTHO5xCMieCH7u8ctgczW	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 08:14:18.112658	2025-07-02 08:14:18.885113	\N	\N
226	test_user_896d6e58@example.com	$2b$12$CL66sugepnvcEqP4lzatpuxH4vOPFJso9NqqrCJ8Q7kd.C.ehncWq	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-04 04:26:26.099874	2025-07-04 04:26:26.099889	\N	\N
227	test_user_0b98b645@example.com	$2b$12$XSZcIPMUqPzelINTds8RCu2ypQGJI03Jd5g5hv5gqaUqcQOBuAa7a	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-04 04:36:10.563415	2025-07-04 04:36:10.563428	\N	\N
222	test_user_fe883b8c@example.com	$2b$12$bt8Vw1L5PLr5makhKniS/umlvgUkuRMIdXUqfCfU8OAJe9GYDdySW	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 09:48:51.543222	2025-07-02 09:48:52.252979	\N	\N
224	test_user_a2222164@example.com	$2b$12$3vyXnv0F3iG6bXednJsLMuBe4aCaERy1SkFJmPYWCaUOf5oOMQ3AK	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-02 10:24:29.058444	2025-07-02 10:24:29.772531	\N	\N
231	test_user_871a2a96@example.com	$2b$12$VeyLPVjX3d2LeuYBgDbZUuGfZHmUK6hG1GOv7FTEYbMPI62CdNUO.	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-04 05:07:41.799955	2025-07-04 05:07:41.799969	\N	\N
228	test_user_4f8032c2@example.com	$2b$12$0MfR4ZBmiM2KdWR.PrA8K.YOuqIcKPZZFIzl3suJjpwsNLBhwOYu2	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-04 04:53:11.369988	2025-07-04 04:53:11.370001	\N	\N
229	test_user_7c6faa0c@example.com	$2b$12$CbBd3941tDj7YLlAOgHp9.ZjI8z37hpp1rDcN3TIl54rKj7lfDVHG	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-04 05:00:57.812186	2025-07-04 05:00:57.812199	\N	\N
232	test_user_032e1be6@example.com	$2b$12$Aex3WZF0WvwPiR/qx0xkHe636S0XBM/Oo8p71e2DYNg6Jhel8Ug0.	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-04 05:10:02.809658	2025-07-04 05:10:02.809674	\N	\N
233	test_user_73b1aaa5@example.com	$2b$12$O6lmATSLTg.xcNZEwnYWiuOVuO0wgO7j0l18hDsA6WAhPJP47nB5y	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-08 07:30:19.639491	2025-07-08 07:30:19.639505	\N	\N
234	test_user_365b7689@example.com	$2b$12$GwSaMct/t3vgIE/rPKc5OeS.0XqSDDJTTspV36RF3qBElCj3FzLVC	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-08 07:50:59.15676	2025-07-08 07:50:59.934687	\N	\N
235	test_user_eb0b82f9@example.com	$2b$12$cruv1IYdLt73Vsh1GucPwe9Abh4V..xxo1WYRI.4CqmvyA.T1AMB2	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-08 09:13:59.372733	2025-07-08 09:13:59.372747	\N	\N
236	test_user_3747ee7a@example.com	$2b$12$avVvXxNd4cKvoHYZy2eMcOz7ftj4xHXq7q9mkjMPK3J4MYyz.4Ig6	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-08 09:16:20.935355	2025-07-08 09:16:20.935368	\N	\N
237	test_user_9cf1708e@example.com	$2b$12$WzvYYMKI630hwy4/autsbuLyX/oxyonb1QDovKKFgyIy.txg4QDHm	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-08 09:37:50.109787	2025-07-08 09:37:50.109801	\N	\N
238	test_user_a128528f@example.com	$2b$12$PYHAmi2IPBTk55SbhVf.o.9rUJeKqf3n2YPkgSiPP5I7EEa44DfcS	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-08 09:45:54.253056	2025-07-08 09:45:54.25307	\N	\N
239	test_user_dbf0213b@example.com	$2b$12$j7rfXCxB/JagchIXa8TBQO2ywTHDCDqvTwq7i8YsFJeH4sIJJH3lK	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-08 09:53:31.129459	2025-07-08 09:53:32.023651	\N	\N
240	test_user_e8cf5a37@example.com	$2b$12$aZzMvXg5fNAf7vKNuBZzsOVOIkO6Rlat17wT.HoqBUgJ/GmI035DW	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-08 09:58:45.220583	2025-07-08 09:58:45.902929	\N	\N
241	e1@f.a	$2b$12$/u1xNtesoUZHfh.Vk/k9kOHDFQz7EN7O4UoyZsW2g8kMYtnB7jm3e	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-08 11:19:37.799043	2025-07-08 11:19:37.799057	\N	\N
242	qqwjq9916@gmail.com		\N	112800906571216195527	PAY_AS_YOU_GO	0	\N	2025-07-09 02:13:55.108459	2025-07-09 02:13:55.108482	\N	\N
243	123@1.c	$2b$12$0esE4fQux6X.cZl0p1CSsek60cIT4GGYShVJf5QS.UDGGetQaGBPi	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-09 06:10:58.613193	2025-07-09 06:10:58.613208	\N	\N
244	w1@d.c	$2b$12$ZRBhZD/rYIdMNM8uAJVPeOrJp4QgNzkfmlZZzxv9Xj3QStNt6fa7u	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-09 06:32:04.194942	2025-07-09 06:32:04.194955	\N	\N
245	1@q.x	$2b$12$OAExScIrENypC8Fbs/jq4.O6D/Y7PXXjlTB2gUbEbhwXEE3Rpe.XG	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-09 06:40:34.699066	2025-07-09 06:40:34.699079	\N	\N
247	w1flyggao@gmail.com	$2b$12$6bkg0OM6BFWsE/7iMhDMeu.a1gVE9reHB6zHQn6Q2H4m2NFMfH6ji	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-10 00:32:08.659799	2025-07-10 00:32:08.659811	\N	\N
248	w1flyggo@gmail.com	$2b$12$CwlI1vfJOplB62LeTmymwuzdNeuwnOGJTpx9RARI1t9cR73kcYcWS	\N	\N	PAY_AS_YOU_GO	0	\N	2025-07-10 00:33:08.278737	2025-07-10 00:33:08.278749	\N	\N
249	test_user_415f54ab@example.com	$2b$12$3OPjY5YzajZeL1zidw3nve87EzElmlMWGFjh9XwcAlhcHsS8UQfq.	\N	\N	PAY_AS_YOU_GO	188	\N	2025-07-11 10:56:55.239347	2025-07-11 10:56:56.417174	\N	\N
\.


--
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: curify
--

COPY public.video (video_id, user_id, original_filename, stored_filename, original_language, video_duration_seconds, completed_at, created_at, updated_at, is_youtube_upload, local_storage_path, blob_storage_url, thumbnail_blob_path, project_id, blob_url, width, height, display_aspect_ratio, aspect_ratio_numeric, frame_rate, video_codec, original_source_url, video_status) FROM stdin;
68_1d63d6d4	68	test_video.mp4	68_1d63d6d4.mp4	\N	\N	\N	2025-06-18 15:28:51.060407	2025-06-18 15:28:51.060426	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/68/68_1d63d6d4/68_1d63d6d4_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/68/68_1d63d6d4.mp4/68_1d63d6d4.mp4	\N	\N	\N	\N	\N	\N	\N	Active
69_776ea5e8	69	test_video.mp4	69_776ea5e8.mp4	\N	\N	\N	2025-06-18 15:30:10.051206	2025-06-18 15:30:10.051242	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/69/69_776ea5e8/69_776ea5e8_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/69/69_776ea5e8.mp4/69_776ea5e8.mp4	\N	\N	\N	\N	\N	\N	\N	Active
70_bf0a2b41	70	test_video.mp4	70_bf0a2b41.mp4	\N	\N	\N	2025-06-18 15:36:08.516402	2025-06-18 15:36:08.516425	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/70/70_bf0a2b41/70_bf0a2b41_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/70/70_bf0a2b41.mp4/70_bf0a2b41.mp4	\N	\N	\N	\N	\N	\N	\N	Active
71_bde9f8f9	71	test_video.mp4	71_bde9f8f9.mp4	\N	\N	\N	2025-06-18 15:38:46.083463	2025-06-18 15:38:46.083483	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/71/71_bde9f8f9/71_bde9f8f9_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/71/71_bde9f8f9.mp4/71_bde9f8f9.mp4	\N	\N	\N	\N	\N	\N	\N	Active
73_97db6bb5	73	test_video.mp4	73_97db6bb5.mp4	\N	\N	\N	2025-06-18 16:03:49.328792	2025-06-18 16:03:49.328828	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/73/73_97db6bb5/73_97db6bb5_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/73/73_97db6bb5.mp4/73_97db6bb5.mp4	\N	\N	\N	\N	\N	\N	\N	Active
74_07508506	74	test_video.mp4	74_07508506.mp4	\N	\N	\N	2025-06-19 00:23:04.380713	2025-06-19 00:23:04.380732	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/74/74_07508506/74_07508506_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/74/74_07508506.mp4/74_07508506.mp4	\N	\N	\N	\N	\N	\N	\N	Active
75_5829e289	75	test_video.mp4	75_5829e289.mp4	\N	\N	\N	2025-06-19 00:36:54.334727	2025-06-19 00:36:54.334777	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/75/75_5829e289/75_5829e289_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/75/75_5829e289/75_5829e289.mp4	\N	\N	\N	\N	\N	\N	\N	Active
76_097ab2f6	76	test_video.mp4	76_097ab2f6.mp4	\N	\N	\N	2025-06-19 01:18:01.297101	2025-06-19 01:18:01.297117	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/76/76_097ab2f6/76_097ab2f6_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/76/76_097ab2f6/76_097ab2f6.mp4	\N	\N	\N	\N	\N	\N	\N	Active
77_4010ce97	77	test_video.mp4	77_4010ce97.mp4	\N	\N	\N	2025-06-19 01:30:18.14801	2025-06-19 01:30:18.148033	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/77/77_4010ce97/77_4010ce97_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/77/77_4010ce97/77_4010ce97.mp4	\N	\N	\N	\N	\N	\N	\N	Active
78_4e37fc2f	78	test_video.mp4	78_4e37fc2f.mp4	\N	\N	\N	2025-06-19 01:46:25.678737	2025-06-19 01:46:25.678763	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/78/78_4e37fc2f/78_4e37fc2f_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/78/78_4e37fc2f/78_4e37fc2f.mp4	\N	\N	\N	\N	\N	\N	\N	Active
79_0fa34cba	79	test_video.mp4	79_0fa34cba.mp4	\N	\N	\N	2025-06-19 03:04:06.981733	2025-06-19 03:04:06.981751	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/79/79_0fa34cba/79_0fa34cba_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/79/79_0fa34cba/79_0fa34cba.mp4	\N	\N	\N	\N	\N	\N	\N	Active
80_683ec245	80	test_video.mp4	80_683ec245.mp4	\N	\N	\N	2025-06-19 04:06:44.285485	2025-06-19 04:06:44.285521	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/80/80_683ec245/80_683ec245_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/80/80_683ec245/80_683ec245.mp4	\N	\N	\N	\N	\N	\N	\N	Active
81_3dba7eaa	81	test_video.mp4	81_3dba7eaa.mp4	\N	\N	\N	2025-06-19 04:17:04.546003	2025-06-19 04:17:04.546025	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/81/81_3dba7eaa/81_3dba7eaa_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/81/81_3dba7eaa/81_3dba7eaa.mp4	\N	\N	\N	\N	\N	\N	\N	Active
82_c0772ec8	82	test_video.mp4	82_c0772ec8.mp4	\N	\N	\N	2025-06-19 04:26:06.471345	2025-06-19 04:26:06.471368	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/82/82_c0772ec8/82_c0772ec8_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/82/82_c0772ec8/82_c0772ec8.mp4	\N	\N	\N	\N	\N	\N	\N	Active
83_e82a5539	83	test_video.mp4	83_e82a5539.mp4	\N	\N	\N	2025-06-19 05:02:23.436101	2025-06-19 05:02:23.436123	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/83/83_e82a5539/83_e82a5539_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/83/83_e82a5539/83_e82a5539.mp4	\N	\N	\N	\N	\N	\N	\N	Active
86_aa233465	86	test_video.mp4	86_aa233465.mp4	\N	\N	\N	2025-06-19 06:20:20.325709	2025-06-19 06:20:20.325752	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/86/86_aa233465/86_aa233465_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/86/86_aa233465/86_aa233465.mp4	\N	\N	\N	\N	\N	\N	\N	Active
87_c1b873d0	87	test_video.mp4	87_c1b873d0.mp4	\N	\N	\N	2025-06-19 07:54:26.684258	2025-06-19 07:54:26.684273	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/87/87_c1b873d0/87_c1b873d0_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/87/87_c1b873d0/87_c1b873d0.mp4	\N	\N	\N	\N	\N	\N	\N	Active
88_f4251d55	88	test_video.mp4	88_f4251d55.mp4	\N	\N	\N	2025-06-20 11:33:10.048437	2025-06-20 11:33:10.048464	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/88/88_f4251d55/88_f4251d55_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/88/88_f4251d55/88_f4251d55.mp4	\N	\N	\N	\N	\N	\N	\N	Active
89_9591c181	89	test_video.mp4	89_9591c181.mp4	\N	\N	\N	2025-06-21 09:12:06.354042	2025-06-21 09:12:06.354067	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/89/89_9591c181/89_9591c181_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/89/89_9591c181/89_9591c181.mp4	\N	\N	\N	\N	\N	\N	\N	Active
90_ec3fe33c	90	test_video.mp4	90_ec3fe33c.mp4	\N	\N	\N	2025-06-21 09:31:32.285414	2025-06-21 09:31:32.28543	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/90/90_ec3fe33c/90_ec3fe33c_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/90/90_ec3fe33c/90_ec3fe33c.mp4	\N	\N	\N	\N	\N	\N	\N	Active
91_eb46d0af	91	test_video.mp4	91_eb46d0af.mp4	\N	\N	\N	2025-06-21 09:37:25.186027	2025-06-21 09:37:25.186046	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/91/91_eb46d0af/91_eb46d0af_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/91/91_eb46d0af/91_eb46d0af.mp4	\N	\N	\N	\N	\N	\N	\N	Active
92_d2990fe6	92	test_video.mp4	92_d2990fe6.mp4	\N	\N	\N	2025-06-21 09:44:45.095668	2025-06-21 09:44:45.095698	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/92/92_d2990fe6/92_d2990fe6_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/92/92_d2990fe6/92_d2990fe6.mp4	\N	\N	\N	\N	\N	\N	\N	Active
93_ac8ef27e	93	test_video.mp4	93_ac8ef27e.mp4	\N	\N	\N	2025-06-21 09:51:27.48717	2025-06-21 09:51:27.487191	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/93/93_ac8ef27e/93_ac8ef27e_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/93/93_ac8ef27e/93_ac8ef27e.mp4	\N	\N	\N	\N	\N	\N	\N	Active
94_6ba89cc6	94	test_video.mp4	94_6ba89cc6.mp4	\N	\N	\N	2025-06-21 10:01:24.330768	2025-06-21 10:01:24.330807	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/94/94_6ba89cc6/94_6ba89cc6_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/94/94_6ba89cc6/94_6ba89cc6.mp4	\N	\N	\N	\N	\N	\N	\N	Active
95_34fab093	95	test_video.mp4	95_34fab093.mp4	\N	\N	\N	2025-06-21 10:34:47.371426	2025-06-21 10:34:47.371444	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/95/95_34fab093/95_34fab093_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/95/95_34fab093/95_34fab093.mp4	\N	\N	\N	\N	\N	\N	\N	Active
96_4192389e	96	test_video.mp4	96_4192389e.mp4	\N	\N	\N	2025-06-21 10:46:39.512746	2025-06-21 10:46:39.512776	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/96/96_4192389e/96_4192389e_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/96/96_4192389e/96_4192389e.mp4	\N	\N	\N	\N	\N	\N	\N	Active
97_0aa27b5d	97	test_video.mp4	97_0aa27b5d.mp4	\N	\N	\N	2025-06-21 11:10:48.382811	2025-06-21 11:10:48.382827	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/97/97_0aa27b5d/97_0aa27b5d_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/97/97_0aa27b5d/97_0aa27b5d.mp4	\N	\N	\N	\N	\N	\N	\N	Active
98_be0a9341	98	test_video.mp4	98_be0a9341.mp4	\N	\N	\N	2025-06-21 11:16:03.946784	2025-06-21 11:16:03.946801	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/98/98_be0a9341/98_be0a9341_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/98/98_be0a9341/98_be0a9341.mp4	\N	\N	\N	\N	\N	\N	\N	Active
99_69ce7d0e	99	test_video.mp4	99_69ce7d0e.mp4	\N	\N	\N	2025-06-21 11:19:20.353488	2025-06-21 11:19:20.353507	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/99/99_69ce7d0e/99_69ce7d0e_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/99/99_69ce7d0e/99_69ce7d0e.mp4	\N	\N	\N	\N	\N	\N	\N	Active
100_2926b74e	100	test_video.mp4	100_2926b74e.mp4	\N	\N	\N	2025-06-21 11:22:26.279412	2025-06-21 11:22:26.27943	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/100/100_2926b74e/100_2926b74e_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/100/100_2926b74e/100_2926b74e.mp4	\N	\N	\N	\N	\N	\N	\N	Active
101_f8a12cf1	101	test_video.mp4	101_f8a12cf1.mp4	\N	\N	\N	2025-06-21 11:33:39.171564	2025-06-21 11:33:39.171581	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/101/101_f8a12cf1/101_f8a12cf1_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/101/101_f8a12cf1/101_f8a12cf1.mp4	\N	\N	\N	\N	\N	\N	\N	Active
102_2a2de07e	102	test_video.mp4	102_2a2de07e.mp4	\N	\N	\N	2025-06-21 11:44:39.062715	2025-06-21 11:44:39.062736	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/102/102_2a2de07e/102_2a2de07e_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/102/102_2a2de07e/102_2a2de07e.mp4	\N	\N	\N	\N	\N	\N	\N	Active
103_ed2069d1	103	test_video.mp4	103_ed2069d1.mp4	\N	\N	\N	2025-06-21 11:53:55.872135	2025-06-21 11:53:55.872158	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/103/103_ed2069d1/103_ed2069d1_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/103/103_ed2069d1/103_ed2069d1.mp4	\N	\N	\N	\N	\N	\N	\N	Active
104_7cd6f15b	104	test_video.mp4	104_7cd6f15b.mp4	\N	\N	\N	2025-06-21 11:56:07.553975	2025-06-21 11:56:07.553994	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/104/104_7cd6f15b/104_7cd6f15b_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/104/104_7cd6f15b/104_7cd6f15b.mp4	\N	\N	\N	\N	\N	\N	\N	Active
105_7085656b	105	test_video.mp4	105_7085656b.mp4	\N	\N	\N	2025-06-21 12:03:24.373891	2025-06-21 12:03:24.373944	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/105/105_7085656b/105_7085656b_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/105/105_7085656b/105_7085656b.mp4	\N	\N	\N	\N	\N	\N	\N	Active
106_829c1404	106	test_video.mp4	106_829c1404.mp4	\N	\N	\N	2025-06-21 12:18:12.559861	2025-06-21 12:18:12.55988	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/106/106_829c1404/106_829c1404_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/106/106_829c1404/106_829c1404.mp4	\N	\N	\N	\N	\N	\N	\N	Active
107_5657f936	107	test_video.mp4	107_5657f936.mp4	\N	\N	\N	2025-06-21 12:27:11.076343	2025-06-21 12:27:11.076374	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/107/107_5657f936/107_5657f936_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/107/107_5657f936/107_5657f936.mp4	\N	\N	\N	\N	\N	\N	\N	Active
108_b70b407d	108	test_video.mp4	108_b70b407d.mp4	\N	\N	\N	2025-06-22 11:12:54.312244	2025-06-22 11:12:54.312265	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/108/108_b70b407d/108_b70b407d_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/108/108_b70b407d/108_b70b407d.mp4	\N	\N	\N	\N	\N	\N	\N	Active
109_d8908252	109	test_video.mp4	109_d8908252.mp4	\N	\N	\N	2025-06-22 11:34:18.814288	2025-06-22 11:34:18.814305	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/109/109_d8908252/109_d8908252_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/109/109_d8908252/109_d8908252.mp4	\N	\N	\N	\N	\N	\N	\N	Active
110_25043c17	110	test_video.mp4	110_25043c17.mp4	\N	\N	\N	2025-06-22 11:43:19.694957	2025-06-22 11:43:19.694977	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/110/110_25043c17/110_25043c17_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/110/110_25043c17/110_25043c17.mp4	\N	\N	\N	\N	\N	\N	\N	Active
111_b04b04a2	111	test_video.mp4	111_b04b04a2.mp4	\N	\N	\N	2025-06-22 11:52:09.993974	2025-06-22 11:52:09.993995	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/111/111_b04b04a2/111_b04b04a2_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/111/111_b04b04a2/111_b04b04a2.mp4	\N	\N	\N	\N	\N	\N	\N	Active
112_d6205c32	112	test_video.mp4	112_d6205c32.mp4	\N	\N	\N	2025-06-22 12:02:42.785368	2025-06-22 12:02:42.785386	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/112/112_d6205c32/112_d6205c32_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/112/112_d6205c32/112_d6205c32.mp4	\N	\N	\N	\N	\N	\N	\N	Active
113_25d7e4db	113	test_video.mp4	113_25d7e4db.mp4	\N	\N	\N	2025-06-22 13:48:14.167439	2025-06-22 13:48:14.167454	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/113/113_25d7e4db/113_25d7e4db_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/113/113_25d7e4db/113_25d7e4db.mp4	\N	\N	\N	\N	\N	\N	\N	Active
114_6321e91e	114	test_video.mp4	114_6321e91e.mp4	\N	\N	\N	2025-06-22 14:30:18.696672	2025-06-22 14:30:18.696696	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/114/114_6321e91e/114_6321e91e_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/114/114_6321e91e/114_6321e91e.mp4	\N	\N	\N	\N	\N	\N	\N	Active
115_190acb2c	115	test_video.mp4	115_190acb2c.mp4	\N	\N	\N	2025-06-22 14:33:25.321252	2025-06-22 14:33:25.321351	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/115/115_190acb2c/115_190acb2c_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/115/115_190acb2c/115_190acb2c.mp4	\N	\N	\N	\N	\N	\N	\N	Active
116_355ce257	116	test_video.mp4	116_355ce257.mp4	\N	\N	\N	2025-06-22 14:48:01.370841	2025-06-22 14:48:01.370858	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/116/116_355ce257/116_355ce257_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/116/116_355ce257/116_355ce257.mp4	\N	\N	\N	\N	\N	\N	\N	Active
117_68d05114	117	test_video.mp4	117_68d05114.mp4	\N	\N	\N	2025-06-22 14:58:22.658782	2025-06-22 14:58:22.658836	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/117/117_68d05114/117_68d05114_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/117/117_68d05114/117_68d05114.mp4	\N	\N	\N	\N	\N	\N	\N	Active
118_0273d2b7	118	test_video.mp4	118_0273d2b7.mp4	\N	\N	\N	2025-06-22 15:06:58.079674	2025-06-22 15:06:58.079712	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/118/118_0273d2b7/118_0273d2b7_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/118/118_0273d2b7/118_0273d2b7.mp4	\N	\N	\N	\N	\N	\N	\N	Active
119_eae00ff0	119	test_video.mp4	119_eae00ff0.mp4	\N	\N	\N	2025-06-22 15:09:55.358538	2025-06-22 15:09:55.358566	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/119/119_eae00ff0/119_eae00ff0_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/119/119_eae00ff0/119_eae00ff0.mp4	\N	\N	\N	\N	\N	\N	\N	Active
120_e1d75c5b	120	test_video.mp4	120_e1d75c5b.mp4	\N	\N	\N	2025-06-22 15:28:46.969251	2025-06-22 15:28:46.969269	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/120/120_e1d75c5b/120_e1d75c5b_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/120/120_e1d75c5b/120_e1d75c5b.mp4	\N	\N	\N	\N	\N	\N	\N	Active
121_2d7e1583	121	test_video.mp4	121_2d7e1583.mp4	\N	\N	\N	2025-06-22 15:34:08.150231	2025-06-22 15:34:08.150249	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/121/121_2d7e1583/121_2d7e1583_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/121/121_2d7e1583/121_2d7e1583.mp4	\N	\N	\N	\N	\N	\N	\N	Active
122_c1d22b22	122	test_video.mp4	122_c1d22b22.mp4	\N	\N	\N	2025-06-22 15:45:09.764613	2025-06-22 15:45:09.764634	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/122/122_c1d22b22/122_c1d22b22_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/122/122_c1d22b22/122_c1d22b22.mp4	\N	\N	\N	\N	\N	\N	\N	Active
123_847375a5	123	test_video.mp4	123_847375a5.mp4	\N	\N	\N	2025-06-22 15:55:12.122822	2025-06-22 15:55:12.122848	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/123/123_847375a5/123_847375a5_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/123/123_847375a5/123_847375a5.mp4	\N	\N	\N	\N	\N	\N	\N	Active
124_5cf8e425	124	test_video.mp4	124_5cf8e425.mp4	\N	\N	\N	2025-06-22 16:01:46.868992	2025-06-22 16:01:46.869016	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/124/124_5cf8e425/124_5cf8e425_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/124/124_5cf8e425/124_5cf8e425.mp4	\N	\N	\N	\N	\N	\N	\N	Active
125_bfe44d53	125	test_video.mp4	125_bfe44d53.mp4	\N	\N	\N	2025-06-22 16:21:39.196544	2025-06-22 16:21:39.196566	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/125/125_bfe44d53/125_bfe44d53_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/125/125_bfe44d53/125_bfe44d53.mp4	\N	\N	\N	\N	\N	\N	\N	Active
126_45d422a0	126	test_video.mp4	126_45d422a0.mp4	\N	\N	\N	2025-06-22 16:26:33.123113	2025-06-22 16:26:33.123132	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/126/126_45d422a0/126_45d422a0_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/126/126_45d422a0/126_45d422a0.mp4	\N	\N	\N	\N	\N	\N	\N	Active
127_15829f35	127	test_video.mp4	127_15829f35.mp4	\N	\N	\N	2025-06-22 16:42:32.66123	2025-06-22 16:42:32.66125	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/127/127_15829f35/127_15829f35_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/127/127_15829f35/127_15829f35.mp4	\N	\N	\N	\N	\N	\N	\N	Active
128_460efb81	128	test_video.mp4	128_460efb81.mp4	\N	\N	\N	2025-06-22 16:50:56.675319	2025-06-22 16:50:56.675339	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/128/128_460efb81/128_460efb81_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/128/128_460efb81/128_460efb81.mp4	\N	\N	\N	\N	\N	\N	\N	Active
129_ffdcb0d5	129	test_video.mp4	129_ffdcb0d5.mp4	\N	\N	\N	2025-06-22 17:15:21.800644	2025-06-22 17:15:21.800663	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/129/129_ffdcb0d5/129_ffdcb0d5_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/129/129_ffdcb0d5/129_ffdcb0d5.mp4	\N	\N	\N	\N	\N	\N	\N	Active
130_52f15816	130	test_video.mp4	130_52f15816.mp4	\N	\N	\N	2025-06-22 17:20:51.992818	2025-06-22 17:20:51.99284	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/130/130_52f15816/130_52f15816_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/130/130_52f15816/130_52f15816.mp4	\N	\N	\N	\N	\N	\N	\N	Active
131_95378eba	131	test_video.mp4	131_95378eba.mp4	\N	\N	\N	2025-06-22 17:23:26.354605	2025-06-22 17:23:26.354624	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/131/131_95378eba/131_95378eba_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/131/131_95378eba/131_95378eba.mp4	\N	\N	\N	\N	\N	\N	\N	Active
132_b3f45a8d	132	test_video.mp4	132_b3f45a8d.mp4	\N	\N	\N	2025-06-22 17:28:27.601294	2025-06-22 17:28:27.601311	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/132/132_b3f45a8d/132_b3f45a8d_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/132/132_b3f45a8d/132_b3f45a8d.mp4	\N	\N	\N	\N	\N	\N	\N	Active
133_71181108	133	test_video.mp4	133_71181108.mp4	\N	\N	\N	2025-06-22 17:34:56.457674	2025-06-22 17:34:56.457695	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/133/133_71181108/133_71181108_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/133/133_71181108/133_71181108.mp4	\N	\N	\N	\N	\N	\N	\N	Active
147_1d667e50	147	test_video.mp4	147_1d667e50.mp4	\N	\N	\N	2025-06-25 04:57:16.298874	2025-06-25 04:57:16.298891	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/147/147_1d667e50/147_1d667e50_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/147/147_1d667e50/147_1d667e50.mp4	\N	\N	\N	\N	\N	\N	\N	Active
223_d1845383	223	test_video.mp4	223_d1845383.mp4	\N	9.466667	\N	2025-07-02 10:04:51.266992	2025-07-02 10:04:51.266993	f	\N	\N	videos/223/223_d1845383/223_d1845383_thumbnail.jpg	\N	videos/223/223_d1845383/223_d1845383.mp4	852	480	71:40	1.775	30	h264	\N	Active
181_2e79af24	181	test_video.mp4	181_2e79af24.mp4	\N	\N	\N	2025-06-27 09:05:53.406349	2025-06-27 09:05:53.406361	f	\N	\N	videos/181/181_2e79af24/181_2e79af24_thumbnail.jpg	\N	videos/181/181_2e79af24/181_2e79af24.mp4	\N	\N	\N	\N	\N	\N	\N	Active
172_be083c95	172	test_video.mp4	172_be083c95.mp4	\N	\N	\N	2025-06-26 12:48:39.017689	2025-06-26 12:48:39.017702	f	\N	\N	videos/172/172_be083c95/172_be083c95_thumbnail.jpg	\N	videos/172/172_be083c95/172_be083c95.mp4	\N	\N	\N	\N	\N	\N	\N	Active
242_ec31e69d	242	test_video.mp4	242_ec31e69d.mp4	\N	9.466667	\N	2025-07-10 05:42:42.180536	2025-07-10 05:42:42.180537	f	\N	\N	videos/242/242_ec31e69d/242_ec31e69d_thumbnail.jpg	\N	videos/242/242_ec31e69d/242_ec31e69d.mp4	852	480	71:40	1.775	30	h264	\N	Active
219_510641f4	219	test_video.mp4	219_510641f4.mp4	\N	9.466667	\N	2025-07-02 08:14:19.926375	2025-07-02 08:14:19.926376	f	\N	\N	videos/219/219_510641f4/219_510641f4_thumbnail.jpg	\N	videos/219/219_510641f4/219_510641f4.mp4	852	480	71:40	1.775	30	h264	\N	Active
224_319993e2	224	test_video.mp4	224_319993e2.mp4	\N	9.466667	\N	2025-07-02 10:24:30.823626	2025-07-02 10:24:30.823627	f	\N	\N	videos/224/224_319993e2/224_319993e2_thumbnail.jpg	\N	videos/224/224_319993e2/224_319993e2.mp4	852	480	71:40	1.775	30	h264	\N	Active
204_719e2c09	204	TrumpTarrifs_cn_edited.mp4	204_719e2c09.mp4	\N	20.8	\N	2025-07-07 11:33:21.706218	2025-07-07 11:33:21.706219	f	\N	\N	videos/204/204_719e2c09/204_719e2c09_thumbnail.jpg	\N	videos/204/204_719e2c09/204_719e2c09.mp4	720	1280	9:16	0.5625	30	h264	\N	Active
182_deb7d2d4	182	test_video.mp4	182_deb7d2d4.mp4	\N	\N	\N	2025-06-30 03:35:24.788399	2025-06-30 03:35:24.7884	f	\N	\N	videos/182/182_deb7d2d4/182_deb7d2d4_thumbnail.jpg	\N	videos/182/182_deb7d2d4/182_deb7d2d4.mp4	\N	\N	\N	\N	\N	\N	\N	Active
167_15fd9fee	167	test_video.mp4	167_15fd9fee.mp4	\N	\N	\N	2025-06-25 08:08:44.21687	2025-06-25 08:08:44.216882	f	\N	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/167/167_15fd9fee/167_15fd9fee_thumbnail.jpg	\N	https://videotranslatetest.blob.core.windows.net/processed-videos/videos/167/167_15fd9fee/167_15fd9fee.mp4	\N	\N	\N	\N	\N	\N	\N	Active
166_494f6563	166	Lark20250626-224118.mp4	166_494f6563.mp4	\N	9.466667	\N	2025-07-11 03:29:50.569526	2025-07-11 03:29:50.569527	f	\N	\N	videos/166/166_494f6563/166_494f6563_thumbnail.jpg	\N	videos/166/166_494f6563/166_494f6563.mp4	852	480	71:40	1.775	30	h264	\N	Active
166_cd355c94	166	TrumpTarrifs_cn_edited.mp4	166_cd355c94.mp4	\N	20.8	\N	2025-07-11 03:58:19.107144	2025-07-11 03:58:19.107145	f	\N	\N	videos/166/166_cd355c94/166_cd355c94_thumbnail.jpg	\N	videos/166/166_cd355c94/166_cd355c94.mp4	720	1280	9:16	0.5625	30	h264	\N	Active
166_27770ae9	166	Lark20250626-224118.mp4	166_27770ae9.mp4	\N	9.466667	\N	2025-07-11 07:09:13.716924	2025-07-11 07:09:13.716926	f	\N	\N	videos/166/166_27770ae9/166_27770ae9_thumbnail.jpg	\N	videos/166/166_27770ae9/166_27770ae9.mp4	852	480	71:40	1.775	30	h264	\N	Active
185_c512f2ae	185	test_video.mp4	185_c512f2ae.mp4	\N	\N	\N	2025-06-30 09:22:43.301312	2025-06-30 09:22:43.301313	f	\N	\N	videos/185/185_c512f2ae/185_c512f2ae_thumbnail.jpg	\N	videos/185/185_c512f2ae/185_c512f2ae.mp4	\N	\N	\N	\N	\N	\N	\N	Active
191_b3fe8e4d	191	test_video.mp4	191_b3fe8e4d.mp4	\N	9.466667	\N	2025-06-30 10:17:59.778837	2025-06-30 10:17:59.778838	f	\N	\N	videos/191/191_b3fe8e4d/191_b3fe8e4d_thumbnail.jpg	\N	videos/191/191_b3fe8e4d/191_b3fe8e4d.mp4	852	480	71:40	1.775	30	h264	\N	Active
201_405e376c	201	test_video.mp4	201_405e376c.mp4	\N	57.766667	\N	2025-07-01 09:16:04.253901	2025-07-01 09:16:04.253901	f	\N	\N	videos/201/201_405e376c/201_405e376c_thumbnail.jpg	\N	videos/201/201_405e376c/201_405e376c.mp4	2160	3840	\N	\N	60	av1	\N	Active
207_66724aa8	207	test_video.mp4	207_66724aa8.mp4	\N	9.466667	\N	2025-07-02 03:40:48.928632	2025-07-02 03:40:48.928633	f	\N	\N	videos/207/207_66724aa8/207_66724aa8_thumbnail.jpg	\N	videos/207/207_66724aa8/207_66724aa8.mp4	852	480	71:40	1.775	30	h264	\N	Active
211_f89736c8	211	test_video.mp4	211_f89736c8.mp4	\N	9.466667	\N	2025-07-02 04:13:01.400271	2025-07-02 04:13:01.400272	f	\N	\N	videos/211/211_f89736c8/211_f89736c8_thumbnail.jpg	\N	videos/211/211_f89736c8/211_f89736c8.mp4	852	480	71:40	1.775	30	h264	\N	Active
215_e09ac43d	215	test_video.mp4	215_e09ac43d.mp4	\N	9.466667	\N	2025-07-02 05:05:54.335212	2025-07-02 05:05:54.335213	f	\N	\N	videos/215/215_e09ac43d/215_e09ac43d_thumbnail.jpg	\N	videos/215/215_e09ac43d/215_e09ac43d.mp4	852	480	71:40	1.775	30	h264	\N	Active
220_473a124c	220	test_video.mp4	220_473a124c.mp4	\N	9.466667	\N	2025-07-02 09:22:15.204824	2025-07-02 09:22:15.204825	f	\N	\N	videos/220/220_473a124c/220_473a124c_thumbnail.jpg	\N	videos/220/220_473a124c/220_473a124c.mp4	852	480	71:40	1.775	30	h264	\N	Active
178_30a4b372	178	test_video.mp4	178_30a4b372.mp4	\N	\N	\N	2025-06-27 08:37:03.971647	2025-06-27 08:37:03.971659	f	\N	\N	videos/178/178_30a4b372/178_30a4b372_thumbnail.jpg	\N	videos/178/178_30a4b372/178_30a4b372.mp4	\N	\N	\N	\N	\N	\N	\N	Active
225_1cc1a481	225	test_video.mp4	225_1cc1a481.mp4	\N	9.466667	\N	2025-07-02 10:32:13.691654	2025-07-02 10:32:13.691654	f	\N	\N	videos/225/225_1cc1a481/225_1cc1a481_thumbnail.jpg	\N	videos/225/225_1cc1a481/225_1cc1a481.mp4	852	480	71:40	1.775	30	h264	\N	Active
234_cffd70a1	234	test_video.mp4	234_cffd70a1.mp4	\N	9.466667	\N	2025-07-08 07:51:01.234378	2025-07-08 07:51:01.23438	f	\N	\N	videos/234/234_cffd70a1/234_cffd70a1_thumbnail.jpg	\N	videos/234/234_cffd70a1/234_cffd70a1.mp4	852	480	71:40	1.775	30	h264	\N	Active
242_c7de0590	242	loveJourney_en_in.mp4	242_c7de0590.mp4	\N	40.250322	\N	2025-07-09 08:11:37.261783	2025-07-09 08:11:37.261784	f	\N	\N	videos/242/242_c7de0590/242_c7de0590_thumbnail.jpg	\N	videos/242/242_c7de0590/242_c7de0590.mp4	1080	1920	9:16	0.5625	24	h264	\N	Active
166_cc467fe8	166	Lark20250626-224118.mp4	166_cc467fe8.mp4	\N	9.466667	\N	2025-07-11 03:35:39.795213	2025-07-11 03:35:39.795214	f	\N	\N	videos/166/166_cc467fe8/166_cc467fe8_thumbnail.jpg	\N	videos/166/166_cc467fe8/166_cc467fe8.mp4	852	480	71:40	1.775	30	h264	\N	Active
166_916f7139	166	TrumpTarrifs_cn_edited.mp4	166_916f7139.mp4	\N	20.8	\N	2025-07-11 04:00:57.443815	2025-07-11 04:00:57.443816	f	\N	\N	videos/166/166_916f7139/166_916f7139_thumbnail.jpg	\N	videos/166/166_916f7139/166_916f7139.mp4	720	1280	9:16	0.5625	30	h264	\N	Active
249_b8bf6681	249	test_video.mp4	249_b8bf6681.mp4	\N	9.466667	\N	2025-07-11 10:56:57.886257	2025-07-11 10:56:57.886258	f	\N	\N	videos/249/249_b8bf6681/249_b8bf6681_thumbnail.jpg	\N	videos/249/249_b8bf6681/249_b8bf6681.mp4	852	480	71:40	1.775	30	h264	\N	Active
186_97322cdc	186	test_video.mp4	186_97322cdc.mp4	\N	\N	\N	2025-06-30 09:39:18.476874	2025-06-30 09:39:18.476875	f	\N	\N	videos/186/186_97322cdc/186_97322cdc_thumbnail.jpg	\N	videos/186/186_97322cdc/186_97322cdc.mp4	\N	\N	\N	\N	\N	\N	\N	Active
192_a2cafd28	192	test_video.mp4	192_a2cafd28.mp4	\N	9.466667	\N	2025-06-30 10:25:34.948235	2025-06-30 10:25:34.948236	f	\N	\N	videos/192/192_a2cafd28/192_a2cafd28_thumbnail.jpg	\N	videos/192/192_a2cafd28/192_a2cafd28.mp4	852	480	71:40	1.775	30	h264	\N	Active
198_c45a799e	198	test_video.mp4	198_c45a799e.mp4	\N	57.766667	\N	2025-07-01 07:00:35.763017	2025-07-01 07:00:35.763019	f	\N	\N	videos/198/198_c45a799e/198_c45a799e_thumbnail.jpg	\N	videos/198/198_c45a799e/198_c45a799e.mp4	2160	3840	\N	\N	60	av1	\N	Active
202_62ebfd84	202	test_video.mp4	202_62ebfd84.mp4	\N	57.766667	\N	2025-07-01 09:56:25.671603	2025-07-01 09:56:25.671604	f	\N	\N	videos/202/202_62ebfd84/202_62ebfd84_thumbnail.jpg	\N	videos/202/202_62ebfd84/202_62ebfd84.mp4	2160	3840	\N	\N	60	av1	\N	Active
208_6bbc4333	208	test_video.mp4	208_6bbc4333.mp4	\N	9.466667	\N	2025-07-02 03:58:15.110265	2025-07-02 03:58:15.110265	f	\N	\N	videos/208/208_6bbc4333/208_6bbc4333_thumbnail.jpg	\N	videos/208/208_6bbc4333/208_6bbc4333.mp4	852	480	71:40	1.775	30	h264	\N	Active
212_a09faf66	212	test_video.mp4	212_a09faf66.mp4	\N	9.466667	\N	2025-07-02 04:20:30.220787	2025-07-02 04:20:30.220788	f	\N	\N	videos/212/212_a09faf66/212_a09faf66_thumbnail.jpg	\N	videos/212/212_a09faf66/212_a09faf66.mp4	852	480	71:40	1.775	30	h264	\N	Active
221_24470de5	221	test_video.mp4	221_24470de5.mp4	\N	9.466667	\N	2025-07-02 09:29:13.743459	2025-07-02 09:29:13.74346	f	\N	\N	videos/221/221_24470de5/221_24470de5_thumbnail.jpg	\N	videos/221/221_24470de5/221_24470de5.mp4	852	480	71:40	1.775	30	h264	\N	Active
179_4865820b	179	test_video.mp4	179_4865820b.mp4	\N	\N	\N	2025-06-27 08:43:18.785867	2025-06-27 08:43:18.78588	f	\N	\N	videos/179/179_4865820b/179_4865820b_thumbnail.jpg	\N	videos/179/179_4865820b/179_4865820b.mp4	\N	\N	\N	\N	\N	\N	\N	Active
239_edfd256e	239	test_video.mp4	239_edfd256e.mp4	\N	9.466667	\N	2025-07-08 09:53:33.167665	2025-07-08 09:53:33.167666	f	\N	\N	videos/239/239_edfd256e/239_edfd256e_thumbnail.jpg	\N	videos/239/239_edfd256e/239_edfd256e.mp4	852	480	71:40	1.775	30	h264	\N	Active
242_23d3986a	242	The Journey of Love for Mom.mp4	242_23d3986a.mp4	\N	40.250322	\N	2025-07-09 03:41:58.679821	2025-07-09 03:41:58.679821	f	\N	\N	videos/242/242_23d3986a/242_23d3986a_thumbnail.jpg	\N	videos/242/242_23d3986a/242_23d3986a.mp4	1080	1920	9:16	0.5625	24	h264	\N	Active
242_0863b968	242	test_video.mp4	242_0863b968.mp4	\N	9.466667	\N	2025-07-09 10:06:07.430787	2025-07-09 10:06:07.430788	f	\N	\N	videos/242/242_0863b968/242_0863b968_thumbnail.jpg	\N	videos/242/242_0863b968/242_0863b968.mp4	852	480	71:40	1.775	30	h264	\N	Active
183_3fd6473f	183	test_video.mp4	183_3fd6473f.mp4	\N	\N	\N	2025-06-30 04:32:25.698747	2025-06-30 04:32:25.698749	f	\N	\N	videos/183/183_3fd6473f/183_3fd6473f_thumbnail.jpg	\N	videos/183/183_3fd6473f/183_3fd6473f.mp4	\N	\N	\N	\N	\N	\N	\N	Active
166_43007b33	166	Lark20250626-224118.mp4	166_43007b33.mp4	\N	9.466667	\N	2025-07-11 03:27:47.391535	2025-07-11 03:27:47.391536	f	\N	\N	videos/166/166_43007b33/166_43007b33_thumbnail.jpg	\N	videos/166/166_43007b33/166_43007b33.mp4	852	480	71:40	1.775	30	h264	\N	Active
166_7a9be842	166	TrumpTarrifs_cn_edited.mp4	166_7a9be842.mp4	\N	20.8	\N	2025-07-11 03:41:22.837539	2025-07-11 03:41:22.83754	f	\N	\N	videos/166/166_7a9be842/166_7a9be842_thumbnail.jpg	\N	videos/166/166_7a9be842/166_7a9be842.mp4	720	1280	9:16	0.5625	30	h264	\N	Active
166_587fe583	166	TrumpTarrifs_cn_edited.mp4	166_587fe583.mp4	\N	20.8	\N	2025-07-11 04:01:59.288835	2025-07-11 04:01:59.288836	f	\N	\N	videos/166/166_587fe583/166_587fe583_thumbnail.jpg	\N	videos/166/166_587fe583/166_587fe583.mp4	720	1280	9:16	0.5625	30	h264	\N	Active
168_f5aa4a46	168	test_video.mp4	168_f5aa4a46.mp4	\N	\N	\N	2025-06-26 07:19:59.582081	2025-06-26 07:19:59.582093	f	\N	\N	videos/168/168_f5aa4a46/168_f5aa4a46_thumbnail.jpg	\N	videos/168/168_f5aa4a46/168_f5aa4a46.mp4	\N	\N	\N	\N	\N	\N	\N	Active
169_6821aeaa	169	test_video.mp4	169_6821aeaa.mp4	\N	\N	\N	2025-06-26 07:23:57.821282	2025-06-26 07:23:57.821299	f	\N	\N	videos/169/169_6821aeaa/169_6821aeaa_thumbnail.jpg	\N	videos/169/169_6821aeaa/169_6821aeaa.mp4	\N	\N	\N	\N	\N	\N	\N	Active
177_74163972	177	youtube_177_74163972.mp4	177_74163972.mp4	\N	5.029	\N	2025-07-22 12:21:24.895768	2025-07-22 12:21:24.895769	t	\N	\N	videos/177/177_74163972/177_74163972_thumbnail.jpg	\N	videos/177/177_74163972/177_74163972.mp4	1080	1920	\N	\N	29.83	vp9	https://www.youtube.com/shorts/sInTNxYpONU	Active
187_d6d6e8a4	187	test_video.mp4	187_d6d6e8a4.mp4	\N	\N	\N	2025-06-30 10:02:29.135577	2025-06-30 10:02:29.135578	f	\N	\N	videos/187/187_d6d6e8a4/187_d6d6e8a4_thumbnail.jpg	\N	videos/187/187_d6d6e8a4/187_d6d6e8a4.mp4	\N	\N	\N	\N	\N	\N	\N	Active
174_40015c37	174	gdg.mp4	174_40015c37.mp4	\N	29.366	\N	2025-07-22 13:26:34.214845	2025-07-22 13:26:34.214846	f	\N	\N	videos/174/174_40015c37/174_40015c37_thumbnail.jpg	\N	videos/174/174_40015c37/174_40015c37.mp4	1268	720	\N	\N	29.92	h264	\N	Active
170_d62cddd8	170	test_video.mp4	170_d62cddd8.mp4	\N	\N	\N	2025-06-26 07:42:46.400165	2025-06-26 07:42:46.400181	f	\N	\N	videos/170/170_d62cddd8/170_d62cddd8_thumbnail.jpg	\N	videos/170/170_d62cddd8/170_d62cddd8.mp4	\N	\N	\N	\N	\N	\N	\N	Active
193_7676ebb4	193	test_video.mp4	193_7676ebb4.mp4	\N	9.466667	\N	2025-07-01 01:26:04.107423	2025-07-01 01:26:04.107425	f	\N	\N	videos/193/193_7676ebb4/193_7676ebb4_thumbnail.jpg	\N	videos/193/193_7676ebb4/193_7676ebb4.mp4	852	480	71:40	1.775	30	h264	\N	Active
196_f8b106c0	196	test_video.mp4	196_f8b106c0.mp4	\N	9.466667	\N	2025-07-01 03:18:20.42461	2025-07-01 03:18:20.42461	f	\N	\N	videos/196/196_f8b106c0/196_f8b106c0_thumbnail.jpg	\N	videos/196/196_f8b106c0/196_f8b106c0.mp4	852	480	71:40	1.775	30	h264	\N	Active
171_5129f1ba	171	test_video.mp4	171_5129f1ba.mp4	\N	\N	\N	2025-06-26 08:14:40.833445	2025-06-26 08:14:40.833458	f	\N	\N	videos/171/171_5129f1ba/171_5129f1ba_thumbnail.jpg	\N	videos/171/171_5129f1ba/171_5129f1ba.mp4	\N	\N	\N	\N	\N	\N	\N	Active
199_43e8226f	199	test_video.mp4	199_43e8226f.mp4	\N	57.766667	\N	2025-07-01 07:21:48.107273	2025-07-01 07:21:48.107274	f	\N	\N	videos/199/199_43e8226f/199_43e8226f_thumbnail.jpg	\N	videos/199/199_43e8226f/199_43e8226f.mp4	2160	3840	\N	\N	60	av1	\N	Active
174_745cb7a7	174	gdg.mp4	174_745cb7a7.mp4	\N	29.366	\N	2025-07-22 16:28:02.041349	2025-07-22 16:28:02.041349	f	\N	\N	videos/174/174_745cb7a7/174_745cb7a7_thumbnail.jpg	\N	videos/174/174_745cb7a7/174_745cb7a7.mp4	1268	720	\N	\N	29.92	h264	\N	Active
179_5d7594bc	179	youtube_179_5d7594bc.mp4	179_5d7594bc.mp4	\N	5.029	\N	2025-07-22 12:31:55.583082	2025-07-22 12:31:55.583082	t	\N	\N	videos/179/179_5d7594bc/179_5d7594bc_thumbnail.jpg	\N	videos/179/179_5d7594bc/179_5d7594bc.mp4	1080	1920	\N	\N	29.83	vp9	https://www.youtube.com/shorts/sInTNxYpONU	Active
174_14ce6aec	174	gdg.mp4	174_14ce6aec.mp4	\N	29.366	\N	2025-07-22 13:27:30.899216	2025-07-22 13:27:30.899216	f	\N	\N	videos/174/174_14ce6aec/174_14ce6aec_thumbnail.jpg	\N	videos/174/174_14ce6aec/174_14ce6aec.mp4	1268	720	\N	\N	29.92	h264	\N	Active
174_88444c2d	174	gdg.mp4	174_88444c2d.mp4	\N	29.366	\N	2025-07-22 16:47:44.641578	2025-07-22 16:47:44.64158	f	\N	\N	videos/174/174_88444c2d/174_88444c2d_thumbnail.jpg	\N	videos/174/174_88444c2d/174_88444c2d.mp4	1268	720	\N	\N	29.92	h264	\N	Active
174_cf10f578	174	gdg.mp4	174_cf10f578.mp4	\N	29.366	\N	2025-07-22 13:25:25.623713	2025-07-22 13:25:25.623714	f	\N	\N	videos/174/174_cf10f578/174_cf10f578_thumbnail.jpg	\N	videos/174/174_cf10f578/174_cf10f578.mp4	1268	720	\N	\N	29.92	h264	\N	Active
205_d8ca60df	205	test_video.mp4	205_d8ca60df.mp4	\N	9.466667	\N	2025-07-02 03:38:07.919614	2025-07-02 03:38:07.919615	f	\N	\N	videos/205/205_d8ca60df/205_d8ca60df_thumbnail.jpg	\N	videos/205/205_d8ca60df/205_d8ca60df.mp4	852	480	71:40	1.775	30	h264	\N	Active
209_20f8d395	209	test_video.mp4	209_20f8d395.mp4	\N	9.466667	\N	2025-07-02 04:00:36.712	2025-07-02 04:00:36.712	f	\N	\N	videos/209/209_20f8d395/209_20f8d395_thumbnail.jpg	\N	videos/209/209_20f8d395/209_20f8d395.mp4	852	480	71:40	1.775	30	h264	\N	Active
213_7cb09526	213	test_video.mp4	213_7cb09526.mp4	\N	9.466667	\N	2025-07-02 04:24:06.367829	2025-07-02 04:24:06.36783	f	\N	\N	videos/213/213_7cb09526/213_7cb09526_thumbnail.jpg	\N	videos/213/213_7cb09526/213_7cb09526.mp4	852	480	71:40	1.775	30	h264	\N	Active
216_6d5663a6	216	test_video.mp4	216_6d5663a6.mp4	\N	9.466667	\N	2025-07-02 05:35:56.833533	2025-07-02 05:35:56.833534	f	\N	\N	videos/216/216_6d5663a6/216_6d5663a6_thumbnail.jpg	\N	videos/216/216_6d5663a6/216_6d5663a6.mp4	852	480	71:40	1.775	30	h264	\N	Active
217_d34aa897	217	test_video.mp4	217_d34aa897.mp4	\N	9.466667	\N	2025-07-02 06:13:39.471556	2025-07-02 06:13:39.471558	f	\N	\N	videos/217/217_d34aa897/217_d34aa897_thumbnail.jpg	\N	videos/217/217_d34aa897/217_d34aa897.mp4	852	480	71:40	1.775	30	h264	\N	Active
173_c6269ac9	173	test_video.mp4	173_c6269ac9.mp4	\N	\N	\N	2025-06-26 13:02:50.04763	2025-06-26 13:02:50.047642	f	\N	\N	videos/173/173_c6269ac9/173_c6269ac9_thumbnail.jpg	\N	videos/173/173_c6269ac9/173_c6269ac9.mp4	\N	\N	\N	\N	\N	\N	\N	Active
174_9098c1d3	174	test_video.mp4	174_9098c1d3.mp4	\N	\N	\N	2025-06-26 13:15:22.60856	2025-06-26 13:15:22.608576	f	\N	\N	videos/174/174_9098c1d3/174_9098c1d3_thumbnail.jpg	\N	videos/174/174_9098c1d3/174_9098c1d3.mp4	\N	\N	\N	\N	\N	\N	\N	Active
175_ce9724e3	175	test_video.mp4	175_ce9724e3.mp4	\N	\N	\N	2025-06-26 14:05:34.752866	2025-06-26 14:05:34.752881	f	\N	\N	videos/175/175_ce9724e3/175_ce9724e3_thumbnail.jpg	\N	videos/175/175_ce9724e3/175_ce9724e3.mp4	\N	\N	\N	\N	\N	\N	\N	Active
176_fc9d65c6	176	test_video.mp4	176_fc9d65c6.mp4	\N	\N	\N	2025-06-26 14:27:04.257005	2025-06-26 14:27:04.257018	f	\N	\N	videos/176/176_fc9d65c6/176_fc9d65c6_thumbnail.jpg	\N	videos/176/176_fc9d65c6/176_fc9d65c6.mp4	\N	\N	\N	\N	\N	\N	\N	Active
177_ced6d062	177	test_video.mp4	177_ced6d062.mp4	\N	\N	\N	2025-06-26 14:33:19.890773	2025-06-26 14:33:19.890786	f	\N	\N	videos/177/177_ced6d062/177_ced6d062_thumbnail.jpg	\N	videos/177/177_ced6d062/177_ced6d062.mp4	\N	\N	\N	\N	\N	\N	\N	Active
222_05247c17	222	test_video.mp4	222_05247c17.mp4	\N	9.466667	\N	2025-07-02 09:48:53.325016	2025-07-02 09:48:53.325016	f	\N	\N	videos/222/222_05247c17/222_05247c17_thumbnail.jpg	\N	videos/222/222_05247c17/222_05247c17.mp4	852	480	71:40	1.775	30	h264	\N	Active
180_ecb3cea5	180	test_video.mp4	180_ecb3cea5.mp4	\N	\N	\N	2025-06-27 09:00:33.152582	2025-06-27 09:00:33.152595	f	\N	\N	videos/180/180_ecb3cea5/180_ecb3cea5_thumbnail.jpg	\N	videos/180/180_ecb3cea5/180_ecb3cea5.mp4	\N	\N	\N	\N	\N	\N	\N	Active
242_1869cab9	242	The Journey of Love for Mom.mp4	242_1869cab9.mp4	\N	40.250322	\N	2025-07-09 03:42:57.450254	2025-07-09 03:42:57.450255	f	\N	\N	videos/242/242_1869cab9/242_1869cab9_thumbnail.jpg	\N	videos/242/242_1869cab9/242_1869cab9.mp4	1080	1920	9:16	0.5625	24	h264	\N	Active
166_aa7d3ba5	166	Lark20250626-224118.mp4	166_aa7d3ba5.mp4	\N	9.466667	\N	2025-07-11 03:28:16.107353	2025-07-11 03:28:16.107356	f	\N	\N	videos/166/166_aa7d3ba5/166_aa7d3ba5_thumbnail.jpg	\N	videos/166/166_aa7d3ba5/166_aa7d3ba5.mp4	852	480	71:40	1.775	30	h264	\N	Active
166_3faae103	166	Lark20250626-224118.mp4	166_3faae103.mp4	\N	9.466667	\N	2025-07-11 03:56:20.486317	2025-07-11 03:56:20.486319	f	\N	\N	videos/166/166_3faae103/166_3faae103_thumbnail.jpg	\N	videos/166/166_3faae103/166_3faae103.mp4	852	480	71:40	1.775	30	h264	\N	Active
166_fa3713e1	166	Lark20250626-224118.mp4	166_fa3713e1.mp4	\N	9.466667	\N	2025-07-11 04:07:25.860049	2025-07-11 04:07:25.860051	f	\N	\N	videos/166/166_fa3713e1/166_fa3713e1_thumbnail.jpg	\N	videos/166/166_fa3713e1/166_fa3713e1.mp4	852	480	71:40	1.775	30	h264	\N	Active
184_3b1fd7f0	184	test_video.mp4	184_3b1fd7f0.mp4	\N	\N	\N	2025-06-30 06:50:02.859918	2025-06-30 06:50:02.859918	f	\N	\N	videos/184/184_3b1fd7f0/184_3b1fd7f0_thumbnail.jpg	\N	videos/184/184_3b1fd7f0/184_3b1fd7f0.mp4	\N	\N	\N	\N	\N	\N	\N	Active
174_4f59e8c3	174	gdg.mp4	174_4f59e8c3.mp4	\N	29.366	\N	2025-07-22 13:57:34.865078	2025-07-22 13:57:34.865079	f	\N	\N	videos/174/174_4f59e8c3/174_4f59e8c3_thumbnail.jpg	\N	videos/174/174_4f59e8c3/174_4f59e8c3.mp4	1268	720	\N	\N	29.92	h264	\N	Active
188_faf9e0be	188	test_video.mp4	188_faf9e0be.mp4	\N	\N	\N	2025-06-30 10:09:30.068711	2025-06-30 10:09:30.068712	f	\N	\N	videos/188/188_faf9e0be/188_faf9e0be_thumbnail.jpg	\N	videos/188/188_faf9e0be/188_faf9e0be.mp4	\N	\N	\N	\N	\N	\N	\N	Active
174_327bf61d	174	gdg.mp4	174_327bf61d.mp4	\N	29.366	\N	2025-07-22 13:26:05.364224	2025-07-22 13:26:05.364225	f	\N	\N	videos/174/174_327bf61d/174_327bf61d_thumbnail.jpg	\N	videos/174/174_327bf61d/174_327bf61d.mp4	1268	720	\N	\N	29.92	h264	\N	Active
194_66645666	194	test_video.mp4	194_66645666.mp4	\N	9.466667	\N	2025-07-01 01:47:37.655628	2025-07-01 01:47:37.655629	f	\N	\N	videos/194/194_66645666/194_66645666_thumbnail.jpg	\N	videos/194/194_66645666/194_66645666.mp4	852	480	71:40	1.775	30	h264	\N	Active
174_1af2349a	174	gdg.mp4	174_1af2349a.mp4	\N	29.366	\N	2025-07-22 13:58:19.226805	2025-07-22 13:58:19.226805	f	\N	\N	videos/174/174_1af2349a/174_1af2349a_thumbnail.jpg	\N	videos/174/174_1af2349a/174_1af2349a.mp4	1268	720	\N	\N	29.92	h264	\N	Active
155_7e6118e6	155	kyani_sample_cn_in.mp4	155_7e6118e6.mp4	\N	9.466667	\N	2025-07-15 09:12:41.562472	2025-07-15 09:12:41.562473	f	\N	\N	videos/155/155_7e6118e6/155_7e6118e6_thumbnail.jpg	\N	videos/155/155_7e6118e6/155_7e6118e6.mp4	852	480	71:40	1.775	30	h264	\N	Active
200_d1cb7783	200	test_video.mp4	200_d1cb7783.mp4	\N	57.766667	\N	2025-07-01 08:00:12.676858	2025-07-01 08:00:12.676859	f	\N	\N	videos/200/200_d1cb7783/200_d1cb7783_thumbnail.jpg	\N	videos/200/200_d1cb7783/200_d1cb7783.mp4	2160	3840	\N	\N	60	av1	\N	Active
206_10e0e66b	206	test_video.mp4	206_10e0e66b.mp4	\N	9.466667	\N	2025-07-02 03:39:02.220632	2025-07-02 03:39:02.220632	f	\N	\N	videos/206/206_10e0e66b/206_10e0e66b_thumbnail.jpg	\N	videos/206/206_10e0e66b/206_10e0e66b.mp4	852	480	71:40	1.775	30	h264	\N	Active
210_185eef1d	210	test_video.mp4	210_185eef1d.mp4	\N	9.466667	\N	2025-07-02 04:02:47.904166	2025-07-02 04:02:47.904167	f	\N	\N	videos/210/210_185eef1d/210_185eef1d_thumbnail.jpg	\N	videos/210/210_185eef1d/210_185eef1d.mp4	852	480	71:40	1.775	30	h264	\N	Active
214_c4a1ae3e	214	test_video.mp4	214_c4a1ae3e.mp4	\N	9.466667	\N	2025-07-02 04:41:17.645471	2025-07-02 04:41:17.645472	f	\N	\N	videos/214/214_c4a1ae3e/214_c4a1ae3e_thumbnail.jpg	\N	videos/214/214_c4a1ae3e/214_c4a1ae3e.mp4	852	480	71:40	1.775	30	h264	\N	Active
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: curify
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-05-27 12:57:53
20211116045059	2025-05-27 12:57:56
20211116050929	2025-05-27 12:57:58
20211116051442	2025-05-27 12:58:00
20211116212300	2025-05-27 12:58:03
20211116213355	2025-05-27 12:58:05
20211116213934	2025-05-27 12:58:07
20211116214523	2025-05-27 12:58:10
20211122062447	2025-05-27 12:58:12
20211124070109	2025-05-27 12:58:14
20211202204204	2025-05-27 12:58:16
20211202204605	2025-05-27 12:58:18
20211210212804	2025-05-27 12:58:25
20211228014915	2025-05-27 12:58:27
20220107221237	2025-05-27 12:58:29
20220228202821	2025-05-27 12:58:31
20220312004840	2025-05-27 12:58:33
20220603231003	2025-05-27 12:58:36
20220603232444	2025-05-27 12:58:38
20220615214548	2025-05-27 12:58:41
20220712093339	2025-05-27 12:58:43
20220908172859	2025-05-27 12:58:45
20220916233421	2025-05-27 12:58:47
20230119133233	2025-05-27 12:58:49
20230128025114	2025-05-27 12:58:52
20230128025212	2025-05-27 12:58:54
20230227211149	2025-05-27 12:58:56
20230228184745	2025-05-27 12:58:58
20230308225145	2025-05-27 12:59:00
20230328144023	2025-05-27 12:59:02
20231018144023	2025-05-27 12:59:04
20231204144023	2025-05-27 12:59:08
20231204144024	2025-05-27 12:59:10
20231204144025	2025-05-27 12:59:12
20240108234812	2025-05-27 12:59:14
20240109165339	2025-05-27 12:59:16
20240227174441	2025-05-27 12:59:20
20240311171622	2025-05-27 12:59:23
20240321100241	2025-05-27 12:59:27
20240401105812	2025-05-27 12:59:33
20240418121054	2025-05-27 12:59:36
20240523004032	2025-05-27 12:59:43
20240618124746	2025-05-27 12:59:45
20240801235015	2025-05-27 12:59:47
20240805133720	2025-05-27 12:59:49
20240827160934	2025-05-27 12:59:51
20240919163303	2025-05-27 12:59:54
20240919163305	2025-05-27 12:59:56
20241019105805	2025-05-27 12:59:58
20241030150047	2025-05-27 13:00:06
20241108114728	2025-05-27 13:00:09
20241121104152	2025-05-27 13:00:11
20241130184212	2025-05-27 13:00:13
20241220035512	2025-05-27 13:00:15
20241220123912	2025-05-27 13:00:17
20241224161212	2025-05-27 13:00:19
20250107150512	2025-05-27 13:00:22
20250110162412	2025-05-27 13:00:24
20250123174212	2025-05-27 13:00:26
20250128220012	2025-05-27 13:00:28
20250506224012	2025-05-27 13:00:29
20250523164012	2025-06-01 23:52:56
20250714121412	2025-07-22 04:37:50
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: curify
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: curify
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: curify
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-05-27 12:57:47.908401
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-05-27 12:57:47.918836
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-05-27 12:57:47.924002
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-05-27 12:57:47.952316
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-05-27 12:57:47.980455
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-05-27 12:57:47.986106
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-05-27 12:57:47.992773
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-05-27 12:57:47.999235
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-05-27 12:57:48.009832
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-05-27 12:57:48.016156
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-05-27 12:57:48.021753
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-05-27 12:57:48.02803
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-05-27 12:57:48.034917
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-05-27 12:57:48.040079
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-05-27 12:57:48.045364
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-05-27 12:57:48.074138
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-05-27 12:57:48.079615
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-05-27 12:57:48.084798
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-05-27 12:57:48.090255
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-05-27 12:57:48.096454
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-05-27 12:57:48.103096
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-05-27 12:57:48.113551
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-05-27 12:57:48.144853
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-05-27 12:57:48.178354
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-05-27 12:57:48.184081
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-05-27 12:57:48.18963
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: curify
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: curify
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: curify
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: curify
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: project_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: curify
--

SELECT pg_catalog.setval('public.project_project_id_seq', 1, false);


--
-- Name: projectsegment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: curify
--

SELECT pg_catalog.setval('public.projectsegment_id_seq', 362, true);


--
-- Name: subscription_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: curify
--

SELECT pg_catalog.setval('public.subscription_subscription_id_seq', 131, true);


--
-- Name: transaction_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: curify
--

SELECT pg_catalog.setval('public.transaction_transaction_id_seq', 296, true);


--
-- Name: user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: curify
--

SELECT pg_catalog.setval('public.user_user_id_seq', 183, true);


--
-- Name: video_video_id_seq; Type: SEQUENCE SET; Schema: public; Owner: curify
--

SELECT pg_catalog.setval('public.video_video_id_seq', 2, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: curify
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: project project_pkey; Type: CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (project_id);


--
-- Name: project_segment_annotation project_segment_annotation_pkey; Type: CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.project_segment_annotation
    ADD CONSTRAINT project_segment_annotation_pkey PRIMARY KEY (segment_id, project_id, line_number);


--
-- Name: projectsegment projectsegment_pkey; Type: CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.projectsegment
    ADD CONSTRAINT projectsegment_pkey PRIMARY KEY (segment_id);


--
-- Name: subscription subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (subscription_id);


--
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (transaction_id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- Name: video video_pkey; Type: CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_pkey PRIMARY KEY (video_id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: curify
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: curify
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: curify
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: curify
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: curify
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: curify
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: curify
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: curify
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: curify
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: curify
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: curify
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: curify
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: curify
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: curify
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: curify
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: ix_project_name; Type: INDEX; Schema: public; Owner: curify
--

CREATE INDEX ix_project_name ON public.project USING btree (name);


--
-- Name: ix_project_user_id; Type: INDEX; Schema: public; Owner: curify
--

CREATE INDEX ix_project_user_id ON public.project USING btree (user_id);


--
-- Name: ix_projectsegment_project_id; Type: INDEX; Schema: public; Owner: curify
--

CREATE INDEX ix_projectsegment_project_id ON public.projectsegment USING btree (project_id);


--
-- Name: ix_projectsegment_video_id; Type: INDEX; Schema: public; Owner: curify
--

CREATE INDEX ix_projectsegment_video_id ON public.projectsegment USING btree (video_id);


--
-- Name: ix_user_google_id; Type: INDEX; Schema: public; Owner: curify
--

CREATE UNIQUE INDEX ix_user_google_id ON public."user" USING btree (google_id);


--
-- Name: ix_video_stored_filename; Type: INDEX; Schema: public; Owner: curify
--

CREATE UNIQUE INDEX ix_video_stored_filename ON public.video USING btree (stored_filename);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: curify
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: curify
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: curify
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: curify
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: curify
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: curify
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: curify
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: curify
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: curify
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: curify
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: projectsegment fk_projectsegment_video; Type: FK CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.projectsegment
    ADD CONSTRAINT fk_projectsegment_video FOREIGN KEY (video_id) REFERENCES public.video(video_id);


--
-- Name: project_segment_annotation project_segment_annotation_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.project_segment_annotation
    ADD CONSTRAINT project_segment_annotation_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(project_id);


--
-- Name: project_segment_annotation project_segment_annotation_segment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.project_segment_annotation
    ADD CONSTRAINT project_segment_annotation_segment_id_fkey FOREIGN KEY (segment_id) REFERENCES public.projectsegment(segment_id);


--
-- Name: project project_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: project project_video_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_video_id_fkey FOREIGN KEY (video_id) REFERENCES public.video(video_id);


--
-- Name: projectsegment projectsegment_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.projectsegment
    ADD CONSTRAINT projectsegment_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(project_id);


--
-- Name: subscription subscription_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: transaction transaction_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: user user_subscription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES public.subscription(subscription_id);


--
-- Name: video video_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: curify
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: curify
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: curify
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: curify
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: curify
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: curify
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: curify
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: curify
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: curify
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: curify
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: curify
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: curify
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: curify
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO curify;

--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: curify
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: curify
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO curify;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: curify
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO curify;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: curify
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO curify;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: curify
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO curify;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: curify
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO curify;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: curify
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO curify;

--
-- PostgreSQL database dump complete
--

