class Student
	attr_accessor :name, :grade

	attr_reader :id

	def initialize(name, grade, id=nil)
		@name = name
		@grade = grade
	end

	def self.create_table
		sql = <<-SQL
			CREATE TABLE IF NOT EXISTS students (
				id INTEGER PRIMARY KEY,
				name TEXT,
				grade INTEGER
			);
			SQL

			DB[:conn].execute(sql)

	end

	def save

		sql = 'INSERT INTO students (name, grade) VALUES (?, ?)'
		DB[:conn].execute(sql, name, grade)
		# binding.pry
		sql = 'SELECT * FROM students WHERE name = (?) ORDER BY id DESC LIMIT 1'
		results = DB[:conn].execute(sql, name)
  	# binding.pry
		@id = results[0].first

	end

	def self.drop_table
		sql = 'DROP TABLE students;'
		DB[:conn].execute(sql)

	end

	def self.create(name:, grade:)
 		student = self.new(name, grade)
 		student.save
 		student
	end

end
