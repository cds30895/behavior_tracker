# Behavior Tracker  

Developed By: Chris Smith

This program is designed to track the behaviors of students in Special Education Programs.  It currently consists of a database, local server, and http client, but was designed with future frontend integration in mind.  

In the field of Special Education, data is extremely important.  All students with Individualized Education Plans have specific goals that are monitored and periodically measured.  Goals can be based on many areas, including academic, social, behavioral, adaptive, and others.  This program specifically is designed for students with behavior needs.  

With data gathered with my program, patterns, difficulties, and progress can all be identifed.  Perhaps a student really struggles in music class, but only when they are with a specific staff member.  Maybe hallway transitions are tough for multiple students.  It might be that a student has less severe behaviors on the playground when two adults are watching instead of just one.  The data may also show that a student was physically aggressive at the start of the year, but now is only verbally aggressive, indicating progress!  

It is my hope that this project can be helpful to educators looking for a comprehensive data collection solution.  

## Setup

### Test Data
By default, the docker-compose.yml file includes the command "python bt_fake_data.py", which populates the database with some test data.  You may choose to delete this command for a blank database, but leave the rest of the commands intact - "flask db upgrade" creates the structure of the database, "python seed.py" populates some tables with default vaules, and "flask run --host:0.0.0.0" runs the flask server.

### Startup

Ensure Docker Desktop is running.  In the portfolio_project/flask directory, enter the following command:

    docker build . ; cd .. ; docker compose build ; docker compose up -d

The containers may take some time to start.  When they are fully started, you can access pgadmin at http://localhost:5432, and you can make GET, POST, PATCH, and DELETE HTTP requests using Insomnia or a similar app at http://localhost:5000 using the routes defined below in the Endpoints section.

## Endpoints

### behaviors

#### index()
A GET request with the route of /behaviors returns an index of all behaviors in the database, including the PK id, student, date, start and end time, and text fields for behavioral descriptions not included in the default numerical list.  

#### show()
A GET request with the route of /behaviors/<int:id> returns the information of a single behavioral incident, referenced by PK id.  

#### show_by_student()
A GET request with the route of /behaviors/by_student/<int:id> returns all behavior incidents that are related to a single student, identified by PK id.  

#### create()
A POST request with the route of /behaviors accepts a .json formatted file, requiring student, date, start and end time, antecedent, behavior_desc, consequence, and observing staff.  Other text fields, location, activity, and setting data are optional, but if any required elements are missing, the client will get a 400 error.  

A new Behavior() object will be created with attributes provided in the request.json, as well as any bridge table objects that data is provided for, and the objects are added to the session and committed to the database.  A .json representation of all relevant information provided on the behavior incident is returned to the client.  

#### delete()
A DELETE request with the route of /behaviors/<int:id> first checks to see if a behavior incident exists with the id provided, then attempts to delete the record.  It returns True if the operation is successful, or False if it is not.  

#### update()
A PATCH request with the route of /behaviors/<int:id> first checks to see if a behavior incident exists with the id provided, then assigns new values to the attributes included in the request.json.  It commits the changes to the database and returns a .json representation of all relevant information on the behavior incident to the client.  

#### helper function: retrieve_behavior_info()
This helper function runs a series of join operations to collate all the relevant information a person might want on a behavior incident.  Specifically, it follows all of the foreign keys associated with the behavior bridge tables to retrieve useable data, like the student's name, the text description of observed behaviors, the locations and settings it occured in, and observing staff.  It returns a dictionary of this data and is used in the index(), show(), and show_by_student() functions.  


### staff

#### index()
A GET request with the route of /staff returns an index of all staff in the database, including their PK id, first and last name, and email.  

#### show()
A GET request with the route of /staff/<int:id> returns the information of a single staff member, referenced by PK id.  

#### create()
A POST request with the route of /staff accepts a .json formatted file, requiring first and last name.  Email is optional, but if either part of the name is missing, the client will get a 400 error.  

A new Staff() object will be created with attributes provided in the request.json, and the object is added to the session and committed to the database.  A serialized .json representation of the object is returned to the client.  

#### delete()
A DELETE request with the route of /staff/<int:id> first checks to see if a staff member exists with the id provided, then attempts to delete the record.  It returns True if the operation is successful, or False if it is not.  

#### update()
A PATCH request with the route of /staff/<int:id> first checks to see if a staff member exists with the id provided, then assigns new values to the attributes included in the request.json.  It commits the changes to the database and returns a serialized .json representation of the object to the client.  


### students

#### index()
A GET request with the route of /students returns an index of all students in the database, including their PK id, student id, first and last name, grade, and case manager.  

#### show()
A GET request with the route of /students/<int:id> returns the information of a single student, referenced by PK id.  

#### create()
A POST request with the route of /students accepts a .json formatted file, requiring first and last name, grade, and case manager.  Student id is optional, but if any other element is missing, the client will get a 400 error.  

A new Student() object will be created with attributes provided in the request.json, and the object is added to the session and committed to the database.  A serialized .json representation of the object is returned to the client.  

#### delete()
A DELETE request with the route of /students/<int:id> first checks to see if a student exists with the id provided, then attempts to delete the record.  It returns True if the operation is successful, or False if it is not.  

#### update()
A PATCH request with the route of /students/<int:id> first checks to see if a student exists with the id provided, then assigns new values to the attributes included in the request.json.  It commits the changes to the database and returns a serialized .json representation of the object to the client.  


## Retrospective

### Evolution Over Time
Initially I didn't think this project would be quite so complex...  As I started to quantify the relationships between the entities I was interested in, I realized I was going to be dealing with a lot of bridge tables.  Then it dawned on me that I'd also soon be dealing with a lot of JOIN statements as well.  

Initially I wrote out the database structure in a .sql file.  I rewrote it pieces at a time as we learned to use alchemy to keep track of changes.  As we went on, I saw the benefit of learning to use an ORM.  I'll get into that decision more in the next section, but I essentially rebuilt the database again from scratch using sqlalchemy and flask.  

At this point I would consider the project to be still in development.  I'm still working on my endpoints and how I want them to behave.  I still have a lot to learn about ORM syntax and functions, and I think as I learn I'll continue to tweak things to be more efficient, more Pythonic, and more clear to the reader.  

### ORM vs Raw SQL
When it came time to choose SQL vs ORM, I chose ORM in part because I was less comfortable with it.  My hope was that I would become more familiar as I continued to work, and I think that has been the case though I'm by no means an expert.  I still feel like I'm fumbling in the dark a bit.  

I really like the clarity and simplicity of Raw SQL.  There is an order that commands go in, and it's very linear from the top down in terms of the instructions you're giving the computer.  

When it comes to ORMs, I like the return to Pythonic structure.  I like how easy it is to define a function I want to use again, and the complexity and flow that can come with abstraction.  

I feel like if I had worked in raw SQL, I would have avoided a lot of headaches.  The documentation is written in a straightforward way, but it's hard to find the functions I want when I don't necessarily have the vocabulary to know what to search for.  All the same, I think the practice with ORMs has served me well.  

### Future Plans
I'd like to continue to work on my endpoints until I have a really clean backend interface.  Then I'd like to learn how to implement a simple frontend.  I want this program to be useful to educators, and I don't expect them to input data through Insomnia or a CLI.  I want a frontend with text fields for new students and staff, a drop down menu to indicate which student belongs to a particular behavior incident, and checkboxes for all my one-to-many relationships.  

I would love to learn more about creating apps for android or iOS and turn this idea into a simple to use app.  I think that has the greatest chance to be useful and accessible to educators.