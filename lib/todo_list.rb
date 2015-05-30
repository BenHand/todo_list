require_relative "../db/setup"
require_relative "todo"


class TodoList

  def start
    loop do
      @todos = Todo.all
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
    puts "What is the todo you need to do? > "
    Todo.create(entry: get_input)
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
      puts "#{index + 1}) #{item.entry}"
    end
    puts "\n       ____________"
    puts "------- Completed  -------"
    print "       ", "\u203E" * 12, "\n"
    @complete_todos.each_with_index do |item, index|
      puts "#{index + 1}) #{item.entry}"
    end

  end

  def mark_todo
    puts "which todo would you like to mark todone? > (#) "
    index = (get_input.to_i - 1)
    entry_id = @incomplete_todos[index].id
    Todo.update(entry_id, completed: true)
  end

  def delete_todo
    puts "Delete completed(1) or incompleted(2)? > (#) "
    which = get_input.to_i
    puts "Which todo would you like to delete? > (#) "
    if which == 1
      index_id = @complete_todos[get_input.to_i - 1].id
      Todo.find(index_id).destroy
    else
      index_id = @incomplete_todos[get_input.to_i - 1].id
      Todo.find(index_id).destroy
    end
  end

  def edit_todo
    puts "Edit completed(1) or incomplete(2) ? > (#) "
    which = get_input.to_i

      if which == 1
        puts "Which one would you like to edit? > (#) "
        index_id = @complete_todos[get_input.to_i - 1].id
        puts "What should it be? > "
        Todo.update(index_id, entry: get_input)
      else
        puts "Which one would you like to edit? > (#) "
        index_id = @incomplete_todos[get_input.to_i - 1].id
        puts "What should it be? > "
        Todo.update(index_id, entry: get_input)
      end

  end

  def seperate_todos
    @incomplete_todos = []
    @complete_todos = []

    @todos.each do |item|
      if item.completed == false
        @incomplete_todos << item
      else
        @complete_todos << item
      end
    end

  end

  private
  def get_input
    gets.chomp
  end

end
