class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_reader :name, :grade, :id
  def initialize(id = 1,name, grade)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    );
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students;
    SQL

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade) VALUES (?,?);
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create(student_hash={})
    new_student = Student.new(student_hash[:id], student_hash[:name], student_hash[:grade])
    new_student.save
    new_student
  end

end
