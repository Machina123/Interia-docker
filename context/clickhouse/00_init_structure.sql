CREATE TABLE IF NOT EXISTS varnish_queue (
    data_client_ip String,
    data_remote_use String,
    data_http_host String,
    data_x_forwarded_for String,
    data_duration_usec UInt32,
    data_http_method String,
    data_http_request String,
    data_http_query String,
    data_http_version String,
    data_status_code UInt16,
    data_bytes UInt32,
    data_http_referrer String,
    data_user_agent String,
    data_hit_miss String,
    data_handling String,
    data_time_first_byte Float32
) ENGINE = Kafka('kafka-1:9092,kafka-2:9092', 'varnish', 'clickhouse_consumer', 'JSONEachRow');