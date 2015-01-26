attributes :id, :title, :subject, :description

node(:due_date) { |h| h.due_date.iso8601 unless h.due_date.nil? }
node(:completed_at) { |h| h.completed_at.iso8601 unless h.completed_at.nil? }
