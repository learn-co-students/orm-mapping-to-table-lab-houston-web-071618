class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id
  # Each individual student will have two attributes, a name(attr_accessor) and a grade (attr_accessor), i.e. 9th, 10th, 11th, etc. and optional id (attr_reader), default value of the id argument should be set to nil
  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  # class method on the Student class that creates the students table in the database,
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

 DB[:conn].execute(sql)
  end

  # a method that can drop that table
  def self.drop_table
    sql =
    "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  # a method, #save, that can save the data concerning an individual student object to the Database
  def save

    sql = <<-SQL
    INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  # both creates a new instance of the student class and then saves it to the database.
  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end

end
