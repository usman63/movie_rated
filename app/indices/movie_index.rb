ThinkingSphinx::Index.define :movie, with: :active_record, delta: true do
  indexes name, sortable: true
  indexes description
  indexes genre
  has :released_date
  has :approved
  has :is_featured
  indexes actors.name, as: :actor
end
