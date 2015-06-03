require 'net/http'
# require_relative "../db/setup"
# require_relative "todo"
require 'json'
require 'uri'

class TodoApp

  def start
    loop do
      @uri = URI('http://localhost:3000/todos')
      @todos = Net::HTTP.get(@uri)


      seperate_todos
      view_todos

      puts
      puts "What would you like to do?"
      puts "(1) Exit \n(2) Add Todo \n(3) Mark Todo As Complete \n(4) Edit Existing Todo \n(5) Delete Existing Todo"
      print " > "
      action = gets.chomp.to_i
      case action
      when 1 then exit
      when 2 then add_todo
      when 3 then mark_todo
      when 4 then edit_todo
      when 5 then delete_todo
      else
        puts "\a"
        puts "Not a valid choice"
      end
    end
  end

  def add_todo
    puts "What is it you need todo? > "
    Net::HTTP.post_form(@uri, {'body' => get_input })
  end

  def view_todos
    system('clear')
    puts "-------____________-------"
    puts "------| TODO-LIST  |------"
    print "-------", "\u203E" * 12, "-------"
    puts "\n       ____________"
    puts "------- Incomplete -------"
    print "       ", "\u203E" * 12, "\n"
    @incomplete_todos.each_with_index do |item, index|
      puts "#{index + 1}) #{item['body']}"
    end
    puts "\n       ____________"
    puts "------- Completed  -------"
    print "       ", "\u203E" * 12, "\n"
    @complete_todos.each_with_index do |item, index|
      puts "#{index + 1}) #{item['body']}"
    end

  end

  def mark_todo
    puts "which todo would you like to mark todone? > (#) "
    index = (get_input.to_i - 1)
    index_id = @incomplete_todos[index]

    update(index_id, {'complete' => 'true'})
  end

  def delete_todo
    puts "Delete completed(1) or incompleted(2)? > (#) "
    which = get_input.to_i
    puts "Which todo would you like to delete? > (#) "

    if which == 1
      index_id = @complete_todos[get_input.to_i - 1]
      delete(index_id)
    elsif which == 2
      index_id = @incomplete_todos[get_input.to_i - 1]
      delete(index_id)
    else
      puts "invalid choice, please try again"
      delete_todo
    end

  end

  def edit_todo
    puts "Edit completed(1) or incomplete(2) ? > (#) "
    which = get_input.to_i

      if which == 1
        edit_todo_values(@complete_todos)
      elsif which == 2
        edit_todo_values(@incomplete_todos)
      else
        puts "invalid choice, please try again"
        edit_todo
      end

  end

  def edit_todo_values(array)
    puts "Which one would you like to edit? > (#) "
    index_id = array[get_input.to_i - 1]
    puts "What should it be? > "
    update(index_id, { 'body' => get_input })
  end

  def seperate_todos
    @incomplete_todos = []
    @complete_todos = []

    JSON.parse(@todos).each do |k|
      if k['complete'] == false
        @incomplete_todos << k
      else
        @complete_todos << k
      end

    end
  end

  def update(index_id, params = {})
    uri = URI.parse("http://localhost:3000/todos/#{index_id['id'].to_s}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.request_uri)
    request.set_form_data(params)
    http.request(request)
  end

  def delete(index_id)
    uri = URI("http://localhost:3000/todos/#{index_id['id'].to_s}")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Delete.new(uri.path)
    http.request(req)
  end

  private
  def get_input
    gets.chomp
  end

end
TodoApp.new.start
