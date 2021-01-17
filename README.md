# SQLite3 Agent
This gem provides an agent for [Huginn](https://github.com/huginn/huginn) which
provides an easy interface for writing to SQLite 3 databases.

For detailed instructions on its usage, please see the Markdown description
within the agent's source (which will also be displayed in your Huginn
dashboard).

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
