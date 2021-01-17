require 'sqlite3'

module Agents
  class Sqlite3WriteAgent < Agent
    include FormConfigurable

    cannot_be_scheduled!

    description <<-MD
      This agent allows data to be written to a SQLite3 database. You can use
      this as a means to pass data into a format that is perhaps a more durable
      than Huginn's internal database + be a bit more queryable than the
      `events` table. Generally you'll want to use this in combination with a
      Javascript agent, which will allow you to intake arbitrary events and
      properly format them into the event schema expected by this agent.

      Note that the agent expects the sqlite3 database at `database_path` to
      already exist. You are responsible for setting up this db file and its
      tables yourself.

      ## Writing Data
      This agent accepts events in the following format:
      
          {
            "query": "INSERT INTO some_table (col1, col2) VALUES(?, ?)",
            "parameters": ["abc", 123]
          }

      Regardless of the result, the agent will _not_ transmit any outgoing
      events. It will, however, log whether or not the query was successful.
    MD

    form_configurable :database_path, type: :string
    def validate_options
      if options['database_path'].blank?
        errors.add(:database_path, 'cannot be blank')
      elsif !File.file?(options['database_path'])
        errors.add(:database_path, 'does not exist')
      end
    end

    def default_options
      {
        'database_path' => '/path/to/some/sqlite3.db',
      }
    end

    def working?
      if memory['last_success'].nil?
        true
      else
        memory['last_success']
      end
    end

    def receive(incoming_events)
      memory['last_success'] = false

      db = SQLite3::Database.new options['database_path']
      incoming_events.each do |event|
        db.execute event.payload['query'], event.payload['parameters']
        log("Executed query '#{event.payload['query']}' with params: #{event.payload['parameters']}")
      end

      memory['last_success'] = true
    end
  end
end
