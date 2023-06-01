# questionnaire
A dynamic questionnaire, with a simple json-server backend

To set a backend server - see https://github.com/typicode/json-server

Example of content for json file:

{
  "questions": [
    {
      "id": 1,
      "questionNumber": 1,
      "text": "What language is your favorite?",
      "type": "multipleChoice",
      "options": [
        "Kotlin",
        "Java",
        "C++"
      ],
      "isRequired": true
    },
    {
      "id": 2,
      "questionNumber": 2,
      "text": "What do you like about programing?",
      "type": "text",
      "isRequired": false
    },
    {
      "id": 3,
      "questionNumber": 3,
      "text": "How was the assignment?",
      "type": "singleChoice",
      "options": [
        "Easy",
        "Normal",
        "Hard",
        "Other"
      ],
      "isRequired": true
    }
  ],
  "answers": []
}
