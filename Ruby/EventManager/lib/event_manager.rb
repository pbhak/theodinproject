puts 'Event Manager Initialized'

lines = File.readlines('event_attendees.csv')
lines.each_with_index do |line, index|
  next if index.zero?

  columns = line.split(',')
  puts columns[2]
end