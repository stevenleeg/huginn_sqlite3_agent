# SQLite3 Agent
This gem provides an agent for [Huginn](https://github.com/huginn/huginn) which provides an easy interface for writing to SQLite 3 databases.

For detailed instructions on its usage, please see the Markdown description within the [agent's source](https://github.com/stevenleeg/huginn_sqlite3_agent/blob/master/lib/huginn_sqlite3_agent/sqlite3_write_agent.rb) (which will also be displayed in your Huginn dashboard).

## Installation
Like any other Huginn agent, you may install this agent by adding thw following
to your `.env` file:

```
ADDITIONAL_GEMS=huginn_sqlite3_agent
```

or, if you wish to stay on the bleeding edge:

```
ADDITIONAL_GEMS=huginn_sqlite3_agent(git:https://github.com/stevenleeg/huginn_sqlite3_agent.git)
```

Note that this gem relies on the [sqlite3 gem](https://github.com/sparklemotion/sqlite3-ruby) which itself requires SQLite3 development headers. If you're running Huginn on a regular server, satisfying this requirement may be as simple as running `apt install libsqlite3-dev` (or whatever your distro's equivilent may be). For those of you running Huginn via Docker, you may need to build a custom image in order to get this running. Not to fear though, this isn't too hard:

```Dockerfile
FROM huginn/huginn

USER root
RUN apt-get update && apt-get install -y libsqlite3-dev

USER 1001
```

You can then build the image with:

```
docker build -t custom-huginn .
```
