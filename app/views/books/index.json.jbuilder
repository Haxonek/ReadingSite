json.array!(@books) do |book|
  json.extract! book, :id, :title, :description, :complete, :volumes, :user_id
  json.url book_url(book, format: :json)
end
