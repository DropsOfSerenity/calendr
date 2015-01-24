object @homework

attributes :title, :subject, :description, :due_date

node(:due_date) { |h| h.due_date.inspect }
