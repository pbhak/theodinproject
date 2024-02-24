import { renderProject } from "./dom.js";

export const projects = {
  Main: [],  
};

if (localStorage.allTodos) {
  for (let i = 0; i < JSON.parse(localStorage.allTodos).length; i++) {
    const todo = JSON.parse(localStorage.allTodos)[i];
    for (const project in projects) {
      if (todo.project === project) {
        projects[project].push(todo);
      }
    }
  }
}

export function addToProject(todo, project) {
  projects[project].push(todo);
  renderProject(project);
  return true;
}

export function newProject(project) {
  if (project in projects) {
    return 'Already exists!';
  } else {
    projects[project] = [];
    return projects[project];
  }
}