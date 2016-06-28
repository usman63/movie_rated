json.array!(@movies) do |movie|
  json.extract! movie, :id, :name, :date_of_release, :is_featured, :description, :duration, :trailer
  json.url movie_url(movie, format: :json)
end
