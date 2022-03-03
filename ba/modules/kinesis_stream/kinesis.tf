resource "aws_kinesis_stream" "stream" {
    name = var.name
    shard_count = var.shard_count
    
    retention_period = var.retention_period

    dynamic "stream_mode_details" {
        for_each = var.stream_mode
        content {
            stream_mode = stream_mode_details.value.stream_mode
        }
        
  }

}