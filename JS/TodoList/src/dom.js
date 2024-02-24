import { formatRelative } from 'date-fns';
import { projects, newProject } from './projects';
import { Todo } from './todo';

let todoNames = ['description', 'due date', 'priority', 'notes'];
const todoDiv = document.getElementById('todos');
const br = () => document.createElement('br');
const modalDiv = document.createElement('div');
const infoDiv = document.createElement('div');

(function renderButtons() {
  // Project button
  let projectName = '';
  let projectButton = document.createElement('button');
  projectButton.textContent = 'new project';
  projectButton.style.backgroundColor = '#1b4545';
  projectButton.onclick = () => {
    projectName = prompt('Project name?');
    if (projectName === '' || projectName in projects) {
      alert('Invalid!');
    } else {
      newProject(projectName);
      updateProjectDropdown();
    }
  };
  document.getElementById('projects').appendChild(projectButton);

  // Todo button
  let todoButton = document.createElement('button');
  todoButton.style.backgroundColor = '#008080';
  todoButton.textContent = 'new todo';
  todoButton.onclick = () => renderModal();
  document.getElementById('projects').appendChild(todoButton);
})();

(function todoModal() {
  modalDiv.className = 'todo-modal';
  modalDiv.id = 'modal';

  const modalForm = document.createElement('form');
  modalForm.className = 'todo-modal-content animate';
  modalForm.id = 'modal-form';
  modalForm.onsubmit = (event) => {
    event.preventDefault();
    let data = new FormData(document.getElementById('modal-form'));
    let values = [];
    for (const entry of data.entries()) {
      const [, v] = entry;
      values.push(v);
    }
    values.push(document.getElementById('project').value);
    new Todo(values[0], values[1], values[2], values[3], values[4], values[5]);
    modalDiv.style.display = 'none';
    // todoDiv.innerHTML = '';
    renderTodos();
  };

  const modalContainer = document.createElement('div');

  const header = document.createElement('h3');
  header.textContent = 'New todo';
  header.style.textAlign = 'center';

  modalContainer.appendChild(header);

  const titleLabel = document.createElement('label');
  titleLabel.innerHTML = `<b>Title: </b>`;
  titleLabel.setAttribute('for', 'title');

  const titleInput = document.createElement('input');
  titleInput.setAttribute('type', 'text');
  titleInput.id = 'title';
  titleInput.name = 'title';
  titleInput.setAttribute('placeholder', `Enter title`);
  titleInput.required = true;

  modalContainer.appendChild(titleLabel);
  modalContainer.appendChild(titleInput);

  titleInput.addEventListener('input', () => {
    if (titleInput.value === '') {
      header.textContent = 'New todo';
    } else {
      header.textContent = titleInput.value;
    }
  });

  for (let j = 0; j < todoNames.length; j++) {
    const label = document.createElement('label');
    label.innerHTML = `<b>${
      todoNames[j].charAt(0).toUpperCase() + todoNames[j].slice(1)
    }: </b>`;
    label.setAttribute('for', todoNames[j]);

    const input = document.createElement('input');
    if (todoNames[j] === 'due date') {
      input.setAttribute('type', 'datetime-local');
      input.onclick = () => openPicker();
    } else {
      input.setAttribute('type', 'text');
    }
    input.id = todoNames[j];
    input.name = todoNames[j];
    input.setAttribute('placeholder', `Enter ${todoNames[j]}`);
    input.required = true;

    modalContainer.appendChild(label);
    modalContainer.appendChild(input);
  }

  const projectLabel = document.createElement('label');
  projectLabel.innerHTML = `<b>Project: </b>`;
  projectLabel.setAttribute('for', 'project');

  const projectSelect = document.createElement('select');
  projectSelect.id = 'project';
  projectSelect.required = true;

  document.addEventListener('DOMContentLoaded', () => {
    for (const project in projects) {
      const option = document.createElement('option');
      option.textContent = project;
      option.value = project;
      projectSelect.appendChild(option);
    }
  });

  modalContainer.appendChild(projectLabel);
  modalContainer.appendChild(projectSelect);

  const footerDiv = document.createElement('footer');
  footerDiv.id = 'modal-footer';

  const cancelButton = document.createElement('button');
  cancelButton.textContent = 'Cancel';
  cancelButton.onclick = () => (modalDiv.style.display = 'none');
  cancelButton.id = 'cancel';
  cancelButton.type = 'button';

  const createButton = document.createElement('input');
  createButton.value = 'Create';
  createButton.type = 'submit';
  createButton.id = 'create';

  footerDiv.appendChild(createButton);
  footerDiv.appendChild(cancelButton);

  modalContainer.style.padding = '10px';

  modalForm.appendChild(modalContainer);
  modalForm.appendChild(footerDiv);
  modalDiv.appendChild(modalForm);

  document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('projects').appendChild(modalDiv);
    modalDiv.onclick = (event) => {
      if (event.target === modalDiv) {
        modalDiv.style.display = 'none';
      }
    };
  });
})();

(function infoModal() {
  infoDiv.className = 'todo-modal';
  infoDiv.id = 'modal';

  const modalForm = document.createElement('form');
  modalForm.className = 'todo-modal-content animate';
  modalForm.id = 'modal-form';
  modalForm.onsubmit = (event) => {
    event.preventDefault();
    let data = new FormData(document.getElementById('modal-form'));
    let values = [];
    for (const entry of data.entries()) {
      const [, v] = entry;
      values.push(v);
    }
    values.push(document.getElementById('project').value);
    new Todo(values[0], values[1], values[2], values[3], values[4], values[5]);
    infoDiv.style.display = 'none';
    // todoDiv.innerHTML = '';
    renderTodos();
  };

  const modalContainer = document.createElement('div');

  const header = document.createElement('h3');
  header.textContent = 'New todo';
  header.style.textAlign = 'center';

  modalContainer.appendChild(header);

  const titleLabel = document.createElement('label');
  titleLabel.innerHTML = `<b>Title: </b>`;
  titleLabel.setAttribute('for', 'title');

  const titleInput = document.createElement('input');
  titleInput.setAttribute('type', 'text');
  titleInput.id = 'title';
  titleInput.name = 'title';
  titleInput.setAttribute('placeholder', `Enter title`);
  titleInput.required = true;

  modalContainer.appendChild(titleLabel);
  modalContainer.appendChild(titleInput);

  titleInput.addEventListener('input', () => {
    if (titleInput.value === '') {
      header.textContent = 'New todo';
    } else {
      header.textContent = titleInput.value;
    }
  });

  for (let j = 0; j < todoNames.length; j++) {
    const label = document.createElement('label');
    label.innerHTML = `<b>${
      todoNames[j].charAt(0).toUpperCase() + todoNames[j].slice(1)
    }: </b>`;
    label.setAttribute('for', todoNames[j]);

    const input = document.createElement('input');
    if (todoNames[j] === 'due date') {
      input.setAttribute('type', 'datetime-local');
      input.onclick = () => openPicker();
    } else {
      input.setAttribute('type', 'text');
    }
    input.id = todoNames[j];
    input.name = todoNames[j];
    input.setAttribute('placeholder', `Enter ${todoNames[j]}`);
    input.required = true;

    modalContainer.appendChild(label);
    modalContainer.appendChild(input);
  }

  const projectLabel = document.createElement('label');
  projectLabel.innerHTML = `<b>Project: </b>`;
  projectLabel.setAttribute('for', 'project');

  const projectSelect = document.createElement('select');
  projectSelect.id = 'project';
  projectSelect.required = true;

  document.addEventListener('DOMContentLoaded', () => {
    for (const project in projects) {
      const option = document.createElement('option');
      option.textContent = project;
      option.value = project;
      projectSelect.appendChild(option);
    }
  });

  modalContainer.appendChild(projectLabel);
  modalContainer.appendChild(projectSelect);

  const footerDiv = document.createElement('footer');
  footerDiv.id = 'modal-footer';

  const cancelButton = document.createElement('button');
  cancelButton.textContent = 'Cancel';
  cancelButton.onclick = () => (infoDiv.style.display = 'none');
  cancelButton.id = 'cancel';
  cancelButton.type = 'button';

  const createButton = document.createElement('input');
  createButton.value = 'Create';
  createButton.type = 'submit';
  createButton.id = 'create';

  footerDiv.appendChild(createButton);
  footerDiv.appendChild(cancelButton);

  modalContainer.style.padding = '10px';

  modalForm.appendChild(modalContainer);
  modalForm.appendChild(footerDiv);
  infoDiv.appendChild(modalForm);

  document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('projects').appendChild(infoDiv);
    infoDiv.onclick = (event) => {
      if (event.target === infoDiv) {
        infoDiv.style.display = 'none';
      }
    };
  });
})();

function renderModal() {
  modalDiv.style.display = 'block';
  console.log('rendering');
}

function renderInfoModal(todo) {
  infoDiv.style.display = 'block';

  const modal = document.querySelector('.todo-modal:nth-of-type(2)');

  console.log('rendering info');

  modal.querySelector('#title').setAttribute('value', todo.title);
  modal.querySelector('#description').setAttribute('value', todo.description);
  modal.querySelector('#due\\ date').setAttribute('value', todo.dueDate);
  modal.querySelector('#priority').setAttribute('value', todo.priority);
  modal.querySelector('#notes').setAttribute('value', todo.notes);
  modal.getElementsByTagName(
    'h3'
  )[0].textContent = `View/edit information for todo "${todo.title}"`;

  for (let i = 0; i < modal.getElementsByTagName('option').length; i++) {
    let element = modal.getElementsByTagName('option')[i];
    if (element.textContent === todo.project) {
      element.selected = true;
    } else {
      continue;
    }
  }
}

export function renderProject(project) {
  let projectDiv = document.getElementById('projects');
  const newProjectDiv = document.createElement('div');
  newProjectDiv.className = `project`;
  newProjectDiv.id = projects[project];

  for (let i = 0; i < projects[project].length; i++) {
    for (const key in projects[project][i]) {
      newProjectDiv.innerHTML =
        newProjectDiv.innerHTML +
        '<br>' +
        `${key.charAt(0).toUpperCase() + key.slice(1)}: ` +
        projects[project][i][key];
    }
  }

  projectDiv.appendChild(newProjectDiv);
}

function updateProjectDropdown() {
  const projectSelect = document.getElementById('project');
  projectSelect.innerHTML = ''; // Clear existing options

  for (const project in projects) {
    const option = document.createElement('option');
    option.textContent = project;
    projectSelect.appendChild(option);
  }
}

function renderTodos() {
  todoDiv.innerHTML = '';

  for (const project in projects) {
    const header = document.createElement('h3');
    header.textContent = project;
    todoDiv.appendChild(header);

    const projectTodos = projects[project];
    for (let i = 0; i < projectTodos.length; i++) {
      const todo = projectTodos[i];
      const id = i + 1;
      const todoDisplay = document.createElement('input');
      const todoLabel = document.createElement('label');
      const editSpan = document.createElement('i');
      const deleteSpan = document.createElement('i');

      todoLabel.setAttribute('for', `todo${id}`);
      todoLabel.innerHTML = `${todo.title} (due ${formatRelative(
        todo.dueDate,
        new Date()
      )}) &nbsp;&nbsp;&nbsp;`;

      todoDisplay.type = 'checkbox';
      todoDisplay.className = 'todo';
      todoDisplay.id = `todo${id}`;
      todoDisplay.style.marginLeft = '25px';

      editSpan.id = 'edit';
      editSpan.textContent = '(edit)   ';

      editSpan.onclick = (event) => {
        renderInfoModal(todo);
      };

      deleteSpan.id = 'delete';
      deleteSpan.textContent = '(delete)';

      deleteSpan.onclick = () => {
        const allTodos = JSON.parse(localStorage.allTodos);

        const index = allTodos.findIndex((storedTodo) => {
          return (
            storedTodo.title === todo.title &&
            storedTodo.dueDate === todo.dueDate
          );
        });

        allTodos.splice(index, 1);

        localStorage.allTodos = JSON.stringify(allTodos);
        projects[project].splice(projects[project].indexOf(todo), 1);

        renderTodos();
      };
      todoDiv.appendChild(todoDisplay);
      todoDiv.appendChild(todoLabel);
      todoDiv.appendChild(editSpan);
      todoDiv.appendChild(deleteSpan);
      todoDiv.appendChild(br());
      todoDiv.appendChild(br());
    }
  }
}

document.addEventListener('DOMContentLoaded', () => {
  if (localStorage.allTodos) renderTodos();
});

function openPicker() {
  document.getElementById('due date').click();
}
