require 'sqlite3'

module Agents
  class Sqlite3ReadAgent < Agent
    include FormConfigurable

    can_dry_run!

    description <<-MD
      This agent allows data to be read from a SQLite3 database.

      Note that the agent expects the sqlite3 database at `database_path` to
      already exist. You are responsible for setting up this db file and its
      tables yourself.

      ## Reading data
      This agent accepts events in the following format:
      
          {
            "query": "SELECT * FROM some_table WHERE some_value=? AND other_value=?",
            "parameters": ["first", "second"]
          }

      The agent will then output a single event:

          {
            "results": [
              {"col1": "somevalue", "col2": "another value"},
              {"col1": "somevalue", "col2": "another value"},
              ...
            ],
          }
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
      db.results_as_hash = true

      incoming_events.each do |event|
        results = db.execute event.payload['query'], event.payload['parameters']
        create_event payload: {
          results: results,
        }
      end

      memory['last_success'] = true
    end
  end
end
