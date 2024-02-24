import homeDiv from './home.js'
import menuDiv from "./menu.js";
import infoDiv from "./contact.js";

function createButtons () {
  homeButton.textContent = 'Home';
  menuButton.textContent = 'Menu';
  infoButton.textContent = 'Contact';

  contentDiv.appendChild(homeButton);
  contentDiv.appendChild(menuButton);
  contentDiv.appendChild(infoButton);
};

const contentDiv = document.getElementById('content');

const homeButton = document.createElement('button');
const menuButton = document.createElement('button');
const infoButton = document.createElement('button');

createButtons()
contentDiv.appendChild(homeDiv);

homeButton.onclick = () => {
  contentDiv.innerHTML = '';
  createButtons();
  contentDiv.appendChild(homeDiv);
};

menuButton.onclick = () => {
  contentDiv.innerHTML = '';
  createButtons();
  menuDiv.style.display = 'block';
  contentDiv.appendChild(menuDiv);
};

infoButton.onclick = () => {
  contentDiv.innerHTML = '';
  createButtons();
  infoDiv.style.display = 'block';
  contentDiv.appendChild(infoDiv);
};