require 'csv'
require_relative 'web_site_parser'

class SaveMethodBenchmark



  def call
    # load users data
    users = CSV.read(CSV_FILE)


    # clear database and save 10% of users
    # PrepareDatabase.call(users)


    # measure time of records saving
    puts Benchmark.measure { User.save_method(users) }
  end

  def csv_load(root)
    parser = WebSiteParser.new("https://biblio.by/biblio-books.html?cat=4921")
    books = parser.books
    puts books
    file = "#{root}/db/books.csv"
    CSV.open(file, "a+") do |csv|
      books.each do |book|
         csv << [book[:title], book[:author], book[:genre], book[:cover], book[:status]]
      end
    end
  end
end

obj = SaveMethodBenchmark.new
obj.csv_load('/media/asus/Ann/Films')
