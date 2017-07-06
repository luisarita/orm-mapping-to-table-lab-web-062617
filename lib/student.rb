class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  attr_reader :id, :name, :grade
  def initialize(name, grade)
    @name, @grade = name, grade
  end

  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT);"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students;"
    DB[:conn].execute(sql)
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?, ?);"
    DB[:conn].execute(sql, @name, @grade)
    sql = "SELECT last_insert_rowid()"
    @id = DB[:conn].execute(sql)[0][0]
  end
  
  def self.create(values)
    new_student = Student.new(values[:name], values[:grade])
    new_student.save
    new_student
  end
  

  
end
