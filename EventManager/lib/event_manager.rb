require 'csv'
require 'date'
require 'erb'
require 'google/apis/civicinfo_v2'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def format_phone_number(phone_number)
  phone_number_array = phone_number.split('')
  final_number = ''

  phone_number_array.each_with_index do |digit, index|
    if index.zero?
      final_number << "(#{digit}"
    elsif index == 2
      final_number << "#{digit}) "
    elsif index == 5
      final_number << "#{digit}-"
    else
      final_number << digit
    end
  end

  final_number
end

def clean_phone_number(phone_number)
  phone_number = phone_number.delete('^0-9')

  if phone_number.length < 10 || phone_number.length > 11 || (phone_number.length == 11 && phone_number[0] != 1)
    '(000) 000-0000'
  elsif phone_number.length == 11 && phone_number[0] == 1
    format_phone_number(phone_number[1..])
  else
    format_phone_number(phone_number)
  end
end

def convert_string_to_time(string_time)
  date = string_time.split[0]
  time = string_time.split[1]

  date_split = date.split('/')
  time_split = time.split(':')

  Time.new(date_split[2].to_i + 2000, date_split[0], date_split[1], time_split[0], time_split[1])
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir 'output' unless Dir.exist? 'output'

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'Event Manager Initialized'
puts

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

registration_hours = Hash.new(0)
peak_hours = []

registration_days = Hash.new(0)
peak_days = []

contents.each do |row|
  id = row[0]
  date_and_time = convert_string_to_time(row[:regdate])
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_number(row[:homephone])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  registration_hours[date_and_time.hour] += 1
  registration_days[date_and_time.wday] += 1

  save_thank_you_letter(id, form_letter)
end

registration_hours.each do |hour, value|
  peak_hours << hour if value == registration_hours.values.max
end

registration_days.each do |day, value|
  peak_days << day if value == registration_days.values.max
end

puts 'Peak registration hours were: '

peak_hours.each do |hour|
  if hour > 12
    puts "#{hour - 12} PM"
  else
    puts "#{hour} AM"
  end
end

puts

puts 'Peak registration days were: '

peak_days.each do |day|
  puts "#{Date::DAYNAMES[day]} - #{registration_days[day]} registrations"
end
