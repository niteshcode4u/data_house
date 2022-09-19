# DataHouse

An application is responsible to parse CSV file data and store to MySQL database and Redis together by using RabbitMQ as message queueing.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Need to get dependent application running with `docker-compose up -d`.
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`.
  * please check help for parsing CSVs by running below into iex console `h DataHouse.Services.DataProcessor.parse_csv` and parse CSVs.
  * Now you can fetch data using `http://localhost:4000?query="twitchdata"` API. (query can be `"twitchdata", "dielectrons", "memes"`)

#### How to parse
  We need to go to running iex console and perform below 
    alias DataHouse.Services.DataProcessor
    DataProcessor.parse_csv(file_path, data_set)
    
    here path & data_set can be seen in help section of called module `h DataProcessor.parse_csv`

#### Where to fetch
  We need to make an API call using below details
    URL: 
      1. http://127.0.0.1:4000/api/data?query=twitchdata (assuming app is working locally at port 4000)
      2. http://127.0.0.1:4000/api/data?query=twitchdata&pagination_offset=100 (when we need next set of data and increase by 100 to get next)
    Method: GET
    
#### Development process and working model
  1. All data is published to RabbitMQ and separated by topics.
  2. Data is published asynchronously. 
  3. All consumers are consuming data asynchronously. 
  4. Consumed data is being stored in MySQL in a structured way 
  5. REST API is providing data based on topic filters and also paginated.

#### My Assumptions
  1. Provides data will always be in the same format as the heading says in provided CSVs. However, some data type parsing is taken care.
  2. If I have missed anything during development you will ask me to do it and will.

#### Enhancements area
  1. Separate topics/ queues creation to test env in case required.
  2. Redis things has been taken care of here however there is an area for enhancements