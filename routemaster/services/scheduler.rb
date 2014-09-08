require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '1s' do
  puts "testing the scheduler"
end

scheduler.every '1m' do
  tags = [
    "env:#{ENV['RACK_ENV']}",
    'app:routemaster'
  ]

  Routemaster::Services::DeliverMetric.deliver(
    'subscription.queue.size',
    subscription.queue.message_count,
    tags
  )

  Routemaster::Services::DeliverMetric.deliver(
    'subscription.queue.staleness',
    subscription.queue.age_of_oldest_message,
    tags
  )
end
