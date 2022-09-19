defmodule DataHouse.Services.Publisher do
  @moduledoc """
  A module to handle all message publish
  """
  @behaviour GenRMQ.Publisher

  # Use these from ENV variables by taking it dynamically
  @rmq_user Application.compile_env!(:data_house, :rabbit_mq)[:username]
  @rmq_password Application.compile_env!(:data_house, :rabbit_mq)[:password]
  @rmq_host Application.compile_env!(:data_house, :rabbit_mq)[:host]
  @rmq_port Application.compile_env!(:data_house, :rabbit_mq)[:port]
  @rmq_uri "amqp://#{@rmq_user}:#{@rmq_password}@#{@rmq_host}:#{@rmq_port}"
  @exchange "_data"
  @dielectrons_queue "dielectrons"
  @twitchdata_queue "twitchdata"
  @memes_queue "memes"
  @publish_options [persistent: false]

  def init do
    create_rmq_resources()

    [
      uri: @rmq_uri,
      exchange: @exchange
    ]
  end

  @spec start_link :: {:error, any} | {:ok, pid}
  def start_link do
    GenRMQ.Publisher.start_link(__MODULE__, name: __MODULE__)
  end

  @spec publish(binary, binary) ::
          :ok | {:error, :blocked | :closing | :confirmation_timeout} | {:ok, :confirmed}
  def publish(queue, data) do
    GenRMQ.Publisher.publish(__MODULE__, data, queue, @publish_options)
  end

  def dielectrons_queue_name, do: @dielectrons_queue
  def twitchdata_queue_name, do: @twitchdata_queue
  def memes_queue_name, do: @memes_queue

  defp create_rmq_resources do
    # Setup RabbitMQ connection
    {:ok, connection} = AMQP.Connection.open(@rmq_uri)
    {:ok, channel} = AMQP.Channel.open(connection)

    AMQP.Exchange.declare(channel, @exchange, :topic, durable: true)

    for queue <- [@dielectrons_queue, @memes_queue, @twitchdata_queue] do
      AMQP.Queue.declare(channel, queue, durable: true)
      AMQP.Queue.bind(channel, queue, @exchange, routing_key: queue)
    end

    AMQP.Channel.close(channel)
  end
end
