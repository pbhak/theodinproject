import { addToProject, newProject, projects } from "./projects.js";

export class Todo {
  static initStorage() {
    if (!localStorage.allTodos) {
      localStorage.allTodos = JSON.stringify([]);
    }
  }

  constructor(
    title,
    description,
    dueDate,
    priority,
    notes,
    project = "default"
  ) {
    Todo.initStorage();

    this.title = title;
    this.description = description;
    this.dueDate = dueDate;
    this.priority = priority;
    this.notes = notes;
    this.project = project;

    projects[project].push(this);

    const allTodos = JSON.parse(localStorage.allTodos);
    allTodos.push(this);
    localStorage.allTodos = JSON.stringify(allTodos);
  }
}