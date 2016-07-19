ThinkingSphinx::Index.define :movie, with: :active_record do
  indexes name, sortable: true
  indexes description
  indexes released_date, sortable: true
  indexes genre
  indexes actors.name, as: :actor
end
