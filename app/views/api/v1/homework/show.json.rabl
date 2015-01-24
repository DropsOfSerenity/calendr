attributes :title, :subject, :description

node(:due_date) { |h| h.due_date.iso8601 unless h.due_date.nil? }
