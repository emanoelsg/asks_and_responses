Asks and Responses App

This is a Full Stack project developed using Flutter on the frontend and Node.js on the backend to manage the creation and viewing of questions and answers.

🚀 About the Project

The "Asks and Responses App" is a simple platform where users can post questions and receive answers from the community. The development focus was on implementing a clean and functional architecture, ensuring efficient and secure communication between the mobile client and the server.

✨ Features

Posting Questions: Users can submit new questions.

Viewing Questions: Displays a list of questions, ordered by most recent.

Detailed View: Displays a specific question with all its related answers.

Posting Answers: Users can answer any existing question.

💻 Technology Stack

Layer

Technology

Details

Frontend

Flutter (Dart)

Mobile application developed with the Clean Architecture pattern (Separation into Domain, Data, and Presentation).

Backend

Node.js / Express.js

RESTful API server for data manipulation.

Database

MySQL

Relational database.

ORM

Sequelize

Object-Relational Mapping with definition of One-to-Many associations (Question has many Answers).

🏗️ Architecture and Modeling

The project uses a modular structure to ensure maintainability:

Relational Modeling: Implementation of the association between the questions and answers tables using Foreign Keys (questionId).

Circular Dependency Resolution: Sequelize associations were defined in a centralized file to avoid module loading problems (circular dependency).

Communication: Flutter communicates with Node.js using HTTP requests (GET, POST) for CRUD (Create, Read, Update, Delete) data operations.

⚙️ How to Set Up and Run the Project

To run this project, you will need to have Node.js and Flutter installed.

Backend (Node.js)

Navigate to the back/ directory:

cd back

Install the dependencies:

npm install

Database Configuration:

Create a MySQL database called guiaperguntas.

Verify and adjust the connection credentials in the database/database.js file.

Start the Server:

`npx nodemon src/index.js`
# The server will run on port 6147 (http://localhost:6147)

Frontend (Flutter)

Navigate to the frontend/ directory:

`cd ../frontend`

Install the Dart dependencies:

`flutter pub get`

Adjust the API IP:

In the file `frontend/lib/src/data/datasources/pergunta_remote_datasource.dart` (or similar), adjust the baseUrl.

For Android Emulator: use http://10.0.2.2:6147

For Physical Device: use http://[YOUR_LOCAL_IP]:6147

Run the App:

`flutter run`
