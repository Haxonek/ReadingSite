# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
  {email: "guy@email.com", name: "guy", password: "password", description: "description"},
  {email: "person@email.com", name: "person", password: "password", description: "description"},
  {email: "human@email.com", name: "human", password: "password", description: "description"},
  {email: "sapian@email.com", name: "sapian", password: "password", description: "description"},
  {email: "gal@email.com", name: "gal", password: "password", description: "description"}
])

Book.create([
  {title: "An Autobiography", description: "This is a book description", tags: "big, large, huge, giant", user_id: 1, volumes: 2},
  {title: "The Big Event", description: "This is a book description", tags: "itsy-bitsy, small, little, tiny", user_id: 3, volumes: 6},
  {title: "John Blumpkin", description: "This is a book description", tags: "big, ben, spider, ape", user_id: 3, volumes: 1},
  {title: "Biggie Smalls", description: "This is a book description", tags: "orange, pink, red, salmon", user_id: 3, volumes: 1},
  {title: "Book 1", description: "This is a book description", tags: "violate, blue, purple, white", user_id: 5, volumes: 1},
  ])

Chapter.create([
  {title: "Chapter 1", tags: "dave, chappell, show", book_id: 1, content: "This is the main book."},
  {title: "Chapter 2", tags: "dave, chappell, show", book_id: 1, content: "This is the main book."},
  {title: "Chapter 1", tags: "kanye, yeeze, rapper", book_id: 2, content: "This is the main book."},
  {title: "Chapter 2", tags: "song, sonnett, sings", book_id: 2, content: "This is the main book."},
  {title: "Chapter 3", tags: "never, bad, no, good", book_id: 2, content: "This is the main book."},
  {title: "Chapter 4", tags: "right, down, through", book_id: 2, content: "A long, long, long, long time ago."},
  {title: "Chapter 5", tags: "dave, chappell, show", book_id: 2, content: "This is the main book."},
  {title: "Chapter 6", tags: "dave, chappell, show", book_id: 2, content: "This is the main book."},
  {title: "Chapter 1", tags: "dave, chappell, show", book_id: 3, content: "This is the main book."},
  {title: "The awakening", tags: "dave, chappell, show", book_id: 4, content: "This is the main book."},
  {title: "Chapter 1", tags: "dave, chappell, show", book_id: 5, content: "This is the main book."}
  ])

Comment.create([
  {user_id: 2, book_id: 1, chapter_id: 1, content: "First comment"},
  {user_id: 2, book_id: 5, chapter_id: 1, content: "Second comment"},
  {user_id: 3, book_id: 2, chapter_id: 4, content: "Third comment"},
  {user_id: 1, book_id: 2, chapter_id: 4, content: "Fourth comment"},
  {user_id: 5, book_id: 2, chapter_id: 1, content: "Fifth comment"},
  {user_id: 2, book_id: 1, chapter_id: 2, content: "Sixth comment"},
  ])
